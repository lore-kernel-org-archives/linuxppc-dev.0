Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415Fcj0KZ3zDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 15:27:17 +1000 (AEST)
Subject: Re: [RFC PATCH 22/23] watchdog/hardlockup/hpet: Only enable the HPET
 watchdog via a boot parameter
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <frederic@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Colin Ian King <colin.king@canonical.com>,
 Byungchul Park <byungchul.park@lge.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Waiman Long <longman@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 David Rientjes <rientjes@google.com>, iommu@lists.linux-foundation.org
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c2edf778-79cf-009d-6617-13e54ad8b93b@infradead.org>
Date: Tue, 12 Jun 2018 22:26:57 -0700
MIME-Version: 1.0
In-Reply-To: <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2018 05:57 PM, Ricardo Neri wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2040d4..a8833c7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2577,7 +2577,7 @@
>  			Format: [state][,regs][,debounce][,die]
>  
>  	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
> -			Format: [panic,][nopanic,][num]
> +			Format: [panic,][nopanic,][num,][hpet]
>  			Valid num: 0 or 1
>  			0 - turn hardlockup detector in nmi_watchdog off
>  			1 - turn hardlockup detector in nmi_watchdog on

This says that I can use "nmi_watchdog=hpet" without using 0 or 1.
Is that correct?

> @@ -2587,6 +2587,9 @@
>  			please see 'nowatchdog'.
>  			This is useful when you use a panic=... timeout and
>  			need the box quickly up again.
> +			When hpet is specified, the NMI watchdog will be driven
> +			by an HPET timer, if available in the system. Otherwise,
> +			the perf-based implementation will be used.
>  
>  			These settings can be accessed at runtime via
>  			the nmi_watchdog and hardlockup_panic sysctls.


thanks,
-- 
~Randy
