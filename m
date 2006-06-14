Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 9757067B73
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 08:40:55 +1000 (EST)
Date: Wed, 14 Jun 2006 17:40:40 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060614224040.GH26750@localdomain>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035258.GC6759@monkey.ibm.com>
	<20060614144230.GE26750@localdomain>
	<17552.36563.460775.131555@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17552.36563.460775.131555@cargo.ozlabs.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Nathan Lynch writes:
> 
> > Without disabling preemption around the mfspr ... update_stats section
> > in these hcall wrappers, you risk updating the stats on the wrong cpu.
> 
> I think we are only looking for total counts and times anyway, so it
> doesn't really matter which cpu updates the stats, as long as the time
> gets accounted on some cpu.  The use of per-cpu counters is just for
> better cache behaviour.

Makes sense... then perhaps the stats shouldn't be exported in per-cpu
files in sysfs, and the kernel should calculate and report the totals
to userspace in some other form.
