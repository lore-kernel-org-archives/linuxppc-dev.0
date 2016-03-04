Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42EE1A032F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 20:31:41 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 300DB14030F
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 20:31:40 +1100 (AEDT)
Date: Fri, 4 Mar 2016 10:31:35 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org, jeyu@redhat.com,
 jkosina@suse.cz, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, duwe@lst.de, live-patching@vger.kernel.org,
 Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
In-Reply-To: <1457078325.20076.1.camel@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1603041026320.31153@pobox.suse.cz>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <1457078325.20076.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

On Fri, 4 Mar 2016, Michael Ellerman wrote:

> Hi Petr,
> 
> On Thu, 2016-03-03 at 17:52 +0100, Petr Mladek wrote:
> 
> > From: Balbir Singh <bsingharora@gmail.com>
> >
> > Changelog v4:
> > 	1. Renamed klp_matchaddr() to klp_get_ftrace_location()
> > 	   and used it just to convert the function address.
> > 	2. Synced klp_write_module_reloc() with s390(); made it
> > 	   inline, no error message, return -ENOSYS
> 
> OK.
> 
> > 	3. Added an error message when including
> > 	   powerpc/include/asm/livepatch.h without HAVE_LIVEPATCH
> 
> I don't know why we want to do that, I don't see how it is helpful. It doesn't
> even do what it says:
> 
> > +#ifdef CONFIG_LIVEPATCH
> ...
> > +#else /* CONFIG_LIVEPATCH */
> > +#error Include linux/livepatch.h, not asm/livepatch.h
> > +#endif /* CONFIG_LIVEPATCH */
> 
> If I turn on CONFIG_LIVEPATCH then I can quite happily include asm/livepatch.h
> and not get an error. So the check doesn't do what the message suggests.

Well, yes. I looked into the archives to find if there was a reason to 
even introduce it. It was not. It came up during a review process of the 
livepatching patch set somehow and we left it there. I only changed the 
error message to the mentioned one because we deemed it was better.
 
> If we *really* want to prevent people from including asm/livepatch.h then it
> needs to check for _LINUX_LIVEPATCH_H_. But there's no reason I can see why we
> *must* prevent people from including asm/livepatch.h.
>
> And on x86 & s390 it does:
> 
>   #else
>   #error Live patching support is disabled; check CONFIG_LIVEPATCH
>   #endif
> 
> Which is also not helpful AFAICS, and just likely to break the build for no
> good reason.

This is the old message. See 383bf44d1a8b ("livepatch: change the error 
message in asm/livepatch.h header files").

Anyway, it really does not mean much. I'll send a patch for s390 and x86 
to remove it completely in a minute.

Thanks,
Miroslav
