Return-Path: <dhowells@redhat.com>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050923074413.GD19971@krispykreme> 
References: <20050923074413.GD19971@krispykreme> <E1EIXAI-0006Q0-OS@jdl.com>
	<606.1127460740@warthog.cambridge.redhat.com>
To: Anton Blanchard <anton@samba.org>
Date: Fri, 23 Sep 2005 08:52:30 +0100
Message-ID: <1280.1127461950@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc Merge asm-ppc*/rwsem.h 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote:

> > The counter should be "signed long" really.
> 
> Agreed, we should move to a 64bit count.

With a 64-bit counter, the constants should be:

#define RWSEM_UNLOCKED_VALUE		  0x0000000000000000L
#define RWSEM_ACTIVE_BIAS		  0x0000000000000001L
#define RWSEM_ACTIVE_MASK		  0x00000000ffffffffL
#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)

Just like in the asm-s390/rwsem.h.

David
