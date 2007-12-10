Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3EB0DDDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:44:40 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBAKiaX0028916
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 15:44:36 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBAKiaZn128490
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 13:44:36 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBAKiZZA010628
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 13:44:35 -0700
Date: Mon, 10 Dec 2007 14:44:34 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 4/25] powerpc: Reworking machine check handling and Fix
	440/440A
Message-ID: <20071210144434.3bb1dc4e@weaponx>
In-Reply-To: <1197318815.8692.7.camel@pasglop>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080114.CDB13DDE33@ozlabs.org>
	<20071210115926.20278214@weaponx> <1197318815.8692.7.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 11 Dec 2007 07:33:35 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Mon, 2007-12-10 at 11:59 -0600, Josh Boyer wrote:
> > 
> > This breaks ARCH=ppc builds.  Unfortunately, that tree shares the
> > cputable.[ch] files, but has it's own traps.c.  Which means you get
> > lots of nice undefined references like below for example:
> > 
> > arch/powerpc/kernel/built-in.o:(.init.data+0x44): undefined reference
> > to `machine_check_4xx'
> > arch/powerpc/kernel/built-in.o:(.init.data+0x8c): undefined reference
> > to `machine_check_4xx'
> > arch/powerpc/kernel/built-in.o:(.init.data+0xd4): undefined reference
> > to `machine_check_4xx'
> > 
> > Because the cputable entries for the processors are setting
> > the .machine_check function and it's never built.
> > 
> > I'm not sure which would be easier, making arch/ppc use traps.c from
> > arch/powerpc, or adding similar functionality there.
> 
> Split cputable.c ? I hate arch/ppc sharing files ... Or I could port the
> changes to arch/ppc. I don't want to use the same traps.c file. Sharing
> file is just a pain every time we do major changes.

Splitting cputable.c at this point would be rather annoying, given the
number of changes we've made to arch/ppc recently to accommodate for it
being shared.  Porting the changes to arch/ppc sounds like the most
reasonable path.

I can't wait for arch/ppc to die.

josh
