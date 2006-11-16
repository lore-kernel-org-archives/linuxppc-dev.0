Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B09EC67BD3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 08:02:09 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGL24X3001740
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:02:04 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGL24GE224440
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:02:04 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGL23XI020623
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:02:04 -0500
Date: Thu, 16 Nov 2006 15:02:03 -0600
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC] [PATCH]  cpu hotplug on power based systems.
Message-ID: <20061116210203.GC23600@austin.ibm.com>
References: <455C783E.2040701@in.ibm.com> <20061116154051.GB2008@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061116154051.GB2008@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	Srinivasa Ds <srinivasa@in.ibm.com>, paulus@samba.org, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2006 at 09:40:51AM -0600, Nathan Lynch wrote:
> Srinivasa Ds wrote:
> > 
> > Linux kernel uses some of the rtas token to perform cpu hotplug on power 
> > systems. Some of the systems may not provide all the rtas services,which 
> > are required to perform cpu hotplug. Like for example
> >   1) JS20 doesn't provide "stop-self" token and cpu hotplug operations 
> > on these systems causes system to crash.
> >   2) some of the p630 systems doesn't provide "query-cpu-stopped-state" 
> > token and we are not sure of whether cpu is under stopped state or not  
> > or stop-self is still in progress .
> 
> Neither of these systems (well, the p630 in "SMP" mode) have
> hypervisors so their firmwares don't provide the rtas primitives for
> CPU offline.
> 
> > So we can't take decision on whether cpu really has gone offline or not.
> > 
> > So we need to make sure that all required rtas tokens for cpu hotplug  
> > are available during rtas initialization phase and to disable cpu 
> > hotplug if they are not available.
> > I have developed the patch which does the above thing. Please let me 
> > know your comments on this.
> 
> Would be better to either a) inhibit creation of the sysfs 'online'
> cpu attributes (I thought we used to handle this correctly on these
> systems) or b) use the generic cpu hotplug operations which have no
> dependency on RTAS.

Yeah, good point. It seemes cleaner to do this, than to add a new
state ("per disabled") that adds complexity to the generic kernel code. 

Perhaps we could set this up so that, if rtas "stop-self" is not
defined, then generic_cpu_die() is installed instead of pseries_cpu_die()?

--linas
