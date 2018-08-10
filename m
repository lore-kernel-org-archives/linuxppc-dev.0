Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mxBh3KR5zF0PT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 17:11:55 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id l9-v6so4084636pff.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 00:11:55 -0700 (PDT)
Date: Fri, 10 Aug 2018 17:11:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/64s: reimplement book3s idle code in C
Message-ID: <20180810171146.48ce9fd1@roar.ozlabs.ibm.com>
In-Reply-To: <20180810064249.13724-2-npiggin@gmail.com>
References: <20180810064249.13724-1-npiggin@gmail.com>
 <20180810064249.13724-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Aug 2018 16:42:49 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Reimplement Book3S idle code in C, moving POWER7/8/9 implementation
> speific HV idle code to the powernv platform code.
> 
> Book3S assembly stubs are kept in common code and used only to save
> the stack frame and non-volatile GPRs before executing architected
> idle instructions, and restoring the stack and reloading GPRs then
> returning to C after waking from idle.
> 
> The complex logic dealing with threads and subcores, locking, SPRs,
> HMIs, timebase resync, etc., is all done in C which makes it more
> maintainable.
> 
> This is not a strict translation to C code, there are some
> significant differences:
> 
> - Idle wakeup no longer uses the ->cpu_restore call to reinit SPRs,
>   but saves and restores them itself.
> 
> - The optimisation where EC=ESL=0 idle modes did not have to save GPRs
>   or change MSR is restored, because it's now simple to do. ESL=1
>   sleeps that do not lose GPRs can use this optimization too.
> 
> - KVM secondary entry and cede is now more of a call/return style
>   rather than branchy. nap_state_lost is not required because KVM
>   always returns via NVGPR restoring path.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Left to do:
> - KVM could use more review, it's pretty tricky. Not sure if what
>   I'm doing with the emergency stack is kosher. But it runs pretty fine
>   here with a POWER9 SMP+SMT guest. Possible to streamline

That should be POWER8. POWER9 radix on hash with dependent threads
mode also seems to work okay.

Thanks,
Nick
