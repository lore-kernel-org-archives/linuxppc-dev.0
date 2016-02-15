Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 799521A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 04:58:27 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 15 Feb 2016 12:58:23 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id ABF746E8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:45:12 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FHwKa736372500
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 17:58:20 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FHwJQp027185
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 12:58:20 -0500
Date: Mon, 15 Feb 2016 09:58:25 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: will.deacon@arm.com, Andy.Glew@imgtec.com, Leonid.Yegoshin@imgtec.com,
 peterz@infradead.org, linux-arch@vger.kernel.org, arnd@arndb.de,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org
Cc: graham.whaley@gmail.com, torvalds@linux-foundation.org, hpa@zytor.com,
 mingo@kernel.org
Subject: Writes, smp_wmb(), and transitivity?
Message-ID: <20160215175825.GA15878@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

Some architectures provide local transitivity for a chain of threads doing
writes separated by smp_wmb(), as exemplified by the litmus tests below.
The pattern is that each thread writes to a its own variable, does an
smp_wmb(), then writes a different value to the next thread's variable.

I don't know of a use of this, but if everyone supports it, it might
be good to mandate it.  Status quo is that smp_wmb() is non-transitive,
so it currently isn't supported.

Anyone know of any architectures that do -not- support this?

Assuming all architectures -do- support this, any arguments -against-
officially supporting it in Linux?

							Thanx, Paul

------------------------------------------------------------------------

Two threads:

	int a, b;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1);

Three threads:

	int a, b, c;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(c, 2);
	}

	void thread2(void)
	{
		WRITE_ONCE(c, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1 && c == 1);

Four threads:

	int a, b, c, d;

	void thread0(void)
	{
		WRITE_ONCE(a, 1);
		smp_wmb();
		WRITE_ONCE(b, 2);
	}

	void thread1(void)
	{
		WRITE_ONCE(b, 1);
		smp_wmb();
		WRITE_ONCE(c, 2);
	}

	void thread2(void)
	{
		WRITE_ONCE(c, 1);
		smp_wmb();
		WRITE_ONCE(d, 2);
	}

	void thread3(void)
	{
		WRITE_ONCE(d, 1);
		smp_wmb();
		WRITE_ONCE(a, 2);
	}

	/* After all threads have completed and the dust has settled... */

	BUG_ON(a == 1 && b == 1 && c == 1 && d == 1);

And so on...
