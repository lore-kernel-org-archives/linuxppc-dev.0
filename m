Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yKZVL74cMzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Oct 2017 20:48:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>, linuxppc-dev@ozlabs.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com
Subject: Re: [PATCH 3/4] powerpc/powernv: Enable TM without suspend if possible
In-Reply-To: <8760bbb6su.fsf@linux.vnet.ibm.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <1507803439-12862-3-git-send-email-mpe@ellerman.id.au>
 <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
 <8760bbb6su.fsf@linux.vnet.ibm.com>
Date: Sun, 22 Oct 2017 20:48:33 +1100
Message-ID: <87376bo6mm.fsf@concordia.ellerman.id.au>
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

Hi all,

Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com> writes:
> Forwarding some comments from Adhemerval sent to libc-alpha [1]...
>
> Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
>>Florian Weimer <fweimer@redhat.com> writes:
>>
>>> On 10/12/2017 12:17 PM, Michael Ellerman wrote:
>>>> +	pr_info("Enabling TM (Transactional Memory) with Suspend Disabled\n");
>>>> +	cur_cpu_spec->cpu_features |= CPU_FTR_TM;
>>>> +	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_HTM_NO_SUSPEND;
>>>> +	tm_suspend_disabled = true;
>>>
>>> This doesn't look right because if suspend is not available, you need to 
>>> clear the original PPC_FEATURE2_HTM flag because the semantics are not 
>>> right, so that applications can use fallback code.  Otherwise, 
>>> applications may incorrectly select the HTM code and break if running on 
>>> a system which supports HTM, but without the suspend state.
...
>> I completely agree with Florian here, this is as *ABI* change
>> and the kernel need to advertise a different TM ABI instead
>> of as an extension.

Sorry for the slow reply, I'm travelling.

You're all misreading the patch, when we enter into this hunk of code TM
is disabled, so PPC_FEATURE2_HTM is *not set*.

If we can configure no suspend mode, then we turn on *only* the new
HTM_NO_SUSPEND bit.

So yes it is an ABI change, and we advertise it as such. User space code
that wants to use "no suspend mode" has to opt-in by checking for the
new feature bit.

I've updated the patch to make this clearer. I've also added HTM_NOSC
because that should still be set (it describes kernel behaviour not
hardware).

cheers

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index cf52d53da460..d23f148a11f0 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -304,6 +305,28 @@ static int __init pnv_probe(void)
        return 1;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void __init pnv_tm_init(void)
+{
+       if (!firmware_has_feature(FW_FEATURE_OPAL) ||
+           !pvr_version_is(PVR_POWER9) ||
+           early_cpu_has_feature(CPU_FTR_TM))
+               return;
+
+       if (opal_reinit_cpus(OPAL_REINIT_CPUS_TM_SUSPEND_DISABLED) != OPAL_SUCCESS)
+               return;
+
+       pr_info("Enabling TM (Transactional Memory) with Suspend Disabled\n");
+       cur_cpu_spec->cpu_features |= CPU_FTR_TM;
+       /* Make sure "normal" HTM is off (it should be) */
+       cur_cpu_spec->cpu_user_features2 &= ~PPC_FEATURE2_HTM;
+       /* Turn on no suspend mode, and HTM no SC */
+       cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_HTM_NO_SUSPEND | \
+                                           PPC_FEATURE2_HTM_NOSC;
+       tm_suspend_disabled = true;
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+
 /*
  * Returns the cpu frequency for 'cpu' in Hz. This is used by
  * /proc/cpuinfo
