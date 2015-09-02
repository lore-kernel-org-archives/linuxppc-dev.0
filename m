Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0139.outbound.protection.outlook.com [65.55.169.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 241971A1EFE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 12:30:49 +1000 (AEST)
Message-ID: <1441161032.4966.123.camel@freescale.com>
Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Tue, 1 Sep 2015 21:30:32 -0500
In-Reply-To: <SN1PR0301MB1550B83E62EAEB41C4387A0F9B690@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
 <1441011520-15424-2-git-send-email-qiang.zhao@freescale.com>
 <1441154062.4966.113.camel@freescale.com>
 <SN1PR0301MB1550B83E62EAEB41C4387A0F9B690@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-01 at 21:22 -0500, Zhao Qiang-B45475 wrote:
> On Wed, 2015-09-02 at 8:34AM +0800, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 02, 2015 8:34 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage
> > muram
> > 
> > On Mon, 2015-08-31 at 16:58 +0800, Zhao Qiang wrote:
> > 
> > > -int cpm_muram_init(void)
> > > -{
> > > -     struct device_node *np;
> > > -     struct resource r;
> > > -     u32 zero[OF_MAX_ADDR_CELLS] = {};
> > > -     resource_size_t max = 0;
> > > -     int i = 0;
> > > -     int ret = 0;
> > > -
> > > -     if (muram_pbase)
> > > -             return 0;
> > > -
> > > -     spin_lock_init(&cpm_muram_lock);
> > > -     /* initialize the info header */
> > > -     rh_init(&cpm_muram_info, 1,
> > > -             sizeof(cpm_boot_muram_rh_block) /
> > > -             sizeof(cpm_boot_muram_rh_block[0]),
> > > -             cpm_boot_muram_rh_block);
> > > -
> > > -     np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
> > > -     if (!np) {
> > > -             /* try legacy bindings */
> > > -             np = of_find_node_by_name(NULL, "data-only");
> > > -             if (!np) {
> > > -                     printk(KERN_ERR "Cannot find CPM muram data
> > node");
> > > -                     ret = -ENODEV;
> > > -                     goto out;
> > > -             }
> > > -     }
> > > -
> > > -     muram_pbase = of_translate_address(np, zero);
> > > -     if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
> > > -             printk(KERN_ERR "Cannot translate zero through CPM muram
> > node");
> > > -             ret = -ENODEV;
> > > -             goto out;
> > > -     }
> > 
> > Did you pass -M -C to git format-patch?
> 
> 
> Yes!

Then maybe it's the qe/cpm rename churn, or similar, that prevented it from 
being identified as a move?

-Scott
