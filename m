Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C3E992C02B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 08:37:57 +1000 (EST)
Message-ID: <1370817463.14883.36.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2013 08:37:43 +1000
In-Reply-To: <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
References: <1370764616.14883.28.camel@pasglop>
 <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-09 at 14:33 -0700, Linus Torvalds wrote:
> On Sun, Jun 9, 2013 at 12:56 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > Here are a few more powerpc changes for 3.10. I've merged your
> > tree in at some point (which I generally avoid) in order to get
> > the compat network fixes as soon as possible.
> >
> > Mostly regressions, and stuff I judged could/should still go in at
> > this stage.
> 
> Not pulled, because your hamster smells of eldeberries.
> 
> This is not just bugfixes. In fact, as far as I can tell, this
> *introduces* bugs, with that "get_user()" in the exception path that
> can apparently happen with irqs disabled and will thus potentially
> result in new warnings that just make things unreadable.

Ah right, brown paper bag for Anton and I :(

I shouldn't have put that one in, it was a last minute bad decision
after spending time tracking another stupid sigill in userspace (this
time FSL CPUs not implementing some optional instructions that Fedora
compiler seems configured to generate nowadays).

> I'm f*cking tired of people having problems understanding "we're past
> rc5". If it's not something you would call stable material, you
> shouldn't send it to me.

I've taken out that commit and the rename of the PMU interrupt (which
while trivial probably wasn't important enough). Everything else is
regressions/stable material.

That does mean I rebased, but normally nobody bases on that merge branch
so it should be fine.

I'll send a new pull request.

Cheers,
Ben.

>               Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
