Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMzW74zYbzDqL1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 21:41:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, lsorense@csclub.uwaterloo.ca,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 anton@samba.org, paul.gortmaker@windriver.com, bauerman@linux.vnet.ibm.com,
 viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, duwe@lst.de,
 oss@buserror.net, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: emulate_step tests for load/store
 instructions
In-Reply-To: <1487063803-10848-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1487063803-10848-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 21:41:53 +1100
Message-ID: <87a89pm4um.fsf@concordia.ellerman.id.au>
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

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index fce05a3..5c5ae66 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -528,6 +528,8 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>  
>  int __init arch_init_kprobes(void)
>  {
> +	test_emulate_step();
> +

I don't see any good reason why this is called from here.

So I'm inclined to just make test_emulate_step() a regular init call.

cheers
