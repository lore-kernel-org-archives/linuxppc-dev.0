Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FF92DE012
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 22:29:19 +1100 (EST)
Date: Fri, 23 Mar 2007 12:29:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 06/10] Add notify die hooks and remove some redundant
	debugger hooks
Message-ID: <20070323112909.GA21787@lst.de>
References: <20070321013810.404636000@samba.org>
	<20070321013825.283024000@samba.org>
	<17923.46762.363994.307295@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17923.46762.363994.307295@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
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
> 
> I would rather get rid of die_notify and have a kprobe_notify instead
> that just directly calls kprobe_exceptions_notify.  In fact having
> separate kprobe routines for the different events would be even
> better.
> 
> It's not like our cpus are particularly good at indirect functions
> calls... ;(

See the patch I posted a few days ago for the pagefault path..
