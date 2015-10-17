Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8697C1A07F1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 13:01:25 +1100 (AEDT)
Message-ID: <1445047273.24309.35.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Vivier <lvivier@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dgibson@redhat.com, thuth@redhat.com
Date: Sat, 17 Oct 2015 07:31:13 +0530
In-Reply-To: <5620ABC5.6060300@redhat.com>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <1444961690.28419.1.camel@ellerman.id.au> <5620ABC5.6060300@redhat.com>
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

On Fri, 2015-10-16 at 09:48 +0200, Laurent Vivier wrote:
> 
> Yes, we know :)
> 
> On the crash, as the CPUs are offline, kernel doesn't call
> opal_return_cpu(), so for OPAL all these CPU are always in the
> kernel.

Hrm and they may even be in winkle state, so basically off... waking
them up *could* be a tricky business.

I suppose we could, near the last stage of kexec, patch the 0x100
vector to send anybody coming in to a kexec wait loop, and then machine
gun the IPIs. But that will make them come in with an unclean ICP
needing an EOI, I'm not sure we handle that very well.

Ideally we could just soft-reset them but that's broken on P8.

Cheers,
Ben.
