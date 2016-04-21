Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrNxn55mzzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 02:10:05 +1000 (AEST)
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qrNxm2q7Cz9sDk
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Apr 2016 02:10:04 +1000 (AEST)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 17:10:00 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5D4AA219007A
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Apr 2016 16:59:46 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LG08hj5046550
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Apr 2016 16:00:08 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LG04QF011779
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Apr 2016 10:00:08 -0600
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
To: Michael Ellerman <michael@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B54EB.90507@linux.vnet.ibm.com> <1460524468.30704.5.camel@ellerman.id.au>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, shuahkh@osg.samsung.com, oleg@redhat.com,
 dhowells@redhat.com, Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 tglx@linutronix.de, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 sam.bobroff@au1.ibm.com
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <5718F901.6010104@linux.vnet.ibm.com>
Date: Thu, 21 Apr 2016 18:00:01 +0200
MIME-Version: 1.0
In-Reply-To: <1460524468.30704.5.camel@ellerman.id.au>
Content-Type: multipart/mixed; boundary="------------010609080808060004030507"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010609080808060004030507
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 13/04/2016 07:14, Michael Ellerman wrote:
> On Mon, 2016-04-11 at 09:40 +0200, Laurent Dufour wrote:
>> On 07/04/2016 23:49, Michael Ellerman wrote:
>>> On 7 April 2016 7:23:46 pm AEST, Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>>>> This series is required to handle TM state in CRIU.
>>>> Is there a chance to get it upstream soon ?
>>>
>>> We were waiting on the gdb support to make sure it had some testing. If it's working for CRIU that would be a good data point, have you actually tested it with CRIU?
>>
>> I just started integrating it in CRIU, my basic tests didn't report any
>> issue with the new ptrace API, but I can't state that it is bug free ;)
> 
> Sure. But if it's working for CRIU that's at least postive :)

I did additional tests and the Anshuman's series is working fine for
CRIU's support with the attached patch applied.

Michael, could you please applied the attached patch among the
Anshuman's series ?

Thanks,
Laurent.


--------------010609080808060004030507
Content-Type: text/x-patch;
 name="ppc64-allow-ptrace-to-set-TM-bits.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ppc64-allow-ptrace-to-set-TM-bits.patch"

>From 7a4f07c54afdbe7bef84d1f700ab9262f449513a Mon Sep 17 00:00:00 2001
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2016 18:59:16 +0200
Subject: [PATCH] ppc64: allow ptrace to set TM bits

This patch allows the MSR bits relative to the Transactional memory
state to be manipulated through the ptrace API.

However, in the case the TM available bit is not set in the
manipulated MSR, the changes are ignored.

When dealing with the checkpointed MSR, we must be sure that the TM
state bits will not be set since the checkpointed state can't be a
transactional one.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index b063fc499c1d..5c792f0bf1ca 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -161,8 +161,12 @@ const char *regs_query_register_name(unsigned int offset)
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 #define MSR_DEBUGCHANGE	0
 #else
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+#define MSR_DEBUGCHANGE	(MSR_TS_MASK | MSR_SE | MSR_BE)
+#else
 #define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
 #endif
+#endif
 
 /*
  * Max register writeable via put_reg
@@ -180,6 +184,12 @@ static unsigned long get_user_msr(struct task_struct *task)
 
 static int set_user_msr(struct task_struct *task, unsigned long msr)
 {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (!(task->thread.regs->msr & MSR_TM)) {
+		/* If TM is not available, discard TM bits changes */
+		msr &= ~(MSR_TM | MSR_TS_MASK);
+	}
+#endif
 	task->thread.regs->msr &= ~MSR_DEBUGCHANGE;
 	task->thread.regs->msr |= msr & MSR_DEBUGCHANGE;
 	return 0;
@@ -193,6 +203,7 @@ static unsigned long get_user_ckpt_msr(struct task_struct *task)
 
 static int set_user_ckpt_msr(struct task_struct *task, unsigned long msr)
 {
+	msr &= ~MSR_TS_MASK;	/* Checkpoint state can't be in transaction */
 	task->thread.ckpt_regs.msr &= ~MSR_DEBUGCHANGE;
 	task->thread.ckpt_regs.msr |= msr & MSR_DEBUGCHANGE;
 	return 0;
-- 
1.9.1


--------------010609080808060004030507--
