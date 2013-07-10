Return-Path: <michael@ellerman.id.au>
Date: Wed, 10 Jul 2013 12:12:15 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] powerpc/perf: Rework disable logic in pmu_disable()
Message-ID: <20130710021214.GB7491@concordia>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-2-git-send-email-michael@ellerman.id.au>
 <51C97D7F.4030405@linux.vnet.ibm.com>
 <20130710001523.GA24980@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130710001523.GA24980@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 09, 2013 at 05:15:23PM -0700, Sukadev Bhattiprolu wrote:
> Anshuman Khandual [khandual@linux.vnet.ibm.com] wrote:
> | On 06/24/2013 04:58 PM, Michael Ellerman wrote:
> | > In pmu_disable() we disable the PMU by setting the FC (Freeze Counters)
> | > bit in MMCR0. In order to do this we have to read/modify/write MMCR0.
> | > 
> | > It's possible that we read a value from MMCR0 which has PMAO (PMU Alert
> | > Occurred) set. When we write that value back it will cause an interrupt
> | > to occur. We will then end up in the PMU interrupt handler even though
> | > we are supposed to have just disabled the PMU.
> | > 
> | 
> | Is that possible ? First of all MMCR0[PMAO] could not be written by SW.
> | Even if you try writing it, how its going to generate PMU interrupt ?
> | HW sets this bit MMCR0[PMAO] after a PMU interrupt has already occurred
> | not that if we set this, a PMU interrupt would be generated.
> 
> Looks like writing 1 MMCR0[PMAO] is allowed (to save interrupts across
> partition swaps) and it does generate the interrupt.

Yes it's documented in the ISA.

> | > We can avoid this by making sure we never write PMAO back. We should not
> | 
> | Making sure that we dont write PMAO back is a good idea though.
> | 
> | > lose interrupts because when the PMU is re-enabled the overflowed values
> | > will cause another interrupt.
> 
> Is it enough to set the FC and clear the PMAO - or should we also clear the
> PMAE in pmu_disable() (and set it back in pmu_enable()) ?

Yeah that's on my todo list, I just haven't got around to it. I think
clearing PMAE would be more in keeping with what the HW folks
have in mind, but it's a fairly major change so we'd need to test it
across all supported hardware.

It's not that easy to test because if you miss an interrupt rarely you
will generally not notice it. You'll just see a slightly lower count
for the event which you will just put down to variability.

> The PMU spec says "...Alert will occur when enabled condition or event exists
> and Performance Monitor Alerts are enabled through MMCR0[PMAE] field"
> 
> The condition of overflowing counter will still exist and the PMAE is still
> set. So, won't the PMU simply turn PMAO back on after we clear it ?

Not that I've observed. It's not clear to me that the architecture and
the hardware agree 100% on some of these corner cases, but proving it
one way or the other is tricky.
 
cheers
