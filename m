Return-Path: <ananth@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4B539DE029
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 23:00:53 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l2NBx2qo025734
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 07:59:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2NC0och058772
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:00:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2NC0n0P020874
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:00:49 -0600
Date: Fri, 23 Mar 2007 17:34:17 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 06/10] Add notify die hooks and remove some redundant
	debugger hooks
Message-ID: <20070323120417.GA13718@in.ibm.com>
References: <20070321013810.404636000@samba.org>
	<20070321013825.283024000@samba.org>
	<17923.46762.363994.307295@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17923.46762.363994.307295@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 10:14:50PM +1100, Paul Mackerras wrote:
> anton@samba.org writes:
> 
> > Add a DIE_OOPS and DIE_MACHINE_CHECK notify_die hook and remove some
> > redundant debugger* hooks.
> 
> As far as I can see, at the moment there is just one thing that gets
> registered to be called by die_notify, and that is
> kprobe_exceptions_notify.  It doesn't do anything with DIE_OOPS or
> DIE_MACHINE_CHECK.

Make that two: patch [8/10] of this series converts xmon to use
die_notify and these two were added to facilitate that. In any case,
kprobes just returns NOTIFY_DONE for these callbacks.

> I would rather get rid of die_notify and have a kprobe_notify instead
> that just directly calls kprobe_exceptions_notify.  In fact having
> separate kprobe routines for the different events would be even
> better.

Well, the die_notify hooks for DIE_SSTEP, DIE_BPT (and when kwatch is
implemented for powerpc, even DIE_DABR_MATCH), are shared between
kprobes and xmon, after the xmon conversion to use notifiers.

Ananth
