To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: access memory mapped registers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Jan 2003 16:46:45 PST."
             <885489B3B89FB6449F93E525DF78777F064542@srvnt506.ALLOPTIC.COM>
Date: Fri, 10 Jan 2003 02:20:23 +0100
Message-Id: <20030110012028.3831EC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <885489B3B89FB6449F93E525DF78777F064542@srvnt506.ALLOPTIC.COM> you wrote:
>
> I can see if I mmap the internal 860 CPU registers, and screw up that, I
> will
> definitely screw up the system, and require it to be reboot.  BUt if the
> hardware we are mapping is outside the CPU internal memory and outside the
> RAM,
> shouldn't the failure be limited to the user application only then?

No. For example, assume there is a port pin  which  is  meant  as  an
input,  and  the  signal  is  driven from external hardware. Now your
application program by mistake re-programs this pin  as  output.  You
may smoke your board this way.

> only the memory regions that is mapped to the ethernet switching chip,
> even if I screw up on the hardware setup, shouldn't my kernel still be
> protected?  At most, the application faults and I should be able to restart
> the application without rebooting the system?

There is a simple rule: if you open backdoors in a secure system  the
result  is  an insecure system. Write clean code.


There is many things you have to keep in mind:

* Functionality: you cannot process interrupts in user space

* Performance: how do you synchronize your accesses to the  hardware?

* Communication: How do you know when data has been processed, or has
  become available, or stable, or ...?

* Tricky things: What will the caches in  your  system  do  when  the
  application  accesses  the  hardware?  How will you address memory?
  Remember that there are systems where  a  32  bit  address  is  not
  sufficient any more...

etc. etc.

Write clean code.



Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Life is a game. Money is how we keep score.              - Ted Turner

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
