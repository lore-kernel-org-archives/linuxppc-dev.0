Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DE1B1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 20:19:08 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A586E14031F
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 20:19:07 +1100 (AEDT)
Date: Wed, 9 Mar 2016 10:19:04 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160309091904.GA23039@lst.de>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2016 at 05:59:40PM +1100, Balbir Singh wrote:
> 
> The previous revision was nacked by Torsten, but compared to the alternatives

I nacked it because I was confident it couldn't work. Same goes
for this one, sorry. My good intention was to save us all some work.

> @@ -1265,6 +1271,51 @@ ftrace_call:
>  	ld	r0, LRSAVE(r1)
>  	mtlr	r0
>  
> +#ifdef CONFIG_LIVEPATCH
> +	beq+	4f		/* likely(old_NIP == new_NIP) */
> +	/*
> +	 * For a local call, restore this TOC after calling the patch function.

This is the key issue.

Ftrace_caller can gather and save the current r2 contents, no problem;
but the point is, it needs to be restored *after* the replacement function.
I see 3 ways to accomplish this:

1st: make _every_ replacement function aware of this, and make it restore
     the TOC manually just before each return statement.

2nd: provide a global hook to do the job, and use a stack frame to execute it.

3rd: have a global hook like solution 2, but let it have its own data
     structure, I'd call it a "shadow stack", for the real return addresses.
     See struct fgraph_cpu_data in kernel/trace/trace_functions_graph.c

Using heuristics to determine whether the call was local or global
makes me feel highly uncomfortable; one day it will break and
nobody will remember why.

Balbir, the problem with your patch is that it goes only half the way from
my solution 2 towards solution 1. When you call a helper function on return,
you need a place to store the real return address.

I'll try to demonstrate a solution 1 as well, but you'll probably won't like
that either...

	Torsten
