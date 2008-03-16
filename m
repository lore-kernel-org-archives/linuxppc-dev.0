Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 16702DDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 07:01:26 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1128720anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Mar 2008 13:01:24 -0700 (PDT)
Message-ID: <fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com>
Date: Sun, 16 Mar 2008 14:01:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Andr=E9_Schwarz?=" <Andre.Schwarz@matrix-vision.de>
Subject: Re: simple MPC5200B system
In-Reply-To: <47DD71D0.2010203@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47DD71D0.2010203@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 16, 2008 at 1:15 PM, Andr=E9 Schwarz
<Andre.Schwarz@matrix-vision.de> wrote:
> All,
>
>  I'm quite stuck in getting our MPC5200B based systems work on 2.6.24+
>  ... maybe someone could give me some hints.
>  Up to now the systems have been running on 2.6.19 without any problems.
>
>  This is what I've done so far :
>
>  - get a recent system with 2.6.19 running and keep the toolchain (gcc
>  4.0) including RFS uImage.
>  - latest bootloader (u-boot 1.3.2) is running fine with dtb support.
>  - Kernel and RFS images are available via bootp/tftp
>  - device tree blob seems ok, i.e. u-boot can display the blob and fill
>  in all clocks correctly.
>  - Kernel gets called with Kernel, RFS and dtb on suitable adresses
>  (0x100000, 0x600000, 0x5F0000).
>  - nothing more happens. It looks like the console isn't working properly
>  - maybe worse ...

Can you either halt the processor or reset the board and access memory
after this point?  You should see if you can access __log_buf (Look in
System.map for the address and subtract 0xc0000000 to get the physical
address).   __log_buf should give you clues about how far booting
progresses.

>  The kernel has been build using the "MPC5200 simple" setup. I've added
>  our board identifier "mv,mvbluecougar" to the list of supported boards
>  in the "mpc52xx_simple.c" file. This identifier is used in the dtb as
>  well of course. This should be enough along with a valid device tree
>  blob, isn't it ? Did I miss anything already ?

Yes, this should be enough (on a side note; it should probably be
"matrix-vision,bluecougar" unless of''mv' is your company's stock
ticker symbol).

>
>  As far as I did understand by reading the docs it should be possible
>  running a general MPC52xx kernel with a custom dtb ? Is this correct ?

That is correct.

>  The dts file has already been reduced to a minimum, i.e. only the cpu,
>  pic, xlb and a few nodes like psc1 and psc2 are present. No bestcomm,
>  pci, ata or "advanced" features like mtd partitions. All I want to get
>  working is the serial console on "/dev/ttyPSC0".

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
