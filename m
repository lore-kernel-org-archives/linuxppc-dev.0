Return-Path: <srs0=6tmr=bs=linux.vnet.ibm.com=tuliom@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHnfn1117zDqhj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:04:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yHnfm6jvqz8t9Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:04:48 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yHnfl2pNmz9sNV
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2017 23:04:47 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JBxZsk037047
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2017 08:04:45 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dptma438y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2017 08:04:44 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <tuliom@linux.vnet.ibm.com>;
 Thu, 19 Oct 2017 08:04:42 -0400
From: "Tulio Magno Quites Machado Filho" <tuliom@linux.vnet.ibm.com>
To: Florian Weimer <fweimer@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@ozlabs.org
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com
Cc: 
Subject: Re: [PATCH 3/4] powerpc/powernv: Enable TM without suspend if possible
In-Reply-To: <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <1507803439-12862-3-git-send-email-mpe@ellerman.id.au>
 <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
Date: Thu, 19 Oct 2017 10:04:36 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efpzbay3.fsf@linux.vnet.ibm.com>
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
> right, so that applications can use fallback code.  Otherwise, 
> applications may incorrectly select the HTM code and break if running on 
> a system which supports HTM, but without the suspend state.

Just clarifying: it won't break an application, but abort the transaction,
which can cause a performance hit.

> The new flag should say that HTM is supported, but without the suspend 
> state, and it should be always set if PPC_FEATURE2_HTM is set.

If we change the semantics of this bit, old applications that don't suspend
transactions won't run on these processors, even if they're safe to run.

If we adopt the current semantics, only applications that enter in suspend
state will have to be modified in order to not get a performance regression.

-- 
Tulio Magno
