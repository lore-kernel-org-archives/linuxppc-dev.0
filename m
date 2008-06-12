Return-Path: <MichaelGalea@ruggedcom.com>
Received: from rcserver3.ruggedcom.local (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id E25A8DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 00:24:23 +1000 (EST)
Received: from michaelgalea.eng.lan (michaelgalea.eng.lan [10.128.10.10])
	by rceng01.eng.lan (Postfix) with ESMTP id 002341C006
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 10:12:09 -0400 (EDT)
Received: from localhost ([127.0.0.1] ident=michaelgalea)
	by michaelgalea.eng.lan with esmtp (Exim 4.69)
	(envelope-from <michaelgalea@ruggedcom.com>) id 1K6nX7-0003Uf-R3
	for linuxppc-embedded@ozlabs.org; Thu, 12 Jun 2008 10:12:09 -0400
Message-ID: <48512EB9.3080307@ruggedcom.com>
Date: Thu, 12 Jun 2008 10:12:09 -0400
From: Michael Galea <michaelgalea@ruggedcom.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Question on assigning interrupts in a dts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
     I'm building a dts for a custom 8360 based board.  I'm looking at 
the mpc8360_mds and mpc8360_rdk dts files, trying to figure out how the 
UCCs (and all peripherals in general) got the values of their 
"interrupts" properties chosen.  And is there any relationship between 
the choice of interrupts for ucc1 and the qeic controller..  Can anyone 
point me some docs for this?

             enet0: ucc@2000 {
                 device_type = "network";
                 compatible = "ucc_geth";
                 cell-index = <1>;
                 reg = <0x2000 0x200>;
                 interrupts = <32>;
         ..
             };

              enet1: ucc@3000 {
                 device_type = "network";
                 compatible = "ucc_geth";
                 cell-index = <2>;
                 reg = <0x3000 0x200>;
                 interrupts = <33>;
         ..
             };

             qeic: interrupt-controller@80 {
                 #address-cells = <0>;
                 #interrupt-cells = <1>;
                 compatible = "fsl,qe-ic";
                 interrupt-controller;
                 reg = <0x80 0x80>;
                 big-endian;
                 interrupts = <32 8 33 8>;
                 interrupt-parent = <&ipic>;
             };

Thanks

-- 
Michael Galea
