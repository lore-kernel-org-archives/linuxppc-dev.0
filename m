Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 63D54100812
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 04:03:46 +1100 (EST)
Date: Thu, 10 Nov 2011 11:03:35 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC PATCH 08/17] powerpc/e500: Remove conditional "lwsync"
 substitution
Message-ID: <20111110170334.GF11983@schlenkerla.am.freescale.net>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-9-git-send-email-Kyle.D.Moffett@boeing.com>
 <3937191C-A735-4668-8E80-9FB4B35E2F63@kernel.crashing.org>
 <20111110163100.GA11983@schlenkerla.am.freescale.net>
 <AC287A9B-0C8B-494E-95CD-A33014AECE22@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <AC287A9B-0C8B-494E-95CD-A33014AECE22@kernel.crashing.org>
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

On Thu, Nov 10, 2011 at 10:42:25AM -0600, Kumar Gala wrote:
> 
> On Nov 10, 2011, at 10:31 AM, Scott Wood wrote:
> 
> > On Thu, Nov 10, 2011 at 07:40:04AM -0600, Kumar Gala wrote:
> >> Nak, we can run an e500mc in a mode that is compatible with e500v1/v2.  I see no reason to change the support we have there.
> > 
> > What "mode" do you mean?  DCBZ32?  We don't support using that currently,
> > and I'd imagine the performance implication would be such that you'd
> > never want to do it unless it's the only way to make some piece of legacy
> > software work.
> 
> Correct, DCBZ32, we've had customers that go down this path.

For running legacy software, or for multiplatform Linux kernels?

And if you're willing to toss performance away for this goal, why do you
need lwsync? :-)

DCBZ32 is not a "mode that is compatible with v1/v2", BTW.  It only
affects cache block size (for dcbz/dcba only), not SPE versus FP, not
changes in power management, not changes in machine check handling, etc.

Using DCBZ32 for the kernel would also complicate switching the kernel to
dcbzl, to support enabling DCBZ32 for certain userspace apps (a more
likely use case) without making it systemwide.

-Scott
