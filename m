Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4871DE158
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:40:27 +1100 (EST)
Subject: Re: [PATCH 4/25] powerpc: Reworking machine check handling and Fix
	440/440A
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071210115926.20278214@weaponx>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080114.CDB13DDE33@ozlabs.org>
	<20071210115926.20278214@weaponx>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 07:33:35 +1100
Message-Id: <1197318815.8692.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-10 at 11:59 -0600, Josh Boyer wrote:
> 
> This breaks ARCH=ppc builds.  Unfortunately, that tree shares the
> cputable.[ch] files, but has it's own traps.c.  Which means you get
> lots of nice undefined references like below for example:
> 
> arch/powerpc/kernel/built-in.o:(.init.data+0x44): undefined reference
> to `machine_check_4xx'
> arch/powerpc/kernel/built-in.o:(.init.data+0x8c): undefined reference
> to `machine_check_4xx'
> arch/powerpc/kernel/built-in.o:(.init.data+0xd4): undefined reference
> to `machine_check_4xx'
> 
> Because the cputable entries for the processors are setting
> the .machine_check function and it's never built.
> 
> I'm not sure which would be easier, making arch/ppc use traps.c from
> arch/powerpc, or adding similar functionality there.

Split cputable.c ? I hate arch/ppc sharing files ... Or I could port the
changes to arch/ppc. I don't want to use the same traps.c file. Sharing
file is just a pain every time we do major changes.

Ben.
