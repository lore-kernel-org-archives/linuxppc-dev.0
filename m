Return-Path: <dedekind1@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3B04DB6F98
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 17:37:40 +1000 (EST)
Received: by gyd5 with SMTP id 5so526928gyd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 00:37:36 -0700 (PDT)
Subject: Re: [PATCH] mtd-utils: fix corrupt cleanmarker with flash_erase -j
	command
From: Artem Bityutskiy <dedekind1@gmail.com>
To: LiuShuo <b35362@freescale.com>
Date: Wed, 17 Aug 2011 10:39:17 +0300
In-Reply-To: <4E4B6F46.2050209@freescale.com>
References: <1312350638-25566-1-git-send-email-b35362@freescale.com>
	<1313507201.2679.2.camel@sauron> <4E4B6F46.2050209@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313566762.19563.3.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@linux.freescale.net, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-08-17 at 15:35 +0800, LiuShuo wrote:
> I think We can add a new ioctl MEMSETOOBMODE for selecting a mode to 
> access the OOB area.
> 
> Add new member into struct mtd_info:
> 
> struct mtd_info {
>      ......
> 
>      enum {
>           MTD_OOB_PLACE,
>           MTD_OOB_AUTO,
>           MTD_OOB_RAW,
>      } oob_mode;
> }
> 
> In function mtd_do_writeoob() (in drivers/mtd/mtdchar.c) :
>      -  ops.mode = MTD_OOB_PLACE;
>      + ops.mode = mtd->oob_mode;
> 
> 
> 
> Could we do it like this ?

I think the OOB mode should not be a global MTD device state. Each
ioctl invocation should just specify the mode.

Brian's idea of having a completely new ioctl or a set of new ioctls for
OOB which would copletely deprecate the old ones is a good idea. Let's
wait for his patch.

May be we should even start physically removing depricated ioctls by
first adding a printk with a warning and then removing completely. But
first mtdutils should be updated to not use them.

-- 
Best Regards,
Artem Bityutskiy
