Return-Path: <paulus@ozlabs.org>
Date: Fri, 27 May 2011 20:33:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Message-ID: <20110527103334.GA4236@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc@vger.kernel.org,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 17, 2011 at 12:17:50PM +0200, Alexander Graf wrote:
> 
> On 16.05.2011, at 07:58, Paul Mackerras wrote:
> 
> > I do the check there because I was having problems where, if the HDEC
> > goes negative before we do the partition switch, we would occasionally
> > not get the HDEC interrupt at all until the next time HDEC went
> > negative, ~ 8.4 seconds later.
> 
> Yikes - so HDEC is edge and doesn't even keep the interrupt line up?
> That sounds like a serious hardware limitation. What if you only use
> HDEC and it triggers while interrupts are off in a critical section?
> Is the hardware really that broken?

If HDEC expires when interrupts are off, the HDEC interrupt stays
pending until interrupts get re-enabled.  I'm not sure exactly what
the conditions are that cause an HDEC interrupt to get lost, but they
seem to involve at least a partition switch.

Paul.
