Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17923.46762.363994.307295@cargo.ozlabs.ibm.com>
Date: Fri, 23 Mar 2007 22:14:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: anton@samba.org
Subject: Re: [patch 06/10] Add notify die hooks and remove some redundant
	debugger hooks
In-Reply-To: <20070321013825.283024000@samba.org>
References: <20070321013810.404636000@samba.org>
	<20070321013825.283024000@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

anton@samba.org writes:

> Add a DIE_OOPS and DIE_MACHINE_CHECK notify_die hook and remove some
> redundant debugger* hooks.

As far as I can see, at the moment there is just one thing that gets
registered to be called by die_notify, and that is
kprobe_exceptions_notify.  It doesn't do anything with DIE_OOPS or
DIE_MACHINE_CHECK.

I would rather get rid of die_notify and have a kprobe_notify instead
that just directly calls kprobe_exceptions_notify.  In fact having
separate kprobe routines for the different events would be even
better.

It's not like our cpus are particularly good at indirect functions
calls... ;(

Paul.
