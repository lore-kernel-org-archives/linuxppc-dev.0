Return-Path: <frankvm@frankvm.com>
Received: from janus.localdomain (frankvm.xs4all.nl [80.126.170.174])
	by ozlabs.org (Postfix) with ESMTP id DDE0B67B58
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 02:01:28 +1000 (EST)
Date: Wed, 29 Jun 2005 16:50:13 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050629145013.GA21494@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: include/asm-ppc/atomic.h: fluff in inline assembly code?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does anyone know why there are often excess arguments in asm() here?

For example,

	static __inline__ void atomic_add(int a, atomic_t *v)
	{
		int t;

		__asm__ __volatile__(
	"1:     lwarx   %0,0,%3         # atomic_add\n\
		add     %0,%2,%0\n"
		PPC405_ERR77(0,%3)
	"       stwcx.  %0,0,%3 \n\
		bne-    1b"
		: "=&r" (t), "=m" (v->counter)
		: "r" (a), "r" (&v->counter), "m" (v->counter)
		: "cc");
	}

seems equivalent to 

	static __inline__ void atomic_add(int a, atomic_t *v)
	{
		int t;

		__asm__ __volatile__(
	"1:     lwarx   %0,0,%2         # atomic_add\n\
		add     %0,%1,%0\n"
		PPC405_ERR77(0,%2)
	"       stwcx.  %0,0,%2 \n\
		bne-    1b"
		: "=&r" (t)
		: "r" (a), "r" (&v->counter)
		: "cc");
	}

What is the point of all those v->counter arguments?

-- 
Frank
