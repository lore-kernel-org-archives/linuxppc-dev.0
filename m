Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 66FB21007D1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 17:16:12 +1000 (EST)
Received: by iwn33 with SMTP id 33so890211iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Aug 2010 00:16:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=mq_vnUkrdmTeKjtfO3DQLKRESxzEBiK3jeTpV@mail.gmail.com>
References: <AANLkTinKb8E_McVAv5epg+4acb8H1+8HNsKHJYDr9B10@mail.gmail.com>
	<20100730120424.6db4139f@schlenkerla.am.freescale.net>
	<AANLkTim0pD9LWEgWjX4QvqUkZkYO3YOeELz_XjNJPDft@mail.gmail.com>
	<AANLkTi=mq_vnUkrdmTeKjtfO3DQLKRESxzEBiK3jeTpV@mail.gmail.com>
Date: Tue, 3 Aug 2010 00:16:10 -0700
Message-ID: <AANLkTimWYeRtN+Bcw-vG2G1j-D3FFmaUW7cnpvL+e=yN@mail.gmail.com>
Subject: Re: ramdisk size is larger than 4MB
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I found the link_address in the wrapper shell script sets the _start
> address. But after changing it to 0x800000, the kernel failed to boot,
> shown below. There must be something also needs proper adjustment.
> What would that be?

I did more debugging and something is really weird though. When the
link address is changed to 0x800000, when stepping through the kernel,
I actually got the kernel boot successfully. However I let the kernel
run through it would just crash. After crash the BDI2000 shows it
stopped at __delay().

I also changed the link address to 0x4000000. During the function
of_scan_flat_dt(early_init_dt_scan_chosen, NULL) called in
early_init_devtree(), gdb shows the program (i.e. kernel) received a
signal SIGSTOP.

Why would the kernel crash during that time? of_scan_flat_dt() doesn't
seem to be the cause of SIGSTOP. What would that be then?

Thanks,
-Shawn.
