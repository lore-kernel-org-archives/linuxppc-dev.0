To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 3.0 C++ Problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 May 2004 16:38:41 CDT."
             <6F45E974A11B294383FD819C76719D8701984F@txex2ku01>
Date: Thu, 20 May 2004 01:17:02 +0200
Message-Id: <20040519231707.ABD1EC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <6F45E974A11B294383FD819C76719D8701984F@txex2ku01>
Carlo Parravicini wrote:
>
> The problem is with your statement, "new int (1000)". This should be
> "new int [1000]". You are telling the compiler to initialize 1 integer
> to 1000 instead of allocating 1000 integers. Replace the parens with
> brackets and it should work.

Yes, this was one of the problems with his code.

Anotrher is that the length in the memset() is probably wrong:

> >   int *p = new int (10000);
> >   memset ( p, 0, 10000);

This clears only a small part of the (wanted?) array.


The whole code looks broken.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Our OS who art in CPU, UNIX be thy name.
Thy programs run, thy syscalls done,
In kernel as it is in user!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
