To: linuxppc-dev@lists.linuxppc.org
Cc: Dan Malek <dan@embeddededge.com>
Subject: Re: "slow" ports on MPC8255 ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Jun 2003 22:47:03 +0200."
Date: Wed, 18 Jun 2003 16:24:03 +0200
Message-Id: <20030618142408.8C4BAC5FD7@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I wrote:

> has anybody of you experienced problems with accesses  to  port  data
> registers on a MPC8255 yet?
...
> - writing port A data register (as 32  bit  word)  and  then  looping
>   reading  it back will show that it takes some time for the write to
>   take effect, i. e. we can read the old  value  for  some  time  and
>   then, bit for bit, the new value becomes visible.

Problem solved. The solution was simple. Looking closer I found  that
the  effect  showed only up for bits changing from 0 to 1. Then I saw
that ports pins in  question  are  configured  as  open  drain.  When
switching  a  pin  to 1 the level would rise slow enough that reading
the data register would pick up a low (0) for several cycles.

So actually it was no problem at all, just some slow circuitry and  a
fast  CPU.  Don't  know why the MPC8260 behaves differently (internal
pull-ups?).


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The human mind ordinarily operates at only ten percent of its capaci-
ty - the rest is overhead for the operating system.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
