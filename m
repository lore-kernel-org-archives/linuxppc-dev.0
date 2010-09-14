Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id 99A23B70AF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 05:40:48 +1000 (EST)
Received: from mail189-va3 (localhost.localdomain [127.0.0.1])	by
	mail189-va3-R.bigfish.com (Postfix) with ESMTP id 0D9B71E82B5	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 19:25:43 +0000 (UTC)
Received: from VA3EHSMHS019.bigfish.com (unknown [10.7.14.251])	by
	mail189-va3.bigfish.com (Postfix) with ESMTP id B674851004F	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 19:25:42 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8EJPZ8u024982	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 12:25:35 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8EJPf2T023003	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Sep 2010 14:25:41 -0500 (CDT)
Message-ID: <4C8FCC2E.1020107@freescale.com>
Date: Tue, 14 Sep 2010 14:25:34 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output byte
	channel is full
References: <1282329921-24394-1-git-send-email-timur@freescale.com>	<20100914121721.c8671ed8.akpm@linux-foundation.org>
	<20100914204410.71942cdc@lxorguk.ukuu.org.uk>
In-Reply-To: <20100914204410.71942cdc@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, amit.shah@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
> Its a printk handler - better to lose the bytes than hang the box. I
> think the current code is probably right.

What do you think about this change:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/thread.html#76830

This is the original version of my patch.  In it, I simply allow drivers to
return 0 to indicate that they're too busy to accept data.  It works great
on the hvc driver that we have in-house today, but it might break other
drivers that return 0 to indicate error.

-- 
Timur Tabi
Linux kernel developer at Freescale
