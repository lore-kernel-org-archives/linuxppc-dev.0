Return-Path: <anton@ozlabs.org>
Date: Fri, 23 Mar 2007 09:09:29 -0500
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 06/10] Add notify die hooks and remove some redundant
	debugger hooks
Message-ID: <20070323140929.GA17198@kryten>
References: <20070321013810.404636000@samba.org>
	<20070321013825.283024000@samba.org>
	<17923.46762.363994.307295@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17923.46762.363994.307295@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> As far as I can see, at the moment there is just one thing that gets
> registered to be called by die_notify, and that is
> kprobe_exceptions_notify.  It doesn't do anything with DIE_OOPS or
> DIE_MACHINE_CHECK.

Keep reading :) Later on I remove all the debugger() indirect branches.

> I would rather get rid of die_notify and have a kprobe_notify instead
> that just directly calls kprobe_exceptions_notify.  In fact having
> separate kprobe routines for the different events would be even
> better.
> 
> It's not like our cpus are particularly good at indirect functions
> calls... ;(

True and we are removing a set of indirect branches that exist already
(debugger). Id prefer not to have 2 sets of duplicate hooks for all this
stuff.

Keep in mind with xmon and kprobes disabled these calls are fast. I
verified it in sim after Christophs 300 cycle rant, a pessimistic
estimate is 20 cycles on power5, including function call overhead.

Anton
