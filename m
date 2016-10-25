Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3BFn4HK6zDvjg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 22:46:53 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t3BFn03pjz9svs
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 22:46:52 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9PBi3R6016842
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 07:46:50 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26a4bx0ebc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2016 07:46:50 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 07:46:50 -0400
Date: Tue, 25 Oct 2016 17:16:44 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/64: Fix race condition in setting lock bit
 in idle/wakeup code
Reply-To: ego@linux.vnet.ibm.com
References: <20161021090305.GA3809@fergus.ozlabs.ibm.com>
 <20161021090417.GB3809@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021090417.GB3809@fergus.ozlabs.ibm.com>
Message-Id: <20161025114644.GC3244@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On Fri, Oct 21, 2016 at 08:04:17PM +1100, Paul Mackerras wrote:
> This fixes a race condition where one thread that is entering or
> leaving a power-saving state can inadvertently ignore the lock bit
> that was set by another thread, and potentially also clear it.
> The core_idle_lock_held function is called when the lock bit is
> seen to be set.  It polls the lock bit until it is clear, then
> does a lwarx to load the word containing the lock bit and thread
> idle bits so it can be updated.  However, it is possible that the
> value loaded with the lwarx has the lock bit set, even though an
> immediately preceding lwz loaded a value with the lock bit clear.
> If this happens then we go ahead and update the word despite the
> lock bit being set, and when called from pnv_enter_arch207_idle_mode,
> we will subsequently clear the lock bit.
> 
> No identifiable misbehaviour has been attributed to this race.
> 
> This fixes it by checking the lock bit in the value loaded by the
> lwarx.  If it is set then we just go back and keep on polling.
> 
> Fixes: b32aadc1a8ed

This fixes the code which has been around since 4.2 kernel. Should
this be marked to stable as well ?

> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 0d8712a..72dac0b 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -90,6 +90,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>   * Threads will spin in HMT_LOW until the lock bit is cleared.
>   * r14 - pointer to core_idle_state
>   * r15 - used to load contents of core_idle_state
> + * r9  - used as a temporary variable
>   */
> 
>  core_idle_lock_held:
> @@ -99,6 +100,8 @@ core_idle_lock_held:
>  	bne	3b
>  	HMT_MEDIUM
>  	lwarx	r15,0,r14
> +	andi.	r9,r15,PNV_CORE_IDLE_LOCK_BIT
> +	bne	core_idle_lock_held
>  	blr
> 
>  /*
> -- 
> 2.7.4
> 

--
Thanks and Regards
gautham.
