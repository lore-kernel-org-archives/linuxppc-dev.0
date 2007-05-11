Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A141DDEDF
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:23:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4BHN6Xr023359
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 13:23:06 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4BHN5Lh149402
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 11:23:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4BHN52g030578
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 11:23:05 -0600
Date: Fri, 11 May 2007 12:23:04 -0500
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Using kprobes [was Re: [PATCH] Performance Stats: Kernel patch
Message-ID: <20070511172304.GI4452@austin.ibm.com>
References: <20070508162650.704.83752.stgit@localhost.localdomain>
	<20070508123214.11b4f25c.akpm@linux-foundation.org>
	<4642FDD6.5090609@ru.mvista.com>
	<20070510111242.dd42adae.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510111242.dd42adae.akpm@linux-foundation.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Maxim Uvarov <muvarov@ru.mvista.com>, dada1@cosmosbay.com, pavel@ucw.cz,
	wli@holomorphy.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 11:12:42AM -0700, Andrew Morton wrote:
> 
> I don't think the syscall-counting feature has a future, sorry.  Perhaps
> you could do something like hooking it up on-demand by insertion of a kprobe,
> dunno.

This is an interesting point. I've started fiddling with (a wrapper
around) kprobes that allows me to pick any subroutine symbol in System.map,
and then get an event whenever that subroutine gets called. Its pretty
slick, and allows me to gather data on certain unusual events in the
kernel.  (I'm not using this for performance monitoring, I'm trying to 
do RAS).

It makes a lot of sense to me to have a generic kprobe extension, where 
you could give it a list of subroutine names, and it'll collect stats
on the number of times that the routine was called. Some user-space thingy
could poll for those stats, or you could put them in /sys or wherever.

Its more complicted than just instriumenting syscalls, but a lot more
useful, I would think ... 

--linas
