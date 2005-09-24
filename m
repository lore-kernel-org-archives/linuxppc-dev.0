Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17204.41449.162199.476757@cargo.ozlabs.ibm.com>
Date: Sat, 24 Sep 2005 10:46:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
In-Reply-To: <606.1127460740@warthog.cambridge.redhat.com>
References: <E1EIXAI-0006Q0-OS@jdl.com>
	<606.1127460740@warthog.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc Merge asm-ppc*/rwsem.h 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Howells writes:

> rwsems on ppc64 should really be using a 64-bit counter, not a 32-bit counter,
> otherwise you limit the maximum number of processes to 32K-ish.
> 
> The counter should be "signed long" really.

It has long annoyed me that we waste half the bits in the rwsem
counter, just because you assume a lowest-common-denominator set of
atomic ops.  IIRC your implementation replaced the earlier ppc
implementation which had a 32-bit counter and didn't have the 32k
process limit.

I'd have to study it in more detail, but I strongly suspect that with
an atomic operation that did something like

	*p = max(*p, limit) + inc

atomically (or alternatively a min), we could increase the limit to at
least 1G processes with a 32-bit counter, without needing to change
your common slow-path implementation.

Such an atomic op is easy to implement with load-and-reserve /
store-conditional instructions.  Look at __sem_update_count in
arch/ppc64/kernel/semaphore.c for an example.

Paul.
