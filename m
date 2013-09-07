Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F11132C0116
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 17:12:51 +1000 (EST)
Message-ID: <1378537960.4539.9.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 07 Sep 2013 17:12:40 +1000
In-Reply-To: <CA+55aFwvPNu6-PHJmDkqihiCgMy=TH_we8LtVKm31teWhmLQPw@mail.gmail.com>
References: <1378434264.4321.209.camel@pasglop>
 <CA+55aFwvPNu6-PHJmDkqihiCgMy=TH_we8LtVKm31teWhmLQPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-06 at 10:56 -0700, Linus Torvalds wrote:
> On Thu, Sep 5, 2013 at 7:24 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> >  * A bunch of endian fixes ! We don't have full LE support yet in that
> > release but this contains a lot of fixes all over arch/powerpc to use the
> > proper accessors, call the firmware with the right endian mode, etc...
> 
> Ok, this caused a conflict in arch/powerpc/kernel/prom.c, where some
> of the OF CPU number accessors had been moved to generic OF code
> instead.

Ah yes, sorry, I completely forgot to tell you about that ! (I was in a
hurry to leave for the snow :-)

> It *looks* to me like those accessors had already been made
> endian-clean as part of the move to generic code, and so my conflict
> resolution was to just ignore the parts of the changes the code that
> no longer exists in prom.c, but you really should double-check my
> resolution. Maybe I screwed it up.

Ok, yes I had reviewed the new stuff and it should already be endian
safe, so it should be all good, but I'll double check everything as soon
as I'm back.

> But apparent'y the LE mode isn't finished, so hopefully even if I read
> those changes wrong it won't affect you guys too badly. I didn't
> test-compile any of it, yadda yadda..

Yup, that's fine :-) We have a full LE tree internally of course but we
are holding on some of the stuff until we decide what to do with the ABI
(it would be nice to get rid of function descriptors for example) and
fix some more bugs.

So I decided to merge a batch of the "easy" stuff just to get it out of
the way this time around, and hopefully the rest will be spread out
across the next one or two merge windows.

Cheers,
Ben.

>               Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
