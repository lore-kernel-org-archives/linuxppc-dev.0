Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60B0CDDE03
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 07:41:08 +1000 (EST)
Subject: Re: mmu_hash_lock deadlock causes kernel stuck at 2.6.21 SMP
	powerpc 32bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gaash-ppclnx@gaashh.com
In-Reply-To: <90380.16819.qm@web39603.mail.mud.yahoo.com>
References: <90380.16819.qm@web39603.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 08:40:21 +1100
Message-Id: <1206913221.10388.125.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Gilad Ben-Yossef <gilad@codefidence.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-03-30 at 14:28 -0700, Gaash Hazan wrote:
> To verify the theory, hash_page_sync() was wrapped
> with interrupts disabled code and problem never
> occurred again. Of course this is temporary workaround
> as there are several places needed to be fixed.

It is definitely a bug in hash_page_sync() which should
clear MSR:EE while holding the lock.

I'll do a patch.

Thanks for finding that out !

Cheers,
Ben.
