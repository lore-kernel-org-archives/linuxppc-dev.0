Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD2661A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 13:04:05 +1100 (AEDT)
Message-ID: <1445047433.24309.40.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <dgibson@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 thuth@redhat.com
Date: Sat, 17 Oct 2015 07:33:53 +0530
In-Reply-To: <5620ADE4.9060701@redhat.com>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <20151016132943.1386fda6@voom.fritz.box> <5620ADE4.9060701@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-16 at 09:57 +0200, Laurent Vivier wrote:
> For me the problem is: as these CPUs are offline, I guess the core has
> been switched to 1 thread per core, so the CPUs (1 to 7 for core 0)
> don't exist anymore, how can we return them to OPAL ?

Another option is to make the new kernel kick_cpu fallback, if it knows
it's coming as a crashdump, to sending IPIs.

We would need some sane way to catch the guys coming it at 0x100 and
route the to secondary start.

Cheers,
Ben.
