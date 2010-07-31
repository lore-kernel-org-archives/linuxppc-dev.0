Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 8A5ADB70AE
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 16:32:48 +1000 (EST)
Received: by iwn36 with SMTP id 36so2183153iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 23:32:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100730120424.6db4139f@schlenkerla.am.freescale.net>
References: <AANLkTinKb8E_McVAv5epg+4acb8H1+8HNsKHJYDr9B10@mail.gmail.com>
	<20100730120424.6db4139f@schlenkerla.am.freescale.net>
Date: Fri, 30 Jul 2010 23:32:45 -0700
Message-ID: <AANLkTim0pD9LWEgWjX4QvqUkZkYO3YOeELz_XjNJPDft@mail.gmail.com>
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

>> One way to lift this limitation is to relocate the bootwrapper to
>> somewhere else, say for example, 0x1000000 so that a 16MB initramfs
>> can be loaded. If the bootwrapper is relocated, what else would be
>> affected by this relocation?
>
> It should be fine to just change it locally. =A0It would be a problem to
> change it upstream for all boards, since some supported boards have
> only 16MB (or even 8MB) of RAM.

I'll definitely try to change it locally first. Would a configurable
base address for the bootwrapper an acceptable solution?

> Another option is to provide a vmlinux_alloc callback to stick the
> kernel somewhere other than zero, at the cost of an extra image copy
> once the kernel runs to get itself back down to zero. =A0This wasn't done
> in cuboot because it was considered better to adjust the bootwrapper
> link address at build time based on the kernel+ramfs image size, but
> that never got implemented.
>
> Perhaps a reasonable compromise is a vmlinux_alloc that returns zero if
> the image fits there, and calls malloc otherwise?

I'll look into this too.

Thanks,
-Shawn.
