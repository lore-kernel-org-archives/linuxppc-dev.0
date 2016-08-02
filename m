Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Q9q0z1FzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 15:43:59 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y134so11722444pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 22:43:59 -0700 (PDT)
Date: Tue, 2 Aug 2016 13:43:53 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc64: allow ptrace to set TM bits
Message-ID: <20160802054351.GA16975@simonLocalRHEL7.x64>
References: <1469785882-9892-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469785882-9892-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Laurent,
On Fri, Jul 29, 2016 at 11:51:22AM +0200, Laurent Dufour wrote:
>  static int set_user_msr(struct task_struct *task, unsigned long msr)
>  {
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	if (!(task->thread.regs->msr & MSR_TM)) {
> +		/* If TM is not available, discard TM bits changes */
> +		msr &= ~(MSR_TM | MSR_TS_MASK);
> +	}
> +#endif

I am not sure whether following is an issue:
Per PowerISA, any exception/interrupt will disable MSR[TM] bit 
automatically and mark MSR_TS to be suspended when it is 
transactional. It is possible that MSR[TM] = 0 and MSR[MSR_TS] != 0
(suspended). 

Will set_user_msr() be able to escape from the above?
 For example, one user space application encountered 
page fault during transaction, its task->thread.regs->msr & MSR_TM == 0
and MSR[MSR_TS] == suspended.  Then it is being traced and 
set_user_msr() is invoked on it. I think it will be incorrect to 
clear its  MSR_TS_MASK bits.....

Please correct me if I am wrong.

Thanks,
- Simon
