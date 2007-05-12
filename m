Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F2C1DDEAB
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 19:06:47 +1000 (EST)
Subject: Re: [PATCH 7/7] MPIC U3/U4 MSI backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1178958505.2647.5.camel@johannes.berg>
References: <20070508025843.0D93ADDEFD@ozlabs.org>
	<1178958505.2647.5.camel@johannes.berg>
Content-Type: text/plain; charset=utf-8
Date: Sat, 12 May 2007 19:06:35 +1000
Message-Id: <1178960796.32247.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-12 at 10:28 +0200, Johannes Berg wrote:
> > +	pr_debug("u3msi: allocated virq 0x%x (hw 0x%lx) at address 0x%lx\n",
> > +		 virq, virq_to_hw(virq), addr);
> 
> I get
> arch/powerpc/sysdev/mpic_u3msi.c: In function ‘u3msi_compose_msi_msg’:
> arch/powerpc/sysdev/mpic_u3msi.c:121: warning: format ‘%lx’ expects type
> ‘long unsigned int’, but argument 4 has type ‘u64’
> 
> when building this on ppc32 (I wonder if that even makes sense anyway
> but Kconfig allowed me to select MSI)

Hrm... we should definitely make the U3 MSI bits 64 bits only for now at
least.

Ben.
