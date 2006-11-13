Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6929667EA5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 06:39:53 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kADJdfmg027671
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:39:41 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kADJdfWE135168
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:39:41 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kADJdfwb010646
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:39:41 -0500
Date: Mon, 13 Nov 2006 13:39:40 -0600
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061113193940.GA8395@austin.ibm.com>
References: <20061110182253.GV30625@austin.ibm.com>
	<17749.4445.46239.450000@cargo.ozlabs.ibm.com>
	<20061111005248.GW30625@austin.ibm.com>
	<20061113185704.GA8253@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061113185704.GA8253@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 13, 2006 at 12:57:04PM -0600, Nathan Lynch wrote:
> 
> I'm still not clear on what problem this patch is intended to address.

There's a code path that is compiled unconditonally, that expects 
this token to be defined. 

> If the 'online' cpu attribute in sysfs can be used to attempt an
> offline operation on a kernel with CONFIG_HOTPLUG_CPU=n, that's what
> needs to be fixed.

There are many places where cpu_die() might be called, and
I am sufficiently lazy to not want to audit them to make sure
that none of these code paths are taken if CONFIG_HOTPLUG_CPU=n.

Besides, if I audit all of these code paths today, and find
that none of them are ever called when  CONFIG_HOTPLUG_CPU=n,
I still have no assurance that someone might not unwittingly
change one of the code paths in the future. 

Code that might fail because someone makes an unwitting change
in the future is "brittle". The goal of my patch was to remove
the brittleness.

Besides, I notice that platforms/powermac/smp.c defines
cpu_die() as well, which tells me that there are code paths
that lead to its being called, even if CONFIG_HOTPLUG_CPU=n.
That would seem to conclude the audit, right?

--linas
