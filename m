Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7CC2B2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:54:27 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20140207090248.GB26811@lst.de>
Date: Fri, 7 Feb 2014 09:51:16 -0600
Message-Id: <87C29DBB-41E7-4B6C-9089-3C7756FBAE07@kernel.crashing.org>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <1391717992.6733.232.camel@snotra.buserror.net>
 <20140207090248.GB26811@lst.de>
To: Torsten Duwe <duwe@lst.de>
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Scott Wood <scottwood@freescale.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 7, 2014, at 3:02 AM, Torsten Duwe <duwe@lst.de> wrote:

> On Thu, Feb 06, 2014 at 02:19:52PM -0600, Scott Wood wrote:
>> On Thu, 2014-02-06 at 18:37 +0100, Torsten Duwe wrote:
>>> On Thu, Feb 06, 2014 at 05:38:37PM +0100, Peter Zijlstra wrote:
>>=20
>>>> Can you pair lwarx with sthcx ? I couldn't immediately find the =
answer
>>>> in the PowerISA doc. If so I think you can do better by being able =
to
>>>> atomically load both tickets but only storing the head without =
affecting
>>>> the tail.
>=20
> Can I simply write the half word, without a reservation, or will the =
HW caches
> mess up the other half? Will it ruin the cache coherency on some =
(sub)architectures?

The coherency should be fine, I just can=92t remember if you=92ll lose =
the reservation by doing this.

>> Plus, sthcx doesn't exist on all PPC chips.
>=20
> Which ones are lacking it? Do all have at least a simple 16-bit store?

Everything implements a simple 16-bit store, just not everything =
implements the store conditional of 16-bit data.

- k=
