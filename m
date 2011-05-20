Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0108B71A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 05:39:55 +1000 (EST)
Date: Fri, 20 May 2011 14:39:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/book3e-64: hv exceptions aren't MASKABLE
Message-ID: <20110520143947.763ff4ad@schlenkerla.am.freescale.net>
In-Reply-To: <029E9D3E-D310-4DB6-9D0C-5E59705B2676@kernel.crashing.org>
References: <20110520190030.GA7058@schlenkerla.am.freescale.net>
	<029E9D3E-D310-4DB6-9D0C-5E59705B2676@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 May 2011 14:36:09 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On May 20, 2011, at 2:00 PM, Scott Wood wrote:
> 
> > In general we will not have EE soft-disabled or be napping when
> > these exceptions happen, but still it is not correct.
> > 
> > The guest doorbell exceptions can only be triggered with MSR[GS]=1,
> > and thus for host kernel nesting purposes are base-level exceptions.
> > 
> > Note that ehpriv and hypercall are triggerable from normal userspace.
> > I tested that the process gets properly signalled in this case.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > arch/powerpc/include/asm/reg_booke.h |    2 +
> > arch/powerpc/kernel/exceptions-64e.S |   67 ++++++++++++++++++++++++++--------
> > 2 files changed, 53 insertions(+), 16 deletions(-)
> 
> Can you look at a similar patch for 32-bit fsl-booke so we handle HV exceptions if they happen to get generated, maybe something already exists for KVM.

Yes.

-Scott
