Return-Path: <ananth@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9106DDE3F
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 14:45:50 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3A4jjlT024549
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 00:45:45 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3A4ji1i204386
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 22:45:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3A4jime000383
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Apr 2007 22:45:44 -0600
Date: Tue, 10 Apr 2007 10:19:22 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 06/10] Add notify die hooks and remove some redundant
	debugger hooks
Message-ID: <20070410044922.GB15332@in.ibm.com>
References: <20070321013810.404636000@samba.org>
	<20070321013825.283024000@samba.org>
	<17923.46762.363994.307295@cargo.ozlabs.ibm.com>
	<20070323140929.GA17198@kryten>
	<17946.5029.162940.708672@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17946.5029.162940.708672@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 09, 2007 at 08:21:25PM +1000, Paul Mackerras wrote:
> 
> The other thing is that we seem to be throwing all sorts of unrelated
> events into the die_notifier.  The symptom of that is that you have
> one set of handlers that are only interested in the debug events, and
> another set that are only interested in the events where the machine
> really is dying (oops, etc.).  That is, you have two sets of handlers
> that are interested in disjoint sets of events.  That says to me that
> we shouldn't be using a single notifier for all the events.
> Particularly for page faults I really don't see the point of calling
> handlers that are only interested in oopses.

The page fault no longer uses the die_notifier. In recent kernels, we
have done away with registering the page fault notifier unconditionally.
In the kprobe case, its active only if there are any active probes.

As to the debug events vs. dying events both using the die_notifier, we
did it that way just to maintain consistency across platforms. i386,
x86_64 and sparc64 were using similar stuff before we put in the powerpc
portions.

Aside, I was told that some folks use the page fault notifiers to
determine application behaviour or somesuch and have used it effectively
to solve some of their performance issues. I don't have the details
though.

Ananth
