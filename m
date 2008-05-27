Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18492.37741.798622.696166@cargo.ozlabs.ibm.com>
Date: Wed, 28 May 2008 09:04:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <483C7BE7.10204@nortel.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211906268.3435.44.camel@localhost.localdomain>
	<adad4n71wb3.fsf@cisco.com>
	<1211910825.7160.1.camel@localhost.localdomain>
	<adamymbvcxi.fsf@cisco.com> <483C7BE7.10204@nortel.com>
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen writes:

> Roland Dreier wrote:
> 
> > Writes are posted yes, but not reordered arbitrarily.  If I have code like:
> > 
> > 	spin_lock(&mmio_lock);
> > 	writel(val1, reg1);
> > 	writel(val2, reg2);
> > 	spin_unlock(&mmio_lock);
> > 
> > then I have a reasonable expectation that if two CPUs run this at the
> > same time, their writes to reg1/reg2 won't be interleaved with each
> > other (because the whole section is inside a spinlock).  And Altix
> > violates that expectation.
> 
> Does that necessarily follow?
> 
> If you've got a large system with multiple pci bridges, could you end up 
> with posted writes coming from different cpus taking a different amount 
> of time to propagate to a device and thus colliding?

On powerpc we explicitly make sure that can't happen.  That's the "do
a sync in spin_unlock if there were any writels since the last
spin_lock" magic.  The sync instruction makes sure the writes have got
to the host bridge before the spinlock is unlocked.

Paul.
