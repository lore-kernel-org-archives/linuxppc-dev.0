Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 98761101448
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 03:31:08 +1100 (EST)
Date: Thu, 10 Nov 2011 10:31:00 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC PATCH 08/17] powerpc/e500: Remove conditional "lwsync"
 substitution
Message-ID: <20111110163100.GA11983@schlenkerla.am.freescale.net>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-9-git-send-email-Kyle.D.Moffett@boeing.com>
 <3937191C-A735-4668-8E80-9FB4B35E2F63@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <3937191C-A735-4668-8E80-9FB4B35E2F63@kernel.crashing.org>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 07:40:04AM -0600, Kumar Gala wrote:
> 
> On Nov 9, 2011, at 6:07 PM, Kyle Moffett wrote:
> 
> > As FreeScale e500 systems have different cacheline sizes from e500mc, it
> > is basically impossible for the kernel to support both in a single
> > system image at present.
> > 
> > Given that one is SPE-float and the other is classic-float, they are not
> > generally userspace-compatible either.
> > 
> > This patch updates the conditional to depend on whether the system is
> > actually targetting an "e500" or "e500mc" core and entirely removes the
> > unused sync-to-lwsync-replacement on e500v1/e500v2 systems.
> > 
> > Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> > ---
> > arch/powerpc/include/asm/synch.h |   16 ++++------------
> > 1 files changed, 4 insertions(+), 12 deletions(-)
> 
> Nak, we can run an e500mc in a mode that is compatible with e500v1/v2.  I see no reason to change the support we have there.

What "mode" do you mean?  DCBZ32?  We don't support using that currently,
and I'd imagine the performance implication would be such that you'd
never want to do it unless it's the only way to make some piece of legacy
software work.

>  I see no reason to change the support we have there.

No reason to remove complexity that is not needed, and is not planned to
be needed?

-Scott
