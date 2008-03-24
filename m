Return-Path: <jblack547@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id AE014DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 08:45:32 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so639095anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Mar 2008 14:45:30 -0700 (PDT)
Message-ID: <b77025b40803241445w46aaf071k427df888b4597c4d@mail.gmail.com>
Date: Mon, 24 Mar 2008 15:45:30 -0600
From: "James Black" <jblack547@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
In-Reply-To: <47E7DC46.2010806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>
	<b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>
	<47E2AADD.6090101@freescale.com>
	<b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>
	<20080321161833.GA4170@loki.buserror.net>
	<b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>
	<47E41BE7.9020109@freescale.com>
	<b77025b40803211435g25e8cee7w75bfe4ed9c13796@mail.gmail.com>
	<47E7DC46.2010806@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I started from scratch and am trying to build the cuImage. I get this
compiler error.

arch/powerpc/boot/cuboot-pq2.c:14:20: error: bitops.h: No such file or directory
arch/powerpc/boot/cuboot-pq2.c: In function 'fixup_pci':
arch/powerpc/boot/cuboot-pq2.c:205: warning: implicit declaration of
function '__ilog2_u32'

I looks as though cuboot-pq2.c expects bitops.h to be in the same
directory, but it has moved to
linux/include/asm-powerpc/bitops.h

Did you run into this problem?

JB

On Mon, Mar 24, 2008 at 10:52 AM, Scott Wood <scottwood@freescale.com> wrote:
> James Black wrote:
>  > Thanks much for the help Scott. Do you feel that the dts is correct
>  > now and probably not the culprit? Do you have 2.6.24.2 running on
>  > other boards?
>
>  I just booted 2.6.24.2 on pq2fads (using cuImage, since I don't have a
>  devtree-aware u-boot on this board).
>
>
>  >       localbus@f0010100 {
>  >               compatible = "fsl,mpc8250-localbus",
>  >                    "fsl,pq2-localbus";
>  >
>  >               #address-cells = <2>;
>  >               #size-cells = <1>;
>  >               reg = <f0010100 60>;
>  >               ranges = <0 0 fe000000 00200000>;
>  >
>  >               flash@fe000000,0 {
>  >                       compatible = "cfi-flash";
>  >                       reg = <0 fe000000  00200000>;
>  >                       bank-width = <2>;
>  >                       device-width = <1>;
>  >               };
>
>  This is wrong; the flash will not translate since you didn't provide a
>  window at the address reg is at.
>
>  The first cell of the reg should be the chipselect, and the second cell
>  the offset.
>
>
>  >                       brg@119f0 {
>  >                               compatible = "fsl,mpc8250-brg",
>  >                                            "fsl,cpm2-brg",
>  >                                            "fsl,cpm-brg";
>  >                               reg = <119f0 10>;
>  >                       };
>
>  BRG should be <119f0 10 115f0 10>.
>
>  -Scott
>
>
