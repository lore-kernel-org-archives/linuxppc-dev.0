Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7207D67EAA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 05:05:08 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kADI51ix006318
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:05:01 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kADI51ha279834
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:05:01 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kADI51NM031776
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:05:01 -0500
Date: Mon, 13 Nov 2006 12:05:00 -0600
To: jschopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061113180500.GB4307@austin.ibm.com>
References: <20061110182253.GV30625@austin.ibm.com>
	<20061110200152.GC23089@localdomain>
	<20061111010108.GX30625@austin.ibm.com>
	<1163377944.7410.12.camel@localhost.localdomain>
	<45580ED0.7000704@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45580ED0.7000704@austin.ibm.com>
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

On Mon, Nov 13, 2006 at 12:21:04AM -0600, jschopp wrote:
> >I can only find one caller? Is it called via a #define or something?

Right. I was looking at pSeries_mach_cpu_die(), which is called
as md.cpu_die from many places.

> >Wouldn't it be preferable to just change rtas.h like so:
> >
> >#ifdef CONFIG_HOTPLUG_CPU
> >extern void rtas_stop_self(void);
> >#else
> >static inline void rtas_stop_self(void) { }
> >#endif

Well, the problem is that this would just pass the BUG() to 
the next level, in pSeries_mach_cpu_die():

static void pSeries_mach_cpu_die(void)
{
   local_irq_disable();
   idle_task_exit();
   xics_teardown_cpu(0);
   rtas_stop_self();
   /* Should never get here... */
   BUG();
   for(;;);
}

so does that mean that CONFIG_HOTPLUG_CPU should also be used to 
stop the complation of pSeries_mach_cpu_die() ? 

--linas
