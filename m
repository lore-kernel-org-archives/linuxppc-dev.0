Return-Path: <linus971@gmail.com>
Received: from mail-ve0-x234.google.com (mail-ve0-x234.google.com
 [IPv6:2607:f8b0:400c:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E1CF2C02AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 07:55:00 +1000 (EST)
Received: by mail-ve0-f180.google.com with SMTP id pa12so4254566veb.39
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jun 2013 14:54:56 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
References: <1370764616.14883.28.camel@pasglop>
 <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
Date: Sun, 9 Jun 2013 14:54:55 -0700
Message-ID: <CA+55aFxAC4EksZcz7SaZNjF9mfKkwLjWp2rEKxMZT8m-7uBeNQ@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
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

[ Is Jeremy the patchwork maintainer? If not, can people forward this
to the real maintainer? ]

On Sun, Jun 9, 2013 at 2:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is not just bugfixes. In fact, as far as I can tell, this
> *introduces* bugs, with that "get_user()" in the exception path that
> can apparently happen with irqs disabled and will thus potentially
> result in new warnings that just make things unreadable.

Looking at that particular commit, I also notice that the commit
itself is buggered in other ways too.

It says:

    Date:   Thu Jun 6 19:42:54 2013 +0000

which surprised me due to the odd timezone, and it turns out it is
pure and utter crap.

Google finds the patch in patchwork, and "Show headers" there shows
the expected timezone

    Date: Fri, 7 Jun 2013 15:42:54 +1000

and it turns out that apparently 'patchwork' is just making up random
times, because when you download the email as an mbox, it will turn
this into that corrupt and incorrect

    Date: Thu, 06 Jun 2013 19:42:54 -0000

thing which is apparently how you got the wrong timestamp to begin with.

That odd time doesn't even make any sense that I can see, because
those two times have absolutely nothing in common afaik. Unless
timezones work differently down under. It looks like some west-coast
local time, but then it says "-0000" which is code for "I have no
f*cking clue what I'm doing".

Just to make things extra exciting, patchwork actually shows yet
*another* date string when you just look at the patch in the web
interface:

    Date June 7, 2013, 5:42 a.m.

and that actually seems to be the *correct* UTC version of that
original email date. I have no idea what that "Thu, 06 Jun 2013
19:42:54 -0000" date is, and where it came from. But it is utter
shite.

Can somebody please make sure that patchwork doesn't destroy
timezone/date information? I'm assuming this has been going on
forever, and I just noticed because I looked at that particular commit
for other reasons, and went "Is Anton in Europe now?".

             Linus
