To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding parallel port in MPC8245... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Aug 2004 00:25:37 PDT."
             <20040802072537.86860.qmail@web13604.mail.yahoo.com>
Date: Mon, 02 Aug 2004 10:13:27 +0200
Message-Id: <20040802081332.C7D75C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040802072537.86860.qmail@web13604.mail.yahoo.com> you wrote:
>
>          Im working on MPC8245 board..
> with timesys GPL-linux..
...
> ---------
> #include "asm/io.h"
> #include<unistd.h>
> #include<stdlib.h>
> #include<stdio.h>
> main()
> {
>         outb(0x378,0xff);
>         printf("Data sent out \n");
> }
> ----------------------------------------
...
> the oub function  defination is in  "asm/io.h"..which
> i included but also it is showing error undefined
> reference...

You make many errors here at once.

First: "asm/io.h" is a kernel header file, and you are  not  supposed
to include it at all in a user space application file.

Second: outb() is only available for kernel code (drivers) on PowerPC.

Third: I don't think that 0x378 will work on your MPC8245 board.

Four: eventually there is not even a PC style parallel port  on  your
board.

> in x86 it was executed perfectly...

Not all the world is a VAX...


Check with your board manual if there is really a PC  style  parallel
port  on  it,  and if so, on which addresses it is mapped. Then study
Alessandro Rubini, Jonathan Corbet:  _"Linux  Device  Drivers"_,  2nd
Edition,  and  get  a clue about driver programming. Then implement a
device driver.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
FORTRAN? The syntactically incorrect statement "DO 10 I = 1.10"  will
parse  and  generate  code  creating  a  variable, DO10I, as follows:
"DO10I = 1.10" If that doesn't terrify you, it should.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
