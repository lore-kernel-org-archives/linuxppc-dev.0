Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0989B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 03:40:46 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 27875DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 03:40:45 +1000 (EST)
To: vijay sharma <vjai22@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PPCboot and latest kernel
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <e571380d0907191136j37d341d7k514f46396a38abc3@mail.gmail.com>
References: <e571380d0907191132u3985423aiacc7ec8c75c0534b@mail.gmail.com>
	<e571380d0907191136j37d341d7k514f46396a38abc3@mail.gmail.com>
Date: Mon, 20 Jul 2009 19:40:41 +0200
Message-Id: <20090720174041.1873A832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear vijay sharma,

In message <e571380d0907191136j37d341d7k514f46396a38abc3@mail.gmail.com> you wrote:
> 
> I have been woking on upgrading an embedded system based on MPC8241 from
> 2.4.17 linux to 2.6.30 kernel.

Wow, that's a big leap...

You should also consider to update to the latest version of U-Boot;
the time when it was still called PPCBoot is long, long past.

> I am currently struck one point.
> 
> Here is the console output where I am struck:
> =================================
> cpboot> bootm
> ## Booting image at 08000000 ...
>    Image Name:   Linux-2.6.30
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    21729342 Bytes = 21220 kB = 20 MB
>    Load Address: 01900000
>    Entry Point:  01900570
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory <- <0x0 0x10000000> (256MB)
> CPU clock-frequency <- 0xbebc1fe (200MHz)
> CPU timebase-frequency <- 0x17d783f (25MHz)
> CPU bus-frequency <- 0x5f5e0ff (100MHz)
> 
> zImage starting: loaded at 0x01900000 (sp: 0x0fdc3a08)
> Allocating 0x165ca04 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0190c000:0x02f58efc)...done 0x1637b54 bytes

You loaded the image at 01900000, but the uncompr4essed image extends
until 02f58efc, i. e. there is a good chance that you will overwrite
parts of the still uncompressed image.

> Linux/PowerPC load:
> Finalizing device tree... flat tree at 0x2f65300 <== Beyond this point no
> output is available.

Your device tree might be wrong, too.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Any sufficiently advanced bug is indistinguishable from a feature.
                                                      - Rich Kulawiec
