Return-Path: <cl@gentwo.org>
Received: from qmta02.emeryville.ca.mail.comcast.net
 (qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
 by lists.ozlabs.org (Postfix) with ESMTP id A8DF61A03D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 05:37:15 +1000 (EST)
Date: Wed, 11 Jun 2014 14:37:08 -0500 (CDT)
From: Christoph Lameter <cl@gentwo.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: power and percpu: Could we move the paca into the percpu area?
Message-ID: <alpine.DEB.2.10.1406111426480.10600@gentwo.org>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tejun Heo <htejun@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Looking at arch/powerpc/include/asm/percpu.h I see that the per cpu offset
comes from a local_paca field and local_paca is in r13. That means that
for all percpu operations we first have to determine the address through a
memory access.

Would it be possible to put the paca at the beginning of the percpu data
area and then have r31 point to the percpu area?

power has these nice instructions that fetch from an offset relative to a
base register which could be used throughout for percpu operations in the
kernel (similar to x86 segment registers).

With that we may also be able to use the atomic ops for fast percpu access
so that we can avoid the irq enable/disable sequence that is now required
for percpu atomics. Would result in fast and reliable percpu
counters for powerpc.

I.e. powerpc atomic inc
static __inline__ void atomic_inc(atomic_t *v)
{
        int t;

        __asm__ __volatile__(
"1:     lwarx   %0,0,%2         # atomic_inc\n\
        addic   %0,%0,1\n"
        PPC405_ERR77(0,%2)
"       stwcx.  %0,0,%2 \n\
        bne-    1b"
        : "=&r" (t), "+m" (v->counter)
        : "r" (&v->counter)
        : "cc", "xer");
}

Could be used as a template to get:

static __inline__ void raw_cpu_inc_4(__percpu void *v)
{
        int t;

        __asm__ __volatile__(
"1:     lwarx   %0,r31,%2         # percpu_inc\n\
        addic   %0,%0,1\n"
        PPC405_ERR77(0,%2)
"       stwcx.  %0,r31,%2 \n\
        bne-    1b"
        : "=&r" (t), "+m" (v)
        : "r" (&v->counter)
        : "cc", "xer");
}
