To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: parallel I/O ports & opend darin pins on MPC8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jul 2003 12:56:29 +0200."
             <FCEAKDJJAPHPLJFINDAJEEGGDEAA.Stephan.Linke@epygi.de>
Date: Wed, 09 Jul 2003 14:09:45 +0200
Message-Id: <20030709120950.476EFC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Stephan,

in message <FCEAKDJJAPHPLJFINDAJEEGGDEAA.Stephan.Linke@epygi.de> you wrote:
>
> So a verry simple question remains:
>
> If it's so easy, why isn't all that already done in the existing
> drivers that are manipulating single I/O pins like 8xx_io/enet.c drivers/i2c/i2c-algo-8xx_soft.c? Since they are the candidates

I think the answer is simply that nobody needed it yet  so  it  never
caused problems?

Open drain outputs are very ralrey used after all. On all the  boards
we had in the lab there was only one which happened to use OD outputs
- and this just to drive a LED display, where actively driven outputs
worked as well.

[And actually in this case the OD outputs did  cause  problems,  too:
the  customer  implemented some code which would set a state and read
it back immediately, which did not work. It turned out  the  the  CPU
was faster than the raising time of the signal.]

> for such trouble if someone uses these drivers and has an additional
> open drain pin on one of his ports...
>
> And I thought we should be talking about a general solution, not only
> about how I can fix my little problem.

I'm afraid I'm not in the position to change anything.

There are several  isssues  with  using  port  pins,  like  the  chip
internal  race condition when using PWM outputs. I don't think that a
good general  solution  for  all  these  issues  is  available.  Your
configuration  is  pretty  rare,  so it is probably handled best as a
special case, outside the general code. -- YMMV.



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Everything should be made as simple as possible, but not simpler."
                                                    - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
