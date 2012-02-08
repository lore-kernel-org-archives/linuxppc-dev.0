Return-Path: <ppc@mindchasers.com>
Received: from vms173015pub.verizon.net (vms173015pub.verizon.net
 [206.46.173.15]) by ozlabs.org (Postfix) with ESMTP id E9691B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 14:14:01 +1100 (EST)
Received: from [192.168.1.3] ([unknown] [108.25.174.63])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LZ100BO9Y6BPR21@vms173015.mailsrvcs.net> for
 linuxppc-dev@lists.ozlabs.org; Tue, 07 Feb 2012 20:13:28 -0600 (CST)
Message-id: <4F31DA43.2030504@mindchasers.com>
Date: Tue, 07 Feb 2012 21:13:23 -0500
From: Bob Cochran <ppc@mindchasers.com>
MIME-version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Question about fsl_pq_mdio_probe and dts file for p1010rdb...
References: <1328555872-9616-1-git-send-email-timur@freescale.com>
In-reply-to: <1328555872-9616-1-git-send-email-timur@freescale.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Using the mainline kernel & p1010rdb.dts, fsl_pq_mdio_probe returns busy 
on my P1010RDB when first probing the MDIO during kernel boot.  On the 
console, the error is reported as:

"fsl-pq_mdio: probe of ffe24000.mdio failed with error -16"


I have determined that the failure occurs in the 
for_each_child_of_node() loop shown below, which is part of the 
fsl_pq_mdio_probe routine.  It turns out that tbi->type is always <NULL> 
although tbi->name will be "tbi-phy" when scanning the last child node ( 
I have also attached the relevant portion of the p1010rdb.dtsi file 
below).   Since tbi-type is never "tbi-phy", the "if (tbi)" statement is 
always false, and err is subsequently set to EBUSY below.

Can someone please tell me whether this is an issue with the dts file, 
the of library, or the probe function?  Any direction on the right way 
to patch this would be appreciated.


// from fsl_pq_mdio.c:

for_each_child_of_node(np, tbi) {
                 if (!strncmp(tbi->type, "tbi-phy", 8))
                         break;
         }

         if (tbi) {
                 const u32 *prop = of_get_property(tbi, "reg", NULL);

                 if (prop)
                         tbiaddr = *prop;
         }

         if (tbiaddr == -1) {
                 err = -EBUSY;
                 goto err_free_irqs;
         } else {
                 out_be32(tbipa, tbiaddr);
         }


// from p1010rdb.dtsi:

mdio@24000 {
                 phy0: ethernet-phy@0 {
                         interrupts = <3 1 0 0>;
                         reg = <0x1>;
                 };

                 phy1: ethernet-phy@1 {
                         interrupts = <2 1 0 0>;
                         reg = <0x0>;
                 };

                 phy2: ethernet-phy@2 {
                         interrupts = <2 1 0 0>;
                         reg = <0x2>;
                 };

                 tbi-phy@3 {
                         device-type = "tbi-phy";
                         reg = <0x3>;
                 };
         };
