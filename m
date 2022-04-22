Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36EAC433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Apr 2022 17:49:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KlMNW5Dv0z3bpB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Apr 2022 03:49:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JFxldeSw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JFxldeSw; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KlMMm44vLz2yyM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2022 03:48:36 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8A098B83216;
 Fri, 22 Apr 2022 17:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE67C385A0;
 Fri, 22 Apr 2022 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650649710;
 bh=5eG88j23VfpqEXG5LElKEOANPUif8PLVVEOgW3NWPM8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JFxldeSwtEKgk9Lc8kRCQDX6OUJaNJqjczwvWjMV4j3OqtctIRIdLWhgVFbHcrF3q
 6RV2w/ktTedzqZubriC/58H3Vdm9JiPVMTZntT5U6PsWNK7vp6Lf1pJVILEyJGxmS+
 qbW6cqz9aSs5BypgxKnfiub0ZMs/SwHrot2cRn1CQZuR4f0sF4Z4oMH0Z+a459fUj/
 AqyDYdPlcTk4kUXYFN7XRqxWUhAFDdRXCLT5AegHPef/SkanQTZdABcipo326XcIeu
 cDK0+ZCKSi/1Lz6pPb+mOUQxdS1svIyOTdYSc7OWhpV+sUpJYcDte2V/RzhDmTOY++
 fOwXTN8nCbK0w==
Date: Fri, 22 Apr 2022 10:48:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/7] Remove unused SLOW_DOWN_IO
Message-ID: <20220422104828.75c726d0@kernel.org>
In-Reply-To: <20220415190817.842864-1-helgaas@kernel.org>
References: <20220415190817.842864-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Chas Williams <3chas3@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>,
 Matt Turner <mattst88@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 15 Apr 2022 14:08:10 -0500 Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Only alpha, ia64, powerpc, and sh define SLOW_DOWN_IO, and there are no
> actual uses of it.  The few references to it are in situations that are
> themselves unused.  Remove them all.
> 
> It should be safe to apply these independently and in any order.  The only
> place SLOW_DOWN_IO is used at all is the lmc_var.h definition of DELAY,
> which is itself never used.

Hi Bojrn! Would you mind reposting just patches 1 and 3 for networking?
LMC got removed in net-next (commit a5b116a0fa90 ("net: wan: remove the
lanmedia (lmc) driver")) so the entire series fails to apply and therefore 
defeats all of our patch handling scripts :S
