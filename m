Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D487AB710F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 14:31:03 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BFF31DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 14:31:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18997.52863.576426.501025@cargo.ozlabs.ibm.com>
Date: Mon, 15 Jun 2009 14:30:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
In-Reply-To: <ada4ouixlk2.fsf@cisco.com>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
	<alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
	<4A34E4A5.3040306@redhat.com>
	<18996.60235.178618.531664@cargo.ozlabs.ibm.com>
	<4A34F564.2010500@redhat.com> <ada4ouixlk2.fsf@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roland Dreier writes:

> FWIW, Nehalem EX actually goes to 8 cores/16 threads per socket.  But
> worrying about 32-bit performance on Nehalem is a little silly -- this
> simplest solution is simply to run a 64-bit kernel.

I'm not worried about ANY x86 processor, 32-bit or 64-bit, in fact,
since x86 already has an atomic64_t implementation for both 32-bit and
64-bit.

It is interesting, though, that arch/x86/include/asm/atomic_32.h
unconditionally uses cmpxchg8b to implement atomic64_t, but I thought
that cmpxchg8b didn't exist in processors prior to the Pentium.
Presumably you can't use perf_counters on a 386 or 486.

Paul.
