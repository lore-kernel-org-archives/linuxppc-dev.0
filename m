Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9A50DDE07
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 03:48:12 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA3Gm2A1015690
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Nov 2007 12:48:02 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA3Gm2mJ072318
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Nov 2007 10:48:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA3Gm1ZX020009
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Nov 2007 10:48:02 -0600
Message-ID: <472CA62D.8050205@linux.vnet.ibm.com>
Date: Sat, 03 Nov 2007 22:17:41 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Restore deterministic CPU accounting on powerpc
References: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
	<661de9470711030202x24d0186cuc96a70156ecfa23f@mail.gmail.com>
	<18220.24362.604297.53633@cargo.ozlabs.ibm.com>
In-Reply-To: <18220.24362.604297.53633@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Balbir Singh writes:
> 
>> So, scaled accounting will not be available if
>> CONFIG_VIRT_CPU_ACCOUNTING is defined? Am I reading this correctly
> 
> No, what makes you think that?  If VIRT_CPU_ACCOUNTING=y it is the
> responsibility of the arch's account_process_tick to update the scaled
> stats.  And the powerpc version does that by calling
> account_user_time_scaled().
> 
> Paul.

I looked at the diff's and could just see the reversal of scaled
accounting. I looked at account_process_vtime(), now
account_process_tick() and things seem fine. I was mislead by the
diff.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
