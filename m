Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174DC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 22:27:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64DD206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 22:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64DD206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VQdm3Mz5zDqLd
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 09:27:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43VQbZ28bXzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 09:25:13 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id D1D4F29FC6;
 Wed,  2 Jan 2019 17:25:08 -0500 (EST)
Date: Thu, 3 Jan 2019 09:25:08 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
In-Reply-To: <alpine.LNX.2.21.1901011206010.574@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1901030853160.614@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
 <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
 <CAK8P3a1rkdMXGOt90SDhBkVvFeNsqdoMKQAu4nLfk_Eg+_CB6g@mail.gmail.com>
 <alpine.LNX.2.21.1901011206010.574@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 1 Jan 2019, I wrote:

> 
> There are no [nvram] ioctls common to all architectures. So your example 
> becomes,
> 
> static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>                              unsigned long arg)
> {
>      if (ops->ioctl)
>           return ops->ioctl(file, cmd, arg);
>      return -ENOTTY;
> }
> 
> And then my objection is the same: m68k and x86 now have to duplicate 
> their common ops->ioctl() implementation.
> 

Perhaps code duplication is inevitable. Either you punt the ioctl 
implementation from the char misc driver (and duplicate that ioctl 
implementation under arch/) or else you duplicate the char misc driver.

Maybe this dilemma explains the situation we have now* which is duplicated 
drivers (drivers/char/nvram.c and drivers/char/generic_nvram.c). But this 
explanation doesn't seem to offer any solution. Re-using either of the 
existing drivers seems to be impossible.

Different interpretations of the NVRAM Kconfig symbol accross the tree are 
not helping. And having separate Kconfig symbols (NVRAM and GENERIC_NVRAM) 
for the two drivers doesn't help either. But maybe the NVRAM symbol can be 
dropped from arch/powerpc and all of the powerpc drivers...

* Actually, we presently have duplicated misc device drivers AND 
duplicated ioctl implementations too, for good measure. See 
arch/powerpc/kernel/nvram_64.c and drivers/char/generic_nvram.c.

-- 
