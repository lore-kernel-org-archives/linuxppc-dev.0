Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE250679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 09:33:42 +1000 (EST)
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45377ED3.9030001@bplan-gmbh.de>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 09:33:28 +1000
Message-Id: <1161300808.10524.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-19 at 15:34 +0200, Nicolas DET wrote:
> Olaf Hering wrote:
>  > I get irq warnings with current Linus tree on Pegasos.
>  > The EDID handling for radeonfb appears to be broken as well,
>  > but thats a different story:
>  >
> 
> This patch enables chrp_pcibios_fixup() for bPlan's machine. however, 
> this function should NOT be called as thoses platforms.
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=26c5032eaa64090b2a01973b0c6ea9e7f6a80fa7
> 
> An upcomming patch will "ppc_md.pcibios_fixup = NULL;" for every bPlan's 
> platforms.

Ugh ?

I'm not sure what the patch you pointed to has to do with fixups :)

Anyway, the irq code should work with Pegasos. I think the problem is
that it's missing a call to irq_set_default_host() on the i8259 when no
MPIC is present. It's strange, I though I had it... BriQ needs it too.

Ben.
