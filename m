Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BC85DDF19
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:23:38 +1000 (EST)
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <0fa2693104ff3250114d82837911b9e8@bga.com>
References: <200809231743.23828.ossthema@de.ibm.com>
	<20080915100406.342e027a@bull.net>
	<200809240958.m8O9wM7k010996@sullivan.realtime.net>
	<20080924143055.6102f317@bull.net>
	<0fa2693104ff3250114d82837911b9e8@bga.com>
Content-Type: text/plain
Date: Thu, 25 Sep 2008 07:16:45 +1000
Message-Id: <1222291005.8277.86.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Christoph Raisch <RAISCH@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-24 at 11:42 -0500, Milton Miller wrote:
> 
> I was trying to understand why the mask and early eoi, but I guess its 
> to handle other more limited interrupt controllers where the interrupts 
> stack in hardware instead of software.

No Milton, we must do it that way, because the EOI must be done on the
right CPU even on XICS, or we won't get the CPU priority back properly.

Ben.
