To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: parallel I/O ports & opend darin pins on MPC8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jul 2003 12:01:39 +0200."
             <FCEAKDJJAPHPLJFINDAJCEGCDEAA.Stephan.Linke@epygi.de>
Date: Wed, 09 Jul 2003 12:24:09 +0200
Message-Id: <20030709102414.2879CC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Stephan,

in message <FCEAKDJJAPHPLJFINDAJCEGCDEAA.Stephan.Linke@epygi.de> you wrote:
>
> There are two drivers, both are manualy manipulating bits at the same I/O port.
> Both drivers use the following mechanism to change the value of their pin: they
> read the value from the data register changeing the value and writing the result
> back to the data register (hopefully an atomic access). This works fine since
> for normal output pins you can read the output value and for input pins it's a
> don't care. As soon as one of the drivers use open drain pins something changes.

You must define for your driver(s) what they shall do, and  implement
it that way.

> You can't read the output value any more sou you are starting to drive the
> output pin of the other driver with the input value. Which can be a verry bad
> idea.

Wrong.

Correct is:  You  cannot  read  the  output  value  from  the  _data_
register,  because external logic might drive a the level low even if
your output bit says "high".

Note 1: There is nothing  that  prevents  you  from  using  a  simple
        integer  variable  to latch the value you write to the output
        port. This is so simple that I'm really surprised you did not
        come up with this solution yourself. And  of  course  such  a
        "buffer" can be shared between several drivers, too.

Note 2: Actually I don't think _anything_  changes  between  actively
        driven output and open drain. I think the value you read from
        the  inputs will ALWAYS reflect the actual value at the pins.
        You may want to test what happens when you configure  a  port
        as  actively  driven  output, write a 1 bit to it, ground the
        output pin, and then read back the data  register.  I  bet  a
        case of beer that you will read a 0 bit.

	And no, I will not pay for the CPU you just fried.


> That's why I aggree open drain I/O's are a good feature but in detail they are
> difficult to deal with. The only solution I came up with was a non atomic access
> to data and open drain register and I don't what to block IRQ changing a single
> pin in let's say the I2C driver. So our current solution is to make the
> suspicious pin an input (preventing 10BT from being switched from half to full
> duplex).

??? I must be missing something. I wouldn't  think  such  complicated
stuff is necessary here at all.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A mouse is an elephant built by the Japanese.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
