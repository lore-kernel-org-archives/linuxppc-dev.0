Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90187C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:40:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1385F20673
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435Ftk4bwhzDqx5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 22:39:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435Fqs2HlVzDqW7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 22:37:28 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74BB7A405C;
 Thu, 29 Nov 2018 11:37:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-253.ams2.redhat.com
 [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 084ED608DA;
 Thu, 29 Nov 2018 11:37:24 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <2d62c9e2-375b-2791-32ce-fdaa7e7664fd@intel.com>
 <87bm6zaa04.fsf@oldenburg.str.redhat.com>
 <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
 <87efbqqze4.fsf@oldenburg.str.redhat.com>
 <20181127102350.GA5795@ram.oc3035372033.ibm.com>
 <87zhtuhgx0.fsf@oldenburg.str.redhat.com>
 <58e263a6-9a93-46d6-c5f9-59973064d55e@intel.com>
Date: Thu, 29 Nov 2018 12:37:15 +0100
In-Reply-To: <58e263a6-9a93-46d6-c5f9-59973064d55e@intel.com> (Dave Hansen's
 message of "Tue, 27 Nov 2018 07:31:38 -0800")
Message-ID: <87va4g5d3o.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 29 Nov 2018 11:37:26 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-api@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Dave Hansen:

> On 11/27/18 3:57 AM, Florian Weimer wrote:
>> I would have expected something that translates PKEY_DISABLE_WRITE |
>> PKEY_DISABLE_READ into PKEY_DISABLE_ACCESS, and also accepts
>> PKEY_DISABLE_ACCESS | PKEY_DISABLE_READ, for consistency with POWER.
>> 
>> (My understanding is that PKEY_DISABLE_ACCESS does not disable all
>> access, but produces execute-only memory.)
>
> Correct, it disables all data access, but not execution.

So I would expect something like this (completely untested, I did not
even compile this):

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 20ebf153c871..bed23f9e8336 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -199,6 +199,11 @@ static inline bool arch_pkeys_enabled(void)
 	return !static_branch_likely(&pkey_disabled);
 }
 
+static inline bool arch_pkey_access_rights_valid(unsigned long rights)
+{
+	return (rights & ~(unsigned long)PKEY_ACCESS_MASK) == 0;
+}
+
 extern void pkey_mm_init(struct mm_struct *mm);
 extern bool arch_supports_pkeys(int cap);
 extern unsigned int arch_usable_pkeys(void);
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 19b137f1b3be..e3e1d5a316e8 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -14,6 +14,17 @@ static inline bool arch_pkeys_enabled(void)
 	return boot_cpu_has(X86_FEATURE_OSPKE);
 }
 
+static inline bool arch_pkey_access_rights_valid(unsigned long rights)
+{
+	if (rights & ~(unsigned long)PKEY_ACCESS_MASK)
+		return false;
+	if (rights & PKEY_DISABLE_READ) {
+		/* x86 can only disable read access along with write access. */
+		return rights & (PKEY_DISABLE_WRITE | PKEY_DISABLE_ACCESS);
+	}
+	return true;
+}
+
 /*
  * Try to dedicate one of the protection keys to be used as an
  * execute-only protection key.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7642d3..b9b78145017f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -928,7 +928,13 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		return -EINVAL;
 
 	/* Set the bits we need in PKRU:  */
-	if (init_val & PKEY_DISABLE_ACCESS)
+	if (init_val & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_READ))
+		/*
+		 * arch_pkey_access_rights_valid checked that
+		 * PKEY_DISABLE_READ is actually representable on x86
+		 * (that is, it comes with PKEY_DISABLE_ACCESS or
+		 * PKEY_DISABLE_WRITE).
+		 */
 		new_pkru_bits |= PKRU_AD_BIT;
 	if (init_val & PKEY_DISABLE_WRITE)
 		new_pkru_bits |= PKRU_WD_BIT;
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba976048..2c330fabbe55 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -48,6 +48,11 @@ static inline void copy_init_pkru_to_fpregs(void)
 {
 }
 
+static inline bool arch_pkey_access_rights_valid(unsigned long rights)
+{
+	return false;
+}
+
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6d331620b9e5..f4cefc3540df 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -597,7 +597,7 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
 	if (flags)
 		return -EINVAL;
 	/* check for unsupported init values */
-	if (init_val & ~PKEY_ACCESS_MASK)
+	if (!arch_pkey_access_rights_valid(init_val))
 		return -EINVAL;
 
 	down_write(&current->mm->mmap_sem);

Thanks,
Florian
