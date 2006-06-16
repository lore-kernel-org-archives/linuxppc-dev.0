Return-Path: <mkravetz@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7AE3367B3F
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jun 2006 02:11:09 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5GGB5Mr022040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 12:11:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5GGB5B6253146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 12:11:05 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5GGB5Zn016516
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 12:11:05 -0400
Date: Fri, 16 Jun 2006 09:11:19 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060616161119.GB3256@w-mikek2.ibm.com>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035258.GC6759@monkey.ibm.com>
	<20060614144230.GE26750@localdomain>
	<17552.36563.460775.131555@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17552.36563.460775.131555@cargo.ozlabs.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 15, 2006 at 08:33:55AM +1000, Paul Mackerras wrote:
> Nathan Lynch writes:
> 
> > Without disabling preemption around the mfspr ... update_stats section
> > in these hcall wrappers, you risk updating the stats on the wrong cpu.
> 
> I think we are only looking for total counts and times anyway, so it
> doesn't really matter which cpu updates the stats, as long as the time
> gets accounted on some cpu.  The use of per-cpu counters is just for
> better cache behaviour.

Thought about this a little more.

We do an mfspr to get a 'timestamp' before the actual hcall.  Then, make
the hcall and do another mfspr after.  Isn't it possible to be preempted
and perform the mfspr's on separate CPUs?  Worse yet, wouldn't this possibly
add 'time preempted' to the hcall time?.  Do we have the same (skewed time)
issue with interrupts?

Thinking that enable/disable around the call might be worth the overhead.
But, disabling interrupts would not be worth it.

-- 
Mike
