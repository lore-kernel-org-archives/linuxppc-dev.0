Return-Path: <dhowells@redhat.com>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <E1EIXAI-0006Q0-OS@jdl.com> 
References: <E1EIXAI-0006Q0-OS@jdl.com> 
To: Jon Loeliger <jdl@freescale.com>
Date: Fri, 23 Sep 2005 08:32:20 +0100
Message-ID: <606.1127460740@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
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

Jon Loeliger <jdl@freescale.com> wrote:

> Merge asm-ppc*/rwsem.h into include/asm-powerpc.
> Removed smp_*mb() memory barriers from the ppc32 code
> as they are now burried in the atomic_*() functions as
> suggested by Paul, implemented by Arnd, and pushed out
> by Becky.  I am not the droid you are looking for.

rwsems on ppc64 should really be using a 64-bit counter, not a 32-bit counter,
otherwise you limit the maximum number of processes to 32K-ish.

The counter should be "signed long" really.

David
