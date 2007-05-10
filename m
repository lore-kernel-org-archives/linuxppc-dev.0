Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31326DDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 04:25:44 +1000 (EST)
Date: Thu, 10 May 2007 11:25:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-Id: <20070510112508.cad2fd0c.akpm@linux-foundation.org>
In-Reply-To: <20070510114221.7576.67522.stgit@localhost.localdomain>
References: <20070510114221.7576.67522.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, pavel@ucw.cz, wli@holomorphy.com,
	dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007 11:42:22 +0000 Maxim Uvarov <muvarov@ru.mvista.com> wrote:

> From: Maxim Uvarov <muvarov@ru.mvista.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: <wli@holomorphy.com>, <dada1@cosmosbay.com>, <pavel@ucw.cz>, <linas@austin.ibm.com>
> Cc: linuxppc-dev@ozlabs.org
> Cc: <wli@holomorphy.com>, <dada1@cosmosbay.com>, <pavel@ucw.cz>, <linas@austin.ibm.com>

The addressees are still odd.

> Subject: [PATCH] Performance Stats: Kernel patch
> Date: Thu, 10 May 2007 11:42:22 +0000
> User-Agent: StGIT/0.12.1
> 
> 
> Patch makes available to the user the following
> task and process performance statistics:
> 	* Involuntary Context Switches (task_struct->nivcsw)
> 	* Voluntary Context Switches (task_struct->nvcsw)
> 	* Number of system calls (added new counter
> 	  thread_info->sysall_count)

The patch looks good, thanks.  Except, as I said, I don't think we can
justify the syscall counter.  Yes, it's useful information and yes the
overhead is low.

But it adds overhead to every syscall on every machine in the world, which
is a lot of overhead.  And the number of machines which actually _use_ that
information will be small.

But hey, I might be wrong - perhaps lots of people have a burning need for
this information.  But we're not in a position to find that out because you
keep on mucking up the email recipient list :(


The patch is confused about the type of the syscall counter.  In some
places it is "unsigned long" but it gets sent to userspace as __u32.

Considering that this counter can be overflowed in a matter of seconds, you
definitely want it to be 64-bit on 64-bit machines.  And you probably want
it to be 64-bit on 32-bit machines as well.  More overhead there though.

Anyway, I suggest you fix that up and rereresend the patch, getting the
headers correct and we'll ask a wider audience about the
value-versus-overhead issue.

I suspect we'll end up only supporting the context-switch counters.  Given
that this requires an uprev to the taskstats interface, we should look at
whether there are other things which we should be exporting but which were
forgotten.  I'll have a think about that sometime.
