Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0F0C1A033D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:29:57 +1100 (AEDT)
Message-ID: <1457321396.19197.3.camel@ellerman.id.au>
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org,
 jeyu@redhat.com,  jkosina@suse.cz, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org,  kamalesh@linux.vnet.ibm.com, duwe@lst.de,
 live-patching@vger.kernel.org,  Torsten Duwe <duwe@suse.de>
Date: Mon, 07 Mar 2016 14:29:56 +1100
In-Reply-To: <alpine.LNX.2.00.1603041026320.31153@pobox.suse.cz>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <1457078325.20076.1.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603041026320.31153@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-03-04 at 10:31 +0100, Miroslav Benes wrote:
> On Fri, 4 Mar 2016, Michael Ellerman wrote:
> > On Thu, 2016-03-03 at 17:52 +0100, Petr Mladek wrote:
> > 
> > >     3. Added an error message when including
> > >        powerpc/include/asm/livepatch.h without HAVE_LIVEPATCH
> > 
> > I don't know why we want to do that, I don't see how it is helpful. It doesn't
> > even do what it says:
> > 
> > > +#ifdef CONFIG_LIVEPATCH
> > ...
> > > +#else /* CONFIG_LIVEPATCH */
> > > +#error Include linux/livepatch.h, not asm/livepatch.h
> > > +#endif /* CONFIG_LIVEPATCH */
> > 
> > If I turn on CONFIG_LIVEPATCH then I can quite happily include asm/livepatch.h
> > and not get an error. So the check doesn't do what the message suggests.
> 
> Well, yes. I looked into the archives to find if there was a reason to 
> even introduce it. It was not. It came up during a review process of the 
> livepatching patch set somehow and we left it there. I only changed the 
> error message to the mentioned one because we deemed it was better.

Thanks for looking into it.

> > And on x86 & s390 it does:
> > 
> >   #else
> >   #error Live patching support is disabled; check CONFIG_LIVEPATCH
> >   #endif
> 
> This is the old message. See 383bf44d1a8b ("livepatch: change the error 
> message in asm/livepatch.h header files").
> 
> Anyway, it really does not mean much. I'll send a patch for s390 and x86 
> to remove it completely in a minute.

Thanks. I know it's not a big deal, but the kernel is complicated enough
without extra code we don't really need :)

cheers
