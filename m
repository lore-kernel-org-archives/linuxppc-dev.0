Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4D87BDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 13:31:23 +1000 (EST)
Date: Sun, 18 May 2008 20:31:16 -0700 (PDT)
Message-Id: <20080518.203116.199516667.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH 1/4] lmb: Fix compile warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <1211136296-4572-2-git-send-email-galak@kernel.crashing.org>
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<1211136296-4572-2-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Sun, 18 May 2008 13:44:53 -0500

> lib/lmb.c: In function 'lmb_dump_all':
> lib/lmb.c:51: warning: format '%lx' expects type 'long unsigned int', but argument 2 has type 'u64'
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

That's not right either.

We'll need to cast this argument because it's a different type on sparc
vs sparc64 vs powerpc.

u64 != unsigned long long
