Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A39F67A45
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 10:19:17 +1100 (EST)
Subject: Re: parsing of some early cmdline options
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0602231658210.16092-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602231658210.16092-100000@gate.crashing.org>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 10:19:12 +1100
Message-Id: <1140736753.8264.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-02-23 at 17:02 -0600, Kumar Gala wrote:
> Guys,
> 
> I noticed that we have code in arch/powerpc/kernel/prom_init.c to handle 
> parsing iommu=, mem=, and crashkernel=.
> 
> The problem I have is that we only use/build prom_init.c on MULTIPLATFORM 
> (coming from true OF).

MULTIPLATFORM is here to die (or rather be always there, with
ARCH=powerpc we really want to NOT reproduce the old single platform
crap) , but yes, prom_init.c is supposed to only be run on real OFs...

I suppose we woul have to deal with those in early_init_devtree() for
machines that didn't go through prom_init()....

> Any ideas on how to handle this for the !MULTIPLATFORM cases.  I'm most 
> concerned about mem=.
