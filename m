Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F6E567C00
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 09:37:19 +1100 (EST)
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
In-Reply-To: <OF160F7BCC.ADD0D85F-ON86257219.00795AB5-86257219.007A72E6@us.ibm.com>
References: <OF160F7BCC.ADD0D85F-ON86257219.00795AB5-86257219.007A72E6@us.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 09:35:52 +1100
Message-Id: <1162420552.25682.471.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Fabio Massimo Di Nitto <fabbione@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The tst-robustpi# test are exercising the new PTHREAD_MUXTEX_ROBUST api,
> with PTHREAD_PRIO_INHERIT attribute.
> 
> The fuxtex word seems to include the waiters TID, I don't know if the
> kernel cares about this or not.

Ok, well, we have seen a few issues so far with these. 2 are kernel
issues, but one might not be:

 - kernels 2.6.15 .. .17 at least it seems wire the robust futex
syscalls on powerpc without properly implementing the support, which can
cause hangs in process exit. Do you have any way to "blacklist" kernels
in glibc ?

 - kernel 2.6.18 and current git until yesterday (fix got in today) has
a bug if you manage to pass a wrong futex with a non-aligned atomic
value, it will possibly oops the kernel. With the fix, it will return an
error.

Now what seems to be a glibc issue:

 - I've had the tst-robustpi# tests (in fact the very first one, I
haven't tested the others) die on me with a SIGBUS caused by glibc
trying to do a lwarx/starx. on an odd address.

I do not know for sure yet if the crash reported by Fabio with 2.6.19
(before my fix above) was related to the same kind of misaligned futex
managing to reach the kernel and triggering the oops I've talked about,
but it's very possible.

In my case, glibc was built against 2.6.16 headers, in fabio case, I
think it was built against 2.6.15 or .17 headers. It -seems- that fabio
cannot reproduce the problem when building glibc against 2.6.19 headers,
though at this point I can't explain why and I haven't reproduced here
yet.

Do you have any insight in what might be happening or should we just dig
more ?

Cheers,
Ben.
