Return-Path: <michael@ellerman.id.au>
Date: Wed, 26 Jun 2013 13:28:22 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] powerpc/perf: Rework disable logic in pmu_disable()
Message-ID: <20130626032822.GA10796@concordia>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-2-git-send-email-michael@ellerman.id.au>
 <51C97D7F.4030405@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51C97D7F.4030405@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 25, 2013 at 04:52:39PM +0530, Anshuman Khandual wrote:
> On 06/24/2013 04:58 PM, Michael Ellerman wrote:
> > In pmu_disable() we disable the PMU by setting the FC (Freeze Counters)
> > bit in MMCR0. In order to do this we have to read/modify/write MMCR0.
> > 
> > It's possible that we read a value from MMCR0 which has PMAO (PMU Alert
> > Occurred) set. When we write that value back it will cause an interrupt
> > to occur. We will then end up in the PMU interrupt handler even though
> > we are supposed to have just disabled the PMU.
> > 
> 
> Is that possible ? First of all MMCR0[PMAO] could not be written by SW.
> Even if you try writing it, how its going to generate PMU interrupt ?
> HW sets this bit MMCR0[PMAO] after a PMU interrupt has already occurred
> not that if we set this, a PMU interrupt would be generated.

Yes it's possible.

cheers
