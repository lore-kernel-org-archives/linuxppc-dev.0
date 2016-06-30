Return-Path: <kda@linux-powerpc.org>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgDs95mfBzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 19:34:37 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id n132so15320238qka.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 02:34:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5774E0FC.7010407@fau.de>
References: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
 <5774E0FC.7010407@fau.de>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Thu, 30 Jun 2016 12:34:33 +0300
Message-ID: <CAOJe8K0UcDMnj964EKW8M+f=7K3ArgM5xdF9EcyRCFwd4dWY4g@mail.gmail.com>
Subject: Re: [PATCHv2 0/7] eBPF JIT for PPC64
To: Andreas Ziegler <andreas.ziegler@fau.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/30/16, Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> Hi Naveen,
>
> this patchset makes a change to arch/powerpc/net/Makefile in order to only
> compile the previously existing bpf_jit_comp.c if !CONFIG_PPC64, and use
> bpf_jit_comp64.c if CONFIG_PPC64 is enabled.
>
> Inside arch/powerpc/net/bpf_jit_comp.c, however, there is still an #ifdef
> CONFIG_PPC64 block at line 667 (linux-next of today, i.e., next-20160630):
>
>   #ifdef CONFIG_PPC64
>                   /* Function descriptor nastiness: Address + TOC */
>                   ((u64 *)image)[0] = (u64)code_base;
>                   ((u64 *)image)[1] = local_paca->kernel_toc;
>   #endif
>
> From my understanding of the code, this #ifdef can now be removed, as there
> is
> no way the file could be compiled with CONFIG_PPC64 enabled. Is this
> correct?

That was used for running classic BPF on ppc64. With eBPF on ppc64 the
whole block can be removed.

>
> Best regards,
>
> Andreas
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
