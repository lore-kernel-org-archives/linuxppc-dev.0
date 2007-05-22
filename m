Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0C7BDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 06:21:41 +1000 (EST)
Date: Tue, 22 May 2007 13:08:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-Id: <20070522130824.a78976aa.akpm@linux-foundation.org>
In-Reply-To: <20070522171950.23728.95735.stgit@localhost.localdomain>
References: <20070522171950.23728.95735.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 22 May 2007 17:19:52 +0000
Maxim Uvarov <muvarov@ru.mvista.com> wrote:

> Sorry for bothering you. I know you are very busy but could 
> you please tell me what is situation of this patch?

I'd like to add the context-switch accounting to the taskstats payload.

As we'd then need to uprev the taskstats payload and version it makes sense
to have a look around, see if there's anything else which should be in
there but got missed.



I don't think we can accept the number-of-syscalls accounting feature.  It
adds a memory increment into the kernel's number-one hotpath.  Something
which people like to obsessively microbenchmark.

And as I said earlier, a 32-bit counter can be overflowed in mere seconds,
so that needs to become 64-bit, in which case we add a memory increment and
a test-n-branch to that hottest path.


There _is_ some cumulative overhead here, and I don't see how the value of
the syscall counter can justify it.
