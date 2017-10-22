Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yKZdQ41QkzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Oct 2017 20:54:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Florian Weimer <fweimer@redhat.com>, linuxppc-dev@ozlabs.org
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com
Subject: Re: [PATCH 3/4] powerpc/powernv: Enable TM without suspend if possible
In-Reply-To: <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <1507803439-12862-3-git-send-email-mpe@ellerman.id.au>
 <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
Date: Sun, 22 Oct 2017 20:54:43 +1100
Message-ID: <87y3o3mrrw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Florian Weimer <fweimer@redhat.com> writes:

> On 10/12/2017 12:17 PM, Michael Ellerman wrote:
>> +	pr_info("Enabling TM (Transactional Memory) with Suspend Disabled\n");
>> +	cur_cpu_spec->cpu_features |= CPU_FTR_TM;
>> +	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_HTM_NO_SUSPEND;
>> +	tm_suspend_disabled = true;
>
> This doesn't look right because if suspend is not available, you need to 
> clear the original PPC_FEATURE2_HTM flag because the semantics are not 
> right, so that applications can use fallback code.

Yes I agree, but the PPC_FEATURE2_HTM bit is already clear. I've updated
the patch to clear it explicitly, see my other mail.

> Otherwise, 
> applications may incorrectly select the HTM code and break if running on 
> a system which supports HTM, but without the suspend state.

Yes.

> The new flag should say that HTM is supported, but without the suspend 
> state, and it should be always set if PPC_FEATURE2_HTM is set.

I don't agree with that. HTM and HTM_NO_SUSPEND are mutually exclusive.

I don't understand how it would work if HTM_NO_SUSPEND was "always set
if PPC_FEATURE2_HTM is set"? That would tell apps that HTM with suspend
is supported and HTM without suspend is supported, which is meaningless
AFAICS.

cheers
