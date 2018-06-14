Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4160Bq3CnszDrph
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 20:25:55 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a12-v6so3024610pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 03:25:55 -0700 (PDT)
Date: Thu, 14 Jun 2018 20:25:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: stacktrace.c:(.text+0x1b0): undefined reference to
 `.smp_send_safe_nmi_ipi'
Message-ID: <20180614202546.24d40e51@roar.ozlabs.ibm.com>
In-Reply-To: <0ae99ba5-e721-dada-8d94-b223e41977e9@c-s.fr>
References: <0ae99ba5-e721-dada-8d94-b223e41977e9@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Jun 2018 12:06:51 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> See http://kisskb.ellerman.id.au/kisskb/buildresult/13395345/ for details
> 
> Seems like that function only exists when CONFIG_NMI_IPI is defined.
> 
> Problem introduced by commit 5cc05910f26e6fd6da15f052f86f6150e4b91664 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/kernel/stacktrace.c?h=next-20180614&id=5cc05910f26e6fd6da15f052f86f6150e4b91664
> 
> 
> What do you recommend to fix that ?

We could just do smp_call_function in the case we have no NMI_IPI?

Thanks,
Nick
