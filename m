Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r512c0BGtzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 14:58:00 +1000 (AEST)
Date: Thu, 12 May 2016 14:51:23 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix definition of SIAR register
Message-ID: <20160512045123.GA1421@oak.ozlabs.ibm.com>
References: <1460130851-29021-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460130851-29021-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2016 at 05:54:11PM +0200, Thomas Huth wrote:
> The SIAR register is available twice, one time as SPR 780 (unprivileged,
> but read-only), and one time as SPR 796 (privileged, but read and write).
> The Linux kernel code currently uses SPR 780 - and while this is OK for
> reading, writing to that register of course does not work.
> Since the KVM code tries to write to this register, too (see the mtspr
> in book3s_hv_rmhandlers.S), the contents of this register sometimes get
> lost for the guests, e.g. during migration of a VM.
> To fix this issue, simply switch to the other SPR numer 796 instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: The perf code in core-book3s.c also seems to write to the SIAR
>        SPR, so that might be affected by this issue, too - but I did
>        not test the perf code, so I'm not sure about that part.

EBBs mean we need to context-switch the SIAR between user tasks (among
other registers).

I notice that SDAR is also wrong, and the MMCR2 definition is also
using the user-accessible number (though it at least is writable as
well as readable).

Paul.
