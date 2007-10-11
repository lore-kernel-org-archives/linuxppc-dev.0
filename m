Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18189.26776.326248.278431@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2007 10:04:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: Hard hang in hypervisor!?
In-Reply-To: <20071009212810.GN4350@austin.ibm.com>
References: <20071009203724.GM4350@austin.ibm.com>
	<20071009211819.GR29559@localdomain>
	<20071009212810.GN4350@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> Err ..  it was cpu 0 that was spinlocked.  Are interrupts not
> distributed?

We have some bogosities in the xics code that I noticed a couple of
days ago.  Basically we only set the xics to distribute interrupts to
all cpus if (a) the affinity mask is equal to CPU_MASK_ALL (which has
ones in every bit position from 0 to NR_CPUS-1) and (b) all present
cpus are online (cpu_online_map == cpu_present_map).  Otherwise we
direct interrupts to the first cpu in the affinity map.  So you can
easily have the affinity mask containing all the online cpus and still
not get distributed interrupts.

So in your case it's quite possible that all interrupts were directed
to cpu 0.

Paul.
