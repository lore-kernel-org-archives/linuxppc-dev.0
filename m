Return-Path: <mikew@criticallink.com>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185]) by ozlabs.org (Postfix) with ESMTP id B1845B7CF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Feb 2010 06:12:36 +1100 (EST)
Received: by qyk15 with SMTP id 15so672102qyk.10
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Feb 2010 11:12:34 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 24 Feb 2010 14:12:33 -0500
Message-ID: <763e54b1002241112o7eb52767i69417bf2368c93b1@mail.gmail.com>
Subject: MPC8313 and IO mapping a localbus space.
From: Mike Williamson <michael.williamson@criticallink.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm working on implementing a linux 2.6.23 kernel for a machine based
on the MPC8313. It's
basically a clone of the Freescale ERDB dev kit module with the
addition of an FPGA on CS3 of the localbus.
(it also has NAND and a FLASH NOR part on the localbus as well).

All of the code is based off of the ltib BSP kit provided by
Freescale's 2008-12-22 release.

I am able to address the FPGA in u-boot using "md.w" as well as all
the other localbus devices.

However, when I load up linux, I can't seem to map in the FPGA and
read or write to it.  I don't bus error,
I just get zeros.

The driver code is pretty basic (below), and I've verified that the
LBLAWARx and LBLAWBARx registers
match what was set in u-boot.  I've also verified that the eLBC ORx
and BRx registers match.
The only thing that seems to be missing is that there aren't entries
in the BATs for anything
but the SDRAM.  This is a bit confusing because I seem to be able to
read from NAND and NOR
mtd devices without any issues.

Is there more that I need to do beyond an ioremap() to map in the address space?

Thanks.

-Mike


#define HW_FPGA 0xfa000000
#define HW_FPGA_SIZE 32768

static int __init mapfpga_load(void)
{
        u16 tmp;
        int res = 0;

        printk(KERN_ALERT "%s: loading\n", dev_name);
        mapfpga_dev.fpgaimg_res = request_mem_region(HW_FPGA,
HW_FPGA_SIZE, dev_name);
        if (mapfpga_dev.fpgaimg_res == NULL) {
                printk(KERN_ALERT "%s: could not request memory region"
                                " 0x%08x\n", dev_name, HW_FPGA);
                res = -EINVAL;
                goto out;
        }

        mapfpga_dev.fpgaimg = ioremap_nocache(HW_FPGA, HW_FPGA_SIZE);
        if (mapfpga_dev.fpgaimg == NULL) {
                printk(KERN_ALERT "%s: could not map i/o region"
                                " 0x%08x\n", dev_name, HW_FPGA);
                res = -EINVAL;
                goto out;
        }

        /* this should generate a non-zero number, it's a version register */
        tmp = ioread16(mapfpga_dev.fpgaimg); /* always zero... */
        ...
}



-- 
Michael Williamson
315-425-4045x230
www.criticallink.com
