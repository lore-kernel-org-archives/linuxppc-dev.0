Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CAB5DDDF02
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 14:49:44 +1000 (EST)
Date: Fri, 20 Jun 2008 21:49:42 -0700 (PDT)
Message-Id: <20080620.214942.193706145.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [Cbe-oss-dev] [RFC 1/3] powerpc: __copy_tofrom_user tweaked
	for Cell
From: David Miller <davem@davemloft.net>
In-Reply-To: <18524.33738.450400.63491@cargo.ozlabs.ibm.com>
References: <18523.1109.809247.646816@cargo.ozlabs.ibm.com>
	<200806210400.20794.arnd@arndb.de>
	<18524.33738.450400.63491@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, VONBOEHN@de.ibm.com, ellerman@au1.ibm.com,
	arnd@arndb.de, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 21 Jun 2008 14:30:02 +1000

> Is this application really transferring bulk data and using buffers
> that aren't a multiple of the page size?  Do you know whether the
> copies ended up being misaligned?

We used to cache align the sub-buffers carved out of the per-socket
anonymous buffer page that TCP, UDP, and other protocols use to
collect user write()/sendmsg() data when the outgoing interface
supports scatter-gather and checksumming (basically just about
any reasonable ethernet device these days).

But that alignment was removed from net/ipv4/tcp.c (I forget the exact
reasons, I think it was space wastage).

The net result is that you will therefore see a lot of misaligned
copies for networking sends these days.

In my opinion optimizing mempcy/user-copy in the most general way is
the best course of action.  Whatever histogram of sizes and alignments
you obtain with sampling today will change unpredictably in the
future.  I'm saying this as someone who fell into that trap on sparc64
several times in the past, and I have 5 memcpy/user-copy/memset
variants to maintain on that platform these days :-/
