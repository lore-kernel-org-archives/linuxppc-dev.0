Subject: Re: gdbserver and gdb cross debug?
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: jack.sun@bmrtech.com
Cc: bgat@billgatliff.com,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3DD845D7.5C98736B@bmrtech.com>
References: <200210260458.g9Q4wpq15745@ftp1.mvista.com>
	<3DCF5E9B.406F7565@bmrtech.com>
	<20021115134822.A5906@saturn.billgatliff.com>
	<3DD845D7.5C98736B@bmrtech.com>
Content-Type: text/plain
Date: 18 Nov 2002 09:16:03 +0100
Message-Id: <1037607363.15662.199.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2002-11-18 at 02:43, sjk wrote:
>
> "William A. Gatliff" wrote:
>
> > Jikun:
> >
> > On Mon, Nov 11, 2002 at 03:39:07PM +0800, sjk wrote:
> > > I am porting Linux on EP405 board. So I use gdbserver and gdb to debug
> > > applications,but only the first
> > > breakpoint could be stopped.Then if i press 'step', the program will
> > > execute to end straightforwardly . Any other breakpoints could not break
> > > the execution.
> >
> > Have you compiled the application in question with optimizations?  Gdb
> > isn't so good at debugging optimized code.  Compile with -g -O0 if you
> > intend to debug.
>
> I tried to compile hello.c as following:
>
> ppc_405-gcc -g -O0 -o hello hello.c
>
> Then set up the connection of gdbserver and ppc_405-gdb. The program could not
> be debugged step by step either.
> Is it possible that there is bug in ptrace.c or traps.c
>
>
> Thanks a lot
>
> Jikun

I have looked into this some more and could not find any problem on the
kernel side(this is no guarantee that none exist). I also get the same
problem with the gdb version from debian (woody)and a fresh compile of
5.2.

However using the gdb 5.1.1 from ELDK 2.0 makes single step work but it
steps right into functions that have no debugging information and I
think step is supposed to avoid this.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
