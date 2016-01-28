Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE5EB1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 22:50:53 +1100 (AEDT)
Date: Thu, 28 Jan 2016 12:50:49 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, Anton Blanchard <anton@samba.org>,
 amodra@gmail.com, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20160128115049.GE32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
 <1453889967.10839.2.camel@ellerman.id.au> <20160127104400.GA32095@lst.de>
 <1453955219.4108.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453955219.4108.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2016 at 03:26:59PM +1100, Michael Ellerman wrote:
> 
> That raises an interesting question, how does it work *without* DYNAMIC_FTRACE?
> 
> It looks like you haven't updated that version of _mcount at all? Or maybe I'm
> missing an #ifdef somewhere?

You didn't, I did. I haven't considered that combination.

> It doesn't look like that will work right with the -mprofile-kernel ABI. And
> indeed it doesn't boot.

The lean _mcount should handle it and boot, had I not misplaced it in
the #ifdefs, but then of course profiling wouldn't work.

> So we'll need to work that out. I guess the minimum would be to disable
> -mprofile-kernel if DYNAMIC_FTRACE is disabled.

I feel that supporting all combinations of ABIv1/ABIv2, FTRACE/DYNAMIC_FTRACE,
-p/-mprofile-kernel will get us into #ifdef hell, and at least one kernel
developer will go insane. That will probably be the one porting this
to ppc64be (ABIv1).

> Frankly I think we'd be happy to *only* support DYNAMIC_FTRACE, but the generic
> code doesn't let us do that at the moment.

Seconded.
I'll have a look at the Kconfigs.

> But it's better than the previous version which didn't boot :)

That's your fault, you picked the wrong compiler ;-)

> Also ftracetest fails at step 8:
>   ...
>   [8] ftrace - function graph filters with stack tracer
>   Unable to handle kernel paging request for data at address 0xd0000000033d7f70
[...]
> That doesn't happen without your series applied, though that doesn't 100% mean
> it's your bug. I haven't had time to dig any deeper.

Will check as well...

	Torsten
