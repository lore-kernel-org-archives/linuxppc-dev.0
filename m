Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E7EECB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 02:21:39 +1100 (EST)
Message-ID: <1329232814.2293.7.camel@twins>
Subject: Re: smp: Start up non-boot CPUs asynchronously
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Arjan van de Ven <arjanvandeven@gmail.com>
Date: Tue, 14 Feb 2012 16:20:14 +0100
In-Reply-To: <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
References: <20120130205444.22f5e26a@infradead.org>
 <20120131125232.GD4408@elte.hu> <20120131054155.371e8307@infradead.org>
 <20120131143130.GF13676@elte.hu> <20120131072216.1ce78e50@infradead.org>
 <20120131161207.GA18357@elte.hu> <20120131082439.575978c0@infradead.org>
 <4F3A1891.8060001@linux.vnet.ibm.com> <4F3A2DFB.5000209@linux.vnet.ibm.com>
 <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mikey@neuling.org,
 gregkh@linuxfoundation.org, Ingo Molnar <mingo@elte.hu>,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arjan van de Ven <arjan@linux.intel.com>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-02-14 at 06:31 -0800, Arjan van de Ven wrote:
>=20
> frankly, such code HAS to worry about cpus going online and offline
> even today; the firmware, at least on X86, can start taking cores
> offline/online once ACPI is initialized.... (as controlled by a data
> center manager from outside the box, usually done based on thermal or
> power conditions on a datacenter level). Now, no doubt that we have
> bugs in this space, since this only happened very rarely before.=20

Which frankly is an utter piece of crap, that ACPI spec is total garbage
and completely useless. You might have noticed that the ACPI code
supporting that failure carries a big nacked-by from me.

That's not to say we shouldn't try to fix hotplug, but bringing that
ACPI nonsense to the table makes me care less, not more.

I mean, really, that spec is broken, the support is worse.
