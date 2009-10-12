Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B255B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 05:30:41 +1100 (EST)
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
	register a set of idle routines.
From: Andi Kleen <andi@firstfloor.org>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	<20091008095027.GC20595@linux.vnet.ibm.com>
	<1254998162.26976.270.camel@twins>
	<20091008104249.GJ20595@linux.vnet.ibm.com>
	<1254999033.26976.272.camel@twins>
Date: Mon, 12 Oct 2009 20:00:05 +0200
In-Reply-To: <1254999033.26976.272.camel@twins> (Peter Zijlstra's message of
	"Thu, 08 Oct 2009 12:50:33 +0200")
Message-ID: <8763akh4re.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, arun@linux.vnet.ibm.com,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra <a.p.zijlstra@chello.nl> writes:
>
> So does it make sense to have a set of sets?
>
> Why not integrate them all into one set to be ruled by this governor
> thing?

cpuidle is currently optional, that is why the two level hierarchy
is there so that you can still have simple idle selection without it.

% size drivers/cpuidle/*.o
   text    data     bss     dec     hex filename
   5514    1416      44    6974    1b3e drivers/cpuidle/built-in.o

Adding it unconditionally would add ~7k to everyone who wants idle functions.

I think making it unconditional would require putting it on a serious
diet first.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
