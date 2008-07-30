Return-Path: <matvejchikov@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 51613DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 19:37:44 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so196059wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 02:37:43 -0700 (PDT)
Message-ID: <8496f91a0807300237q302cafd3ga21ddb7bbc0bd513@mail.gmail.com>
Date: Wed, 30 Jul 2008 13:37:43 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
In-Reply-To: <20080729193901.GC8051@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
	<8496f91a0807291136v172b3b16t170088faf3f30b5b@mail.gmail.com>
	<20080729193901.GC8051@ld0162-tx32.am.freescale.net>
Cc: Ben Gardiner <BenGardiner@nanometrics.ca>, linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Did you use CONFIG_PPC_CPM_NEW_BINDING in 2.6.25?  It became mandatory in
> 2.6.26.  Also, try commenting out cpm_setbrg() calls in case the
> frequency is not being set properly.

Yes, this option was enabled. Nothing changed with empty cpm_setbrg()
function :(

> 2.6.26 introduced the allocation of the CPM2 SMC parameter RAM area; what
> did your device node look like in 2.6.25?  What happens if you use that
> device tree with 2.6.26?

The cpm node for the 2.6.25.4 kernel was the following:

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			#interrupt-cells = <2>;
			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
			reg = <119c0 30>;
			ranges;

			muram {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 10000>;

				data-only@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <100 1f00 9800 800>;
				};
			};

			brg@119f0 {
				compatible = "fsl,cpm-brg", "fsl,cpm2-brg";
				reg = <119f0 10 115f0 10>;
			};

			smc1: serial@11a80 {
				device_type = "serial";
				compatible = "fsl,cpm2-smc-uart";
				reg = <11a80 20 0 40>;
				interrupts = <4 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <7>;
				fsl,cpm-command = <1d000000>;
			};

		};

(muram node for 2.6.25 is differs from muram node for the 2.6.26)

With this device tree I have a warning message from cpm_uart driver
tells that the dts file needs to be updated.

Ilya.
