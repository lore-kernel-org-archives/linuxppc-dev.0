Return-Path: <bshtein@yahoo.com>
Received: from web50603.mail.re2.yahoo.com (web50603.mail.re2.yahoo.com
	[206.190.38.90]) by ozlabs.org (Postfix) with SMTP id 5ECF6DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 18:38:35 +1000 (EST)
Date: Wed, 7 May 2008 01:31:52 -0700 (PDT)
From: Boris Shteinbock <bshtein@yahoo.com>
Subject: powerpc port for sbc8260-based board problem
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <733382.15174.qm@web50603.mail.re2.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.
I am doing a port from ppc to powerpc ARCH on sbc8260 based board.
The problem is, that I can't get  SMC1 UART to work.
After SMC console  is initialized.  
cpm_uart_console_write() hangs here

        /* Wait for transmitter fifo to empty.
         * Ready indicates output is ready, and xmt is doing
         * that, not that it is ready for us to send.
         */
        while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) != 0)
            ;

I am using dts tree modified  from ep8248 port since it is the only one that has smc description in it. :


     brg@119f0 {
       compatible = "fsl,mpc8260-brg",
                    "fsl,cpm2-brg",
                    "fsl,cpm-brg";
       reg = <119f0 10 115f0 10>;
       clock-frequency = <135000000>;
       
     };

     /* Monitor port/SMC1 */
     smc1: serial@11a80 {
       device_type = "serial";
       compatible = "fsl,mpc8260-smc-uart",
                    "fsl,cpm2-smc-uart";
       reg = <0x11a80 0x20 0x1100 0x40>;
       interrupts = <4 8>;
       interrupt-parent = <&PIC>;
       fsl,cpm-brg = <1>;
       fsl,cpm-command = <0x1d000000>;
       linux,my-label = "SMC1";
     };

I checked a BRG settings against working u-boot configuration and they are the same. Anyway a wrong BRG setting wouldn't hang this loop

So I have a few questions.
If someone has done sbc8260 dts tree and port to "powerpc" already, I'd be very  grateful if he can share it with me.
I couldn't find anything on the internet.

Can someone, also, explain, how "fsl, cpm-command" field works,  booting-without-of document doesn't provide much information.
I feel, that just copying this value from ep8248.dts isn't right somehow.

Thank you


      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
