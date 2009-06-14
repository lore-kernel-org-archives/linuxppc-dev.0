Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F3835B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 22:21:35 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E182CDDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 22:21:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18996.60235.178618.531664@cargo.ozlabs.ibm.com>
Date: Sun, 14 Jun 2009 22:21:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
In-Reply-To: <4A34E4A5.3040306@redhat.com>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
	<alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
	<alpine.LFD.2.01.0906131323270.3237@localhost.localdomain>
	<4A34E4A5.3040306@redhat.com>
Cc: akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity writes:

> An alternative implementation using 64-bit cmpxchg will recover most of 
> the costs of hashed spinlocks.  I assume most serious 32-bit 
> architectures have them?

Have a 64-bit cmpxchg, you mean?  x86 is the only one I know of, and
it already has an atomic64_t implementation using cmpxchg8b (or
whatever it's called).

My thinking is that the 32-bit non-x86 architectures will be mostly
UP, so the overhead is just an interrupt enable/restore.  Those that
are SMP I would expect to be small SMP -- mostly just 2 cpus and maybe
a few 4-way systems.

Paul.
