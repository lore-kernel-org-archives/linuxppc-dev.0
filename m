Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37BC167CDD
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:08:48 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAFI8c11023796
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 13:08:38 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAFI8cYF270928
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 13:08:38 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAFI8b8R019489
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 13:08:38 -0500
Date: Wed, 15 Nov 2006 12:08:14 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061115180814.GG8395@austin.ibm.com>
References: <20061110182253.GV30625@austin.ibm.com>
	<20061110200152.GC23089@localdomain>
	<20061111010108.GX30625@austin.ibm.com>
	<1163377944.7410.12.camel@localhost.localdomain>
	<45580ED0.7000704@austin.ibm.com>
	<20061113180500.GB4307@austin.ibm.com>
	<1163467065.8048.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163467065.8048.37.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 14, 2006 at 12:17:44PM +1100, Michael Ellerman wrote:
> On Mon, 2006-11-13 at 12:05 -0600, Linas Vepstas wrote:
> > 
> > Well, the problem is that this would just pass the BUG() to 
> > the next level, in pSeries_mach_cpu_die():
> > 
> > static void pSeries_mach_cpu_die(void)
> > {
> >    local_irq_disable();
> >    idle_task_exit();
> >    xics_teardown_cpu(0);
> >    rtas_stop_self();
> >    /* Should never get here... */
> >    BUG();
> >    for(;;);
> > }
> > 
> > so does that mean that CONFIG_HOTPLUG_CPU should also be used to 
> > stop the complation of pSeries_mach_cpu_die() ? 
> 
> Yes. And its connection to ppc_md.cpu_die.

OK, will send patch for this shortly. I reviewed the other cases,
and see now that this would e the consistent thing to do.

--linas
