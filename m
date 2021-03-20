Return-Path: <SRS0=aOOO=IS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEE9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 10:57:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E019D61A41
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 10:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E019D61A41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F2d5G26Rmz3c8G
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 21:57:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T/rSoy6G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=T/rSoy6G; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F2d4p25r3z304Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Mar 2021 21:57:14 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D23D61A40;
 Sat, 20 Mar 2021 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1616237832;
 bh=3FOCqsLXP7+1KVCA86kmY+oaELLkWkU2fxbEuFLQ0sw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T/rSoy6GgOIbvIukcPwijvdFkYkGgRpIpQoCCgYINlVT63i0w/r5mEqpv2cPAT5d5
 Yv8E5b5Vuy0kSzAijIF1j7Geax+p87UowTKVLZjVFvBCYcsGYbsr04GNNw9SHdNXGz
 sPJdDJTgKTMudtMVljUOP9IAPmzh6PUU0SBPVtHQ=
Date: Sat, 20 Mar 2021 11:57:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [for-stable-4.19 PATCH v2 0/2] Backport patches to fix
 KASAN+LKDTM with recent clang on ARM64
Message-ID: <YFXVBXuXRkug2Esi@kroah.com>
References: <20210320041626.885806-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320041626.885806-1-drinkcat@chromium.org>
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
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, groeck@chromium.org,
 linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com,
 linux-sparse@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kbuild@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Daniel Axtens <dja@axtens.net>,
 Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 20, 2021 at 12:16:24PM +0800, Nicolas Boichat wrote:
> Backport 2 patches that are required to make KASAN+LKDTM work
> with recent clang (patch 2/2 has a complete description).
> Tested on our chromeos-4.19 branch.
> Also compile tested on x86-64 and arm64 with gcc this time
> around.
> 
> Patch 1/2 adds a guard around noinstr that matches upstream,
> to prevent a build issue, and has some minor context conflicts.
> Patch 2/2 is a clean backport.
> 
> These patches have been merged to 5.4 stable already. We might
> need to backport to older stable branches, but this is what I
> could test for now.

Ok, trying this again, let's see what breaks :)

thanks,

greg k-h
