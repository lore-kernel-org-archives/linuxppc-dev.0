Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0B2667F38
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 12:01:12 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAB119ES031253
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 20:01:09 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAB119O9507348
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 18:01:09 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAB119SI024208
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 18:01:09 -0700
Date: Fri, 10 Nov 2006 19:01:08 -0600
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061111010108.GX30625@austin.ibm.com>
References: <20061110182253.GV30625@austin.ibm.com>
	<20061110200152.GC23089@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061110200152.GC23089@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2006 at 02:01:52PM -0600, Nathan Lynch wrote:
> Linas Vepstas wrote:
> > 
> > There are a variety of code paths that lead to rtas_stop_self()
> > being called, primarily through cpu_die(). However, rtas_stop_self() 
> > has a BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE); in it, and
> > this rtas token is only set up if CONFIG_HOTPLUG_CPU is defined.
> > 
> > Rather than wrapping all of the callers of rtas_stop_self()
> > with CONFIG_HOTPLUG_CPU, it seems wiser to just unwrap the token
> > definition.
> 
> Is there actually a code path that calls rtas_stop_self with
> CONFIG_HOTPLUG_CPU=n?  That would be a bug, I think.

Yeah, that was my first reaction too, right next to "user error". 
But then I started tracing the code paths, and after they multiplied
a bit, it was clear that the answer wouldn't be clear. 

So then I philosophized a bit: if the code cannot be called
unless CONFIG_HOTPLUG_CPU=y, then I should add #ifdef CONFIG_HOTPLUG_CPU
to make sure that the code doesn't even get compiled in.

Well, there used to be such ifdefs (according to Joel) but someone 
removed the ifdefs. I'm guessing that these got removed during the
powerpc tree migration.

So... Rather than wrapping all of the callers of rtas_stop_self() ...

--linas
