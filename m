To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU and BDI2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 15 Sep 2001 22:46:10 +0800."
             <5.1.0.14.0.20010915223300.02bef9f0@pop.gmx.de>
Date: Sat, 15 Sep 2001 17:17:29 +0200
Message-Id: <20010915151735.0976C10099@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.0.20010915223300.02bef9f0@pop.gmx.de> you wrote:
>
> >default  translation  is  enabled.  See  the  BDI2000  user's manual,
> >Section "3.2.2 Part [TARGET]" (Entries "MMU XLAT  [kb]"  and  "PTBASE
> >addr") and Section "3.3.4 Embedded Linux MMU Support".
>
> You have no idea how often I had read this and I couldn't even find out if
> it belongs to my problem.
>
> How do I get the swapper_pg_dir? Is it the constant address from System.map?

You need the contents, like that:

(gdb) target remote bdi:2001
Remote debugging using bdi:2001
0x100 in ?? ()
(gdb) b start_here
Breakpoint 1 at 0xc0002180
(gdb) c
Continuing.

Breakpoint 1, 0xc0002180 in start_here ()
(gdb) p &swapper_pg_dir
$1 = (<data variable, no debug info> *) 0xc0130000


Now at the BDI2000 telnet prompt:

BDI>mm 0xf0 0xc0130000


And the again with GDB;

(gdb) c
Continuing.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I've got to get something inside me. Some coffee  or  something.  And
then the world will somehow be better.
                                     - Terry Pratchett, _Men at Arms_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
