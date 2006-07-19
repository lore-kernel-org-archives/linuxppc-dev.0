Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F191D67B8A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 13:37:53 +1000 (EST)
Date: Tue, 18 Jul 2006 22:33:00 -0500
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060719033300.GA9451@pb15.lixom.net>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
	<20060718204946.GC6104@w-mikek2.ibm.com>
	<20060718223425.GB5238@pb15.lixom.net>
	<20060718231815.GC3091@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060718231815.GC3091@w-mikek2.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 04:18:15PM -0700, Mike Kravetz wrote:

> I assume checking must be done at run time via something like,
> if (cpu_has_feature(CPU_FTR_PURR))

If you do it in the hcall asm instead (like Paulus suggested), then it's
better to use BEGIN_FTR_SECTION/END_FTR_SECTION() around it, that way
the PURR reads just get nopped out instead of adding tests and branches.

> Also assume that it would make sense to do this determination at
> initialization/boot time and put the result in the statistic data
> structure.  In this way we would know it is in the same cache line
> we are updating with other stats.  Or, should cur_cpu_spec->cpu_features
> be 'sufficiently hot' to make this a non-issue?

If you use the FTR_SECTION stuff then it'll be taken care of
automatically at boot time. Doing that from C is messy, I don't think
anyone has had reason to do it before.


-Olof
