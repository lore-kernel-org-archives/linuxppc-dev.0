Return-Path: <breno.debian@gmail.com>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jmrn0t6fzF3Hw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 00:32:56 +1000 (AEST)
Received: by mail-qk1-f194.google.com with SMTP id v18-v6so1917420qka.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 07:32:56 -0700 (PDT)
Subject: Re: [PATCH] powerpc/tm: Fix userspace r13 corruption
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, benh@kernel.crashing.org, aneesh.kumar@linux.vnet.ibm.com
References: <20180924072704.6200-1-mikey@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <2675a034-288e-a3c2-a5df-7a223d79dc88@debian.org>
Date: Mon, 24 Sep 2018 11:32:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180924072704.6200-1-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,

On 09/24/2018 04:27 AM, Michael Neuling wrote:
> When we treclaim we store the userspace checkpointed r13 to a scratch
> SPR and then later save the scratch SPR to the user thread struct.
> 
> Unfortunately, this doesn't work as accessing the user thread struct
> can take an SLB fault and the SLB fault handler will write the same
> scratch SPRG that now contains the userspace r13.
> 
> To fix this, we store r13 to the kernel stack (which can't fault)
> before we access the user thread struct.
> 
> Found by running P8 guest + powervm + disable_1tb_segments + TM. Seen
> as a random userspace segfault with r13 looking like a kernel address.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

I am wondering if the same problem could not happen with r1 as well, since r1
is kept in the paca->tm_scratch after MSR[RI] is enabled, in a code similar
to this:

        std     r1, PACATMSCRATCH(r13)
	..
        li      r11, MSR_RI
	mtmsrd  r11, 1
	....
        ld      r3, PACATMSCRATCH(r13)          /* user r1 */
        std     r3, GPR1(r7)

There might be a corruption if the exception that is raised just after
MSR[RI] is enabled somehow exits through 'fast_exception_return' (being
called by most of the exception handlers as I understand) which will
overwrite paca->tm_scratch with the upcoming MSR (aka SRR1) just before the
SRR1, as:

	ld      r3,_MSR(r1)

	...
	std     r3, PACATMSCRATCH(r13) /* Stash returned-to MSR */


It seems that slb_miss_common and instruction_access_slb does not go through
this path, but handle_page_fault calls
ret_from_except_lite->fast_exception_return, which might cause this
'possible' issue.

Anyway, I would like to investigate if this problem might happen or not for
real, but I do not fully understand what are the exceptions that might be
raised when just MSR[RI] is enabled.
