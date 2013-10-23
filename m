Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 282312C009E
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Oct 2013 21:20:59 +1100 (EST)
Date: Wed, 23 Oct 2013 11:20:45 +0100
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: Don't corrupt user registers on 32-bit
Message-ID: <20131023102045.GA23685@SnaresPenguin>
References: <20131023084002.GA8325@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131023084002.GA8325@iris.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 23, 2013 at 09:40:02AM +0100, Paul Mackerras wrote:
> Commit de79f7b9f6 ("powerpc: Put FP/VSX and VR state into structures")
> modified load_up_fpu() and load_up_altivec() in such a way that they
> now use r7 and r8.  Unfortunately, the callers of these functions on
> 32-bit machines then return to userspace via fast_exception_return,
> which doesn't restore all of the volatile GPRs, but only r1, r3 -- r6
> and r9 -- r12.  This was causing userspace segfaults and other
> userspace misbehaviour on 32-bit machines.
> 
> This fixes the problem by changing the register usage of load_up_fpu()
> and load_up_altivec() to avoid using r7 and r8 and instead use r6 and
> r10.  This also adds comments to those functions saying which registers
> may be used.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
> ---
> arch/powerpc/kernel/fpu.S    | 14 ++++++++------
>  arch/powerpc/kernel/vector.S | 15 +++++++++------
>  2 files changed, 17 insertions(+), 12 deletions(-)

Tested-by: Scott Wood <scottwood@freescale.com> (on e500mc, so no altivec)

-Scott
