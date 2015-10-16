Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF7E31A0271
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 13:14:50 +1100 (AEDT)
Message-ID: <1444961690.28419.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  dgibson@redhat.com, thuth@redhat.com
Date: Fri, 16 Oct 2015 13:14:50 +1100
In-Reply-To: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
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

On Thu, 2015-10-15 at 21:00 +0200, Laurent Vivier wrote:
> On kexec, all secondary offline CPUs are onlined before
> starting the new kernel, this is not done in the case of kdump.
> 
> If kdump is configured and a kernel crash occurs whereas
> some secondaries CPUs are offline (SMT=off),
> the new kernel is not able to start them and displays some
> "Processor X is stuck.".

Do we know why they are stuck?

I really don't like this fix. The reason we're doing a kdump is because the
first kernel has panicked, possibly with locks held or data structures
corrupted. Calling cpu_up() then goes and tries to run a bunch of code in the
crashed kernel, which increases the chance of us just wedging completely.

cheers
