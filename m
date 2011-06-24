Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1090B6F88
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Jun 2011 01:16:42 +1000 (EST)
Date: Fri, 24 Jun 2011 10:16:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
Message-ID: <20110624101628.49349c2d@schlenkerla.am.freescale.net>
In-Reply-To: <4E03F8C1.60706@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
	<20110614181406.294cdf5f@schlenkerla.am.freescale.net>
	<4DF7EB8E.8020308@freescale.com>
	<20110614182517.776d7e77@schlenkerla.am.freescale.net>
	<1308103091.2635.13.camel@pasglop>
	<4DF814A37aeb6b66@schlenkerla.am.freescale.net>
	<59f786bfaced051a14e2bb75d3d1ce77@kernel.crashing.org>
	<4E03F8C1.60706@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	McClintock Matthew-B29882 <B29882@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Jun 2011 21:38:58 -0500
Tabi Timur-B04825 <B04825@freescale.com> wrote:

> Segher Boessenkool wrote:
> >
> > v2.06 III-E 9.2.1:
> > "Writing the Time Base is hypervisor privileged."
> >
> > v2.06 III-E 2.1:
> > "If a hypervisor-privileged register is accessed in the guest supervisor
> > state (MSR[GS PR] = 0b10), an Embedded Hypervisor Privilege exception
> > occurs."
> >
> > (v2.06 III-E 5.4.1, the big SPR table, also shows the TB regs (for writing,
> > i.e. 284 and 285) to be hypervisor privileged.  Consistency, hurray :-) )
> 
> To me, all this means that a guest cannot write to the actual timebase 
> register.  I'm not interpreting this to mean that a hypervisor can't 
> virtualize the timebase and allow a guest to read/write a virtual timebase 
> register, so that it thinks it's writing to the real hardware timebase register.
> 

Right, I was referring to the virtualized implementation note added in
2.06B.  The virtualized implementation notes apply to what happens in the
guest as seen by the guest (considered as a separate implementation of the
Power ISA), not to what happens at a hardware level in guest mode.

-Scott
