To: Dean Matsen <deanmatsen@earthlink.net>
Cc: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: parallel I/O ports & opend darin pins on MPC8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jul 2003 13:13:54 PDT."
             <3F0C7782.3060704@earthlink.net>
Date: Wed, 09 Jul 2003 22:17:47 +0200
Message-Id: <20030709201752.7D07FC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F0C7782.3060704@earthlink.net> you wrote:
>
> But I still don't see how you could avoid having other drivers clobber
> your output but.  I think he has to take one of the two options I

By modifying _all_ drivers that will modify the port in question in a
way that is based on previously read data.

> suggested.  Adding his own variable can't help in any way I can
> imagine.  Could you give an example?

Find out which port pin(s) is/are  configured  as  OD  output.  Check
which  other port pins on this port are in use, and which drivers are
using these port pins. Make all these drivers  use  a  common  buffer
variable. Voila...


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If a packet hits a pocket on a socket on a port,
And the bus is interrupted as a very last resort,
And the address of the memory makes your floppy disk abort,
Then the socket packet pocket has an error to report! - Ken Burchill?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
