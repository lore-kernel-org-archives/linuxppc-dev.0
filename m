Message-Id: <200004110858.KAA05916@denx.local.net>
To: shanta@india.tek.com
cc: "'Wolfgang Denk'" <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basic questions about PPC embedded developement under Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Apr 2000 12:30:07 +0530."
             <000601bfa383$92e508b0$4f689ec0@w-shanta.india.tek.com>
Date: Tue, 11 Apr 2000 10:58:58 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000601bfa383$92e508b0$4f689ec0@w-shanta.india.tek.com> you wrote:
>
> I have a small question regarding the "bdiGDB".
> I need to first flash the kernel image into the flash memory. Can this be
> done with the debugger??

Yes. Using the telnet interface, you can  use  the  LOAD  command  to
download an image to RAM, and the PROG command to write it to FLASH:

LOAD   [<offset>] [<file> [<format>]] load program file to target memory
...
PROG   [<offset>] [<file>]   program flash memory

> Also the boot monitor needs to load the kernel image from the flash memory
> to the RAM and start executing it.
> Can this be traced with "bdiGDB"??

You can use a "target remote" command in GDB to attach to the  BDI200
debugger;  then  you  can use GDB; or you can do everything "by hand"
using the telnet interface and commands like these:

...
GO    [<pc>]                 set PC and start target system
TI    [<pc>]                 trace on instuction (single step)
TC    [<pc>]                 trace on change of flow
HALT                         force target to enter debug mode
BI  <from> [<to>] [<count>]  set instruction breakpoint
CI  [<id>]                   clear instruction breakpoint(s)
BD  [R|W] <addr> [<count>] [<data>] set data breakpoint (32bit access)
BDH [R|W] <addr> [<count>] [<data>] set data breakpoint (16bit access)
BDB [R|W] <addr> [<count>] [<data>] set data breakpoint ( 8bit access)
BDR <from> <to> [<count>]    set data breakpoint on a range
CD [<id>]                    clear data breakpoint(s)
...

Hope this helps.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The game of life is a game of boomerangs.  Our  thoughts,  deeds  and
words return to us sooner or later with astounding accuracy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
