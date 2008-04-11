Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id B0C95DE567
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 01:13:50 +1000 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 136993CC02C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:13:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 37DEBE3C09
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:12:45 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 1D2CBE3C09
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:12:45 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id 869CF53D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:12:41 +0200 (CEST)
Message-ID: <47FF802B.5020708@matrix-vision.de>
Date: Fri, 11 Apr 2008 17:13:47 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Flash on LocalBus @ MPC8343
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I've been trying hard to make the mtd-partitions available via device 
tree on my MPC8343 local bus.
No success so far ...

Everything works fine on my MPC5200B based system - flash layout 
definition is quite simple ....

To me it looks like there's a problem regarding the local bus in general.

Am I missing a "compatible" or anything else ? "reg" or "ranges" ?

The other boards use static map files or provide partition over command 
line args .... so suitable dts available.

Flash is 8MB size in 16-Bit configuration and should reside on 
0xFF800000 at cs0.


Any hints ?


regards,
Andre Schwarz
Matrix Vision


dts syntax :

<snip>

        localbus@e0005000 {
                #address-cells = <2>;
                #size-cells = <1>;
                compatible = "fsl,mpc8343-localbus", "fsl,pq2pro-localbus";

                ranges = <0x0 0x0 0xff800000 0x00800000>;

                flash@0,0 {
                        compatible = "amd,s29gl64", "cfi-flash";
                        reg = <0 0 800000>;
                        #address-cells = <1>;
                        #size-cells = <1>;
                        bank-width = <2>;
                        device-width = <2>;

                        ppcboot_env@0 {
                                reg = <0x0 0x2000>;
                        };

<snip>


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
