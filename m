Return-Path: <andreas.ziegler@fau.de>
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de
 [IPv6:2001:638:a000:1025::14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgDPB63dHzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 19:13:50 +1000 (AEST)
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
From: Andreas Ziegler <andreas.ziegler@fau.de>
Subject: Re: [PATCHv2 0/7] eBPF JIT for PPC64
In-Reply-To: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <5774E0FC.7010407@fau.de>
Date: Thu, 30 Jun 2016 11:06:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Naveen,

this patchset makes a change to arch/powerpc/net/Makefile in order to only
compile the previously existing bpf_jit_comp.c if !CONFIG_PPC64, and use
bpf_jit_comp64.c if CONFIG_PPC64 is enabled.

Inside arch/powerpc/net/bpf_jit_comp.c, however, there is still an #ifdef
CONFIG_PPC64 block at line 667 (linux-next of today, i.e., next-20160630):

  #ifdef CONFIG_PPC64
                  /* Function descriptor nastiness: Address + TOC */
                  ((u64 *)image)[0] = (u64)code_base;
                  ((u64 *)image)[1] = local_paca->kernel_toc;
  #endif

>From my understanding of the code, this #ifdef can now be removed, as there is
no way the file could be compiled with CONFIG_PPC64 enabled. Is this correct?

Best regards,

Andreas
