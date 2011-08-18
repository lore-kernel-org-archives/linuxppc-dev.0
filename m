Return-Path: <computersforpeace@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24290B6FA0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2011 11:21:03 +1000 (EST)
Received: by wwe5 with SMTP id 5so3895146wwe.3
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 18:20:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1313566762.19563.3.camel@sauron>
References: <1312350638-25566-1-git-send-email-b35362@freescale.com>
	<1313507201.2679.2.camel@sauron> <4E4B6F46.2050209@freescale.com>
	<1313566762.19563.3.camel@sauron>
Date: Wed, 17 Aug 2011 18:20:58 -0700
Message-ID: <CAN8TOE9QEX6Yssy4HCONrawngmRRCgYbh5jNVpH1dREUsDfagg@mail.gmail.com>
Subject: Re: [PATCH] mtd-utils: fix corrupt cleanmarker with flash_erase -j
	command
From: Brian Norris <computersforpeace@gmail.com>
To: dedekind1@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: LiuShuo <b35362@freescale.com>, linuxppc-dev@linux.freescale.net,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2011 at 12:39 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> I think the OOB mode should not be a global MTD device state. Each
> ioctl invocation should just specify the mode.

I agree. This brings up some questions, though. See below.

> Brian's idea of having a completely new ioctl or a set of new ioctls for
> OOB which would copletely deprecate the old ones is a good idea. Let's
> wait for his patch.

I sent a patch series (RFC) to the MTD mailing list. You can see the
cover description, which describes my proposed changes and asks some
questions, at the following link, but for some reason the patches are
being held up by the mailing list software - for now, you'll only
receive them if you were CC'd directly:
http://lists.infradead.org/pipermail/linux-mtd/2011-August/037522.html
Follow that thread for more information.

> May be we should even start physically removing depricated ioctls by
> first adding a printk with a warning and then removing completely. But
> first mtdutils should be updated to not use them.

Yes, this sounds fine, although I'm not too familiar with the
MTD_OOB_AUTO stuff, so I'm not sure how well it will replace all the
uses of MEMGETOOBSEL. I don't actually see any users of ECCGETLAYOUT;
I think I've asked about this ioctl before, but I can't seem to find
any response...perhaps it can be killed with no work?

Brian
