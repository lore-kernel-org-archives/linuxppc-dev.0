Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMzcP5T1KzDqL1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 21:46:29 +1100 (AEDT)
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
Date: Tue, 14 Feb 2017 21:46:25 +1100
Message-ID: <877f4tm4n2.fsf@concordia.ellerman.id.au>
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

> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 0e649d7..ddc879d 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -33,3 +33,7 @@ obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
>  CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
>  
>  obj-$(CONFIG_PPC64) += $(obj64-y)
> +
> +ifeq ($(CONFIG_PPC64), y)
> +obj-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
> +endif

FYI, the right way to do that is:

  obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
  obj-$(CONFIG_PPC64) += $(obj64-y)

And in this Makefile you don't need to add the second line because it's
already there.

cheers
