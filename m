Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id C157268224
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:02:03 +1100 (EST)
Date: Fri, 10 Nov 2006 14:01:52 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
Message-ID: <20061110200152.GC23089@localdomain>
References: <20061110182253.GV30625@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061110182253.GV30625@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> 
> There are a variety of code paths that lead to rtas_stop_self()
> being called, primarily through cpu_die(). However, rtas_stop_self() 
> has a BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE); in it, and
> this rtas token is only set up if CONFIG_HOTPLUG_CPU is defined.
> 
> Rather than wrapping all of the callers of rtas_stop_self()
> with CONFIG_HOTPLUG_CPU, it seems wiser to just unwrap the token
> definition.

Is there actually a code path that calls rtas_stop_self with
CONFIG_HOTPLUG_CPU=n?  That would be a bug, I think.
