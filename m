Return-Path: <jirislaby@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 86C49DE36A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 07:45:42 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so449865fgg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 14:45:40 -0700 (PDT)
Message-ID: <47FFDBFF.1030809@gmail.com>
Date: Fri, 11 Apr 2008 23:45:35 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>
	<12053582231281-git-send-email-yorksun@freescale.com>
	<47D8572C.8090501@gmail.com>
In-Reply-To: <47D8572C.8090501@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ping.

Seeing this in -mm yet. Are those comments all wrong? Are you working on it?

On 03/12/2008 11:20 PM, Jiri Slaby wrote:
> On 03/12/2008 10:43 PM, York Sun wrote:
>> +static int fsl_diu_open(struct fb_info *info, int user)
>> +{
>> +    struct mfb_info *mfbi = info->par;
>> +    int res = 0;
>> +
>> +    spin_lock(&diu_lock);
>> +    mfbi->count++;
>> +    if (mfbi->count == 1) {
>> +        DPRINTK("open plane index %d\n", mfbi->index);
>> +        fsl_diu_check_var(&info->var, info);
>> +        fsl_diu_set_par(info);
> 
> Please retest your code (at least) with sleep-inside spinlock debug 
> option. If I see correctly you call GFP_KERNEL allocation somewhere 
> deeper in this function, which might sleep.
> 
>> +        res = fsl_diu_enable_panel(info);
>> +        if (res < 0)
>> +            mfbi->count--;
>> +    }
>> +
>> +    spin_unlock(&diu_lock);
>> +    return res;
>> +}
> 
>> +static void __exit uninstall_fb(struct fb_info *info)
>> +{
>> +    struct mfb_info *mfbi = info->par;
>> +
>> +    DPRINTK("Entered: uninstall_fb\n");
> 
> You don't need this stuff everywhere (kprobes).
> 
>> +    if (!mfbi->registered)
>> +        return;
>> +
>> +    unregister_framebuffer(info);
>> +    unmap_video_memory(info);
>> +    if (&info->cmap)
>> +        fb_dealloc_cmap(&info->cmap);
>> +
>> +    mfbi->registered = 0;
>> +}
> [...]
>> +static int fsl_diu_probe(struct platform_device *pdev)
>> +{
>> +    struct mfb_info *mfbi;
>> +    unsigned long dummy_ad_addr;
>> +    int ret, i, error = 0;
>> +
>> +    DPRINTK("Entered: fsl_diu_probe\n");
>> +
>> +    /* Area descriptor memory pool aligns to 64-bit boundary */
>> +    allocate_buf(&pool.ad, sizeof(struct diu_ad) * FSL_AOI_NUM, 8);
>> +
>> +    /* Get memory for Gamma Table  - 32-byte aligned memory */
>> +    allocate_buf(&pool.gamma, 768, 32);
>> +
>> +    /* For performance, cursor bitmap buffer aligns to 32-byte 
>> boundary */
>> +    allocate_buf(&pool.cursor, MAX_CURS * MAX_CURS * 2, 32);
>> +
>> +    i = sizeof(fsl_diu_info) / sizeof(struct fb_info);
>> +    dummy_ad = (struct diu_ad *)((u32)pool.ad.vaddr + pool.ad.offset) 
>> + i;
>> +    dummy_ad->paddr = pool.ad.paddr + i * sizeof(struct diu_ad);
>> +    dummy_aoi_virt = fsl_diu_alloc(64, &dummy_ad_addr);
>> +    dummy_ad->addr = cpu_to_le32(dummy_ad_addr);
>> +    dummy_ad->pix_fmt = 0x88882317;
>> +    dummy_ad->src_size_g_alpha = cpu_to_le32((4 << 12) | 4);
>> +    dummy_ad->aoi_size = cpu_to_le32((4 << 16) |  2);
>> +    dummy_ad->offset_xyi = 0;
>> +    dummy_ad->offset_xyd = 0;
>> +    dummy_ad->next_ad = 0;
>> +    memset(dummy_aoi_virt, 0x00, 64);
>> +    write_reg(&(dr.diu_reg->desc[0]), dummy_ad->paddr);
>> +    write_reg(&(dr.diu_reg->desc[1]), dummy_ad->paddr);
>> +    write_reg(&(dr.diu_reg->desc[2]), dummy_ad->paddr);
>> +
>> +    for (i = 0; i < sizeof(fsl_diu_info) / sizeof(struct fb_info); 
>> i++) {
>> +        fsl_diu_info[i].fix.smem_start = 0;
>> +        mfbi = fsl_diu_info[i].par;
>> +        mfbi->ad = (struct diu_ad *)((u32)pool.ad.vaddr
>> +                    + pool.ad.offset) + i;
>> +        mfbi->ad->paddr = pool.ad.paddr + i * sizeof(struct diu_ad);
>> +        ret = install_fb(&fsl_diu_info[i], pdev);
>> +        if (ret) {
>> +            printk(KERN_ERR "Failed to register framebuffer %d\n",
>> +                    i);
>> +            return ret;
> 
> some kind of free here
> 
>> +        }
>> +    }
> [...]
>> +int __init fsl_diu_init(void)
>> +{
>> +    struct device_node *np;
>> +    struct resource r;
>> +    int error;
>> +    DPRINTK("Entered: fsl_diu_init\n");
>> +    np = of_find_compatible_node(NULL, NULL, "fsl-diu");
>> +    if (!np) {
>> +        printk(KERN_ERR "Err: can't find device node 'fsl-diu'\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    of_address_to_resource(np, 0, &r);
>> +    of_node_put(np);
>> +
>> +    DPRINTK("%s, r.start: 0x%08x\n", __func__, r.start);
>> +
>> +    dr.diu_reg = ioremap(r.start, sizeof(struct diu));
> 
> The arch never fails with remapping?
> 
>> +
>> +    write_reg(&(dr.diu_reg->diu_mode), 0);        /* disable DIU 
>> anyway*/
>> +
>> +    spin_lock_init(&dr.reg_lock);
>> +
>> +
>> +    /*
>> +     * For kernel boot options (in 'video=xxxfb:<options>' format)
>> +     */
>> +#ifndef MODULE
>> +    {
>> +        char *option;
>> +
>> +        if (fb_get_options("fslfb", &option))
>> +            return -ENODEV;
>> +        fsl_diu_setup(option);
>> +    }
>> +#endif
>> +    error = platform_driver_register(&fsl_diu_driver);
>> +
>> +    if (!error) {
>> +        error = platform_device_register(&fsl_diu_device);
>> +        if (error) {
>> +            printk(KERN_ERR "Err: "
>> +                    "can't register FB device driver!\n");
>> +            platform_driver_unregister(&fsl_diu_driver);
> 
> iounmap
> 
>> +        }
>> +        printk(KERN_INFO "FSL_DIU_FB: registed FB device driver!\n");
>> +    }
> 
> else iounmap
> 
>> +
>> +    return error;
>> +}
> [...]
>> diff --git a/drivers/video/fsl-diu-fb.h b/drivers/video/fsl-diu-fb.h
>> new file mode 100644
>> index 0000000..294d0bf
>> --- /dev/null
>> +++ b/drivers/video/fsl-diu-fb.h
>> @@ -0,0 +1,388 @@
> [...]
>> +#ifndef __FSL_DIU_FB_H__
>> +#define __FSL_DIU_FB_H__
>> +
>> +/* FIXME: This should be changed to dev_dbg this will be done as soon as
>> + * we can obtain dev through the dts setup
> 
> then use at least pr_debug() here:
> 
>> + */
>> +#ifdef DEBUG
>> +#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __func__, 
>> ## args)
>> +#else
>> +#define DPRINTK(fmt, args...)
>> +#endif
