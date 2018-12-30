Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49355C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 04:07:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC0120866
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 04:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC0120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43S6Nl3mwHzDqBc
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 15:07:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43S6LX5GfvzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 15:05:56 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id E3FC7297F9;
 Sat, 29 Dec 2018 23:05:52 -0500 (EST)
Date: Sun, 30 Dec 2018 15:05:49 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
In-Reply-To: <alpine.LNX.2.21.1812301051280.215@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
 <alpine.LNX.2.21.1812301051280.215@nippy.intranet>
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
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 30 Dec 2018, I wrote:

> 
> I'm not opposed to exported functions in place of a singleton ops 
> struct. Other things being equal I'm inclined toward the ops struct, 
> perhaps because I like encapsulation or perhaps because I don't like 
> excess generality. (That design decision was made years ago and I don't 
> remember the reasoning.)

The rationale for the ops struct was that it offers introspection.

It turns out that PPC64 device drivers don't care about byte-at-a-time 
accessors and X86 device drivers don't care about checksum validation.
But that only gets us so far.

We still needed a way to find out whether the arch has provided 
byte-at-a-time accessors (i.e. PPC32 and M68K Mac) or byte range accessors 
(i.e. PPC64 and those platforms with checksummed NVRAM like X86 and M68K 
Atari).

You can't resolve this question at build time for a multi-platform kernel 
binary, so pre-processor tricks don't help.

Device drivers tend to want to access NVRAM one byte at a time. With this 
patch series, those platforms which need checksum validation always set 
byte-at-a-time methods to NULL. (Hence the atari_scsi changes in patch 3.)

The char misc driver is quite different to the usual device drivers, 
because the struct file_operations methods always access a byte range.

The NULL methods in the ops struct allow the nvram.c misc device to avoid 
inefficient byte-at-a-time accessors where possible, just as 
arch/powerpc/kernel/nvram_64.c presently does.

-- 
