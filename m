Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.200])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9202C2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 08:04:33 +1100 (EST)
Received: from amer-gw15.amer.csc.com (amer-gw15.amer.csc.com [20.137.2.189])
 by amer-mta112.csc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
 ESMTP id s1BKvvE4022099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 15:57:58 -0500
In-Reply-To: <20140211072606.GA26514@visitor2.iram.es>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
 <alpine.LRH.2.00.1402101056410.10318@ra8135-ec1.am.freescale.net>
 <20140211072606.GA26514@visitor2.iram.es>
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Linux-3.14-rc2: Order of serial node compatibles in DTS files.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF6F6A0029.3B20EF5B-ONCA257C7C.0071BFDA-CA257C7C.00732AD3@csc.com>
Date: Wed, 12 Feb 2014 06:57:56 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have been trial booting a 3.14-rc2 kernel for a 85xx platform 
(dtbImage).

After mounting the root filesystem there are no messages from the init 
scripts
and the serial console is not available for login.

In the kernel log messages there is:

of_serial f1004500.serial: Unknown serial port found, ignored.

The serial nodes in boards dts file are specified as:

        serial0: serial@4500 {
                        cell-index = <0>;
                        device_type = "serial";
                        compatible = "fsl,ns16550", "ns16550";
                        reg = <0x4500 0x100>;
                        clock-frequency = <0>;
                        interrupts = <0x2a 0x2>;
                        interrupt-parent = <&mpic>;
                };

Reversing the order of the compatible:

        compatible = "ns16550", "fsl,ns16550";

restores the serial console.

Linux-3.13 does not have this behaviour.

There are 49 dts files in Linux-3.14-rc2 that have the fsl,ns16550 
compatible first.

Stephen Chivers,
CSC Australia Pty. Ltd.
