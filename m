Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id E1726B70E0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 20:14:34 +1000 (EST)
Received: by ewy2 with SMTP id 2so689057ewy.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 03:14:33 -0700 (PDT)
Date: Thu, 16 Sep 2010 14:14:29 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100916101429.GA27393@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
	<20100916082141.GA10978@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6B8@zch01exm23.fsl.freescale.net>
	<20100916092551.GA17548@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC6DB@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A1FC6DB@zch01exm23.fsl.freescale.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2010 at 06:08:14PM +0800, Zang Roy-R61911 wrote:
[...]
> Interesting.
> How about this?
> #include <stdio.h>
> #include <malloc.h>
> 
> char *foo;
> 
> void probe(void)
> {
>         char *bar = NULL;
> 
>         if (!foo) {
>                 bar = malloc(sizeof(*bar));
>                 if (!bar)
>                         return;
>                 foo = bar;
>         } else
> 		   bar = foo;

This willl work of course; but I'd write it as

foo_lock();
if (!foo)
	foo = alloc();
foo_unlock();

bar = foo;
bar->baz;

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
