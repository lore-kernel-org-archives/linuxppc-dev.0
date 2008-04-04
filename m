Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id DCB80DDFA3
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 00:06:49 +1100 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 584523CC7BE
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 15:06:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 8C1B9E762F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 15:06:17 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 0F2D3E762F
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 15:06:17 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id 0FD3853E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 15:06:15 +0200 (CEST)
Message-ID: <47F627E6.90304@matrix-vision.de>
Date: Fri, 04 Apr 2008 15:06:46 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Oops MPC8343 @ 2.6.25-rc7
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

I'm having trouble booting a MPC8343 into a recent 2.6.25-rc7 kernel.


Kernel config has been reduced to a minimum : no PCI, no netwoking, i2c, 
spi ...
dts has been reduced to the CPU, soc and ipic nodes.

U-Boot fills out dtb correctly - as far as I can see.

Kernel crashes on various "of_" functions regarding to call trace.

There's also strange messages :
WARNING: Estimating decrementer frequency (not found)
WARNING: Estimating processor frequency (not found)

They're coming from "generic_calibrate_decr()" in kernel/time.c.

Looks like there something basically wrong with my dtb 
location/processing, since the "timebase-frequency" is present and valid :

        cpus {
                #address-cells = <0x00000001>;
                #size-cells = <0x00000000>;
                PowerPC,8343@0 {
                        device_type = "cpu";
                        reg = <0x00000000>;
                        d-cache-line-size = <0x00000020>;
                        i-cache-line-size = <0x00000020>;
                        d-cache-size = <0x00008000>;
                        i-cache-size = <0x00008000>;
                        timebase-frequency = <0x03f940aa>;
                        bus-frequency = <0x0fe502a8>;
                        clock-frequency = <0x17d783fc>;
                };
        };


Any hints ?


regards,
Andre Schwarz
Matrix Vision


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
