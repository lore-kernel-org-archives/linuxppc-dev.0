Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B54B21A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 20:50:55 +1100 (AEDT)
Message-ID: <1418205050.9279.5.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 2/8] perf probe powerpc: Fix symbol fixup issues due
 to ELF type
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 10 Dec 2014 20:50:50 +1100
In-Reply-To: <0412a00009a22762f92c208964df6f842796464e.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <0412a00009a22762f92c208964df6f842796464e.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 23:04 +0530, Naveen N. Rao wrote:
> If using the symbol table, symbol addresses are not being fixed up
> properly, resulting in probes being placed at wrong addresses:
> 
>   # perf probe do_fork
>   Added new event:
>     probe:do_fork        (on do_fork)
> 
>   You can now use it in all perf tools, such as:
> 
> 	  perf record -e probe:do_fork -aR sleep 1
> 
>   # cat /sys/kernel/debug/tracing/kprobe_events
>   p:probe/do_fork _text+635952
>   # printf "%x" 635952
>   9b430
>   # grep do_fork /boot/System.map
>   c0000000000ab430 T .do_fork

OK, but why is that happening? And why does checking for ET_DYN fix it?

> Fix by checking for ELF type ET_DYN used by ppc64 kernels.

We sometimes produce ET_DYN kernels, but only if CONFIG_RELOCATABLE=y.

cheers
