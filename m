Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 1BFBDDDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 08:13:29 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so343857anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Jan 2008 13:13:27 -0800 (PST)
Message-ID: <fa686aa40801271313y4370ac3dmd4460d79362f10c4@mail.gmail.com>
Date: Sun, 27 Jan 2008 14:13:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Yedu Jathavedan" <yeduj@ece.pdx.edu>
Subject: Re: Load Kernel 2.6 using U-boot on ML403
In-Reply-To: <20080126231047.y3lm7epb0gw4cog8@webmail.cecs.pdx.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080126231047.y3lm7epb0gw4cog8@webmail.cecs.pdx.edu>
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

On 1/27/08, Yedu Jathavedan <yeduj@ece.pdx.edu> wrote:
>
> 1)Downloaded(sourceforge.net) & compiled the U-boot 1.1.6 files to get
> u-boot, u-boot.srec & u-boot.bin (I didn't find ml403 board config for the
> uboot. So used ml300_config).

U-boot 1.1.6 is ancient.  The u-boot project has moved off of
sourceforge to denx.de

> After this, I tried to convert the u-boot (README says that this is an ELF
> file) into an ace file. But, it gave me the error saying unable to read elf
> file. Is it because ML403 board is not supported or is it possible that the
> u-boot image that I created is corrupted?

I don't know; but personally I don't weld u-boot into an ace file. I
use a 1st stage bootloader to load the u-boot image off the cf card
(but unfortunately I'm not able to post that loader at this time).
Try again with a recent u-boot version.

> 2) Since generating ace files failed, I tried to search the net for an
> u-boot ace file that could run on ML403 & found it at
> http://88.191.24.164/docenligne/projets/samba/2006/linux-embarque-sur-ml-403/u-boot-ml403.ace/view
>
> I copied this ace file (u-boot-ml403.ace) along with the kernel 2.6 image
> (uImage) onto my CF card & booted the board. After loading the kernel, it
> fails to read the correct root device. I tried changing the "bootargs" env
> variable root = /dev/xsysace/disc0/part2 rw to root = /dev/xsysace2 rw &
> root = /dev/xsda2 rw.
>
> But, it failed in both cases. (There was a previous post on Problem2 a year
> ago & he solved it by giving root =/dev/xsysace2)

Looking at your bootlog, it doesn't look like you've got the systemace
driver built into the kernel.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
