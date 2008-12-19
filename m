Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 5EEEFDDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 19:30:38 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LDakk-0002xa-Eb
	for linuxppc-dev@ozlabs.org; Fri, 19 Dec 2008 00:30:34 -0800
Message-ID: <21087541.post@talk.nabble.com>
Date: Fri, 19 Dec 2008 00:30:34 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
In-Reply-To: <200812190856.19482.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <21070179.post@talk.nabble.com>
	<20081218190208.GC18201@yoda.jdub.homelinux.org>
	<21087072.post@talk.nabble.com> <200812190856.19482.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Stefan Roese wrote:
> 
> 
>> Is this an expected behavior - detection of 256 MiB NAND flash
>> takes around 20 seconds. The ndfc driver works fine after boot.
> 
> No, 20 seconds is definitely too long. Something must be wrong with the
> ndfc 
> driver or the NAND dts entries.
> 
> Best regards,
> Stefan
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

Thanks, Stefan

My ndfc DTS entry looks like this

nand@3,0 {
    compatible = "amcc,ndfc";
    reg = <0x00000003 0x00000000 0x00002000>;
    ccr = <0x00001000>;
    bank-settings = <0x80002222>;
    #address-cells = <1>;
    #size-cells = <1>;

    partition@0 {
        label = "data";
        reg = <0x00000000 0x10000000>;
    };
};

I also had to modify u-boot to provide ndfc ebc mappings.
Not sure if it's the best solution, but it worked. Sorry for
posting u-boot stuff here, I'll stop doing that if list thinks
it's irrelevant.

My u-boot code looks like this (modified canyonlands code):

void ft_board_setup(void *blob, bd_t *bd)
{
        u32 val[8];
        int rc;

        ft_cpu_setup(blob, bd);

        /* Fixup NOR mapping */
        val[0] = 0;                             /* chip select number */
        val[1] = 0;                             /* always 0 */
        val[2] = CFG_FLASH_BASE_PHYS_L;         /* we fixed up this address
*/
        val[3] = gd->bd->bi_flashsize;

        /* Set NAND Controller mapping */
        val[4] = CFG_NAND_CS;                   /* chip select number */
        val[5] = 0;                                         /* always 0 */
        val[6] = CFG_NAND_ADDR;              /* NAND address */
        val[7] = 0x2000;                               /* NAND register area
size */

        rc = fdt_find_and_setprop(blob, "/plb/opb/ebc", "ranges",
                                  val, sizeof(val), 1);
        if (rc) {
                printf("Unable to update property NOR mapping, err=%s\n",
                       fdt_strerror(rc));
        }
}

Felix.

-- 
View this message in context: http://www.nabble.com/Long-boot-delay-on-460EX-with-2.6.28-rc8-tp21070179p21087541.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
