Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdbserver and gdb cross debug?
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: jack.sun@bmrtech.com
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3DCF5E9B.406F7565@bmrtech.com>
References: <200210260458.g9Q4wpq15745@ftp1.mvista.com>
	<3DCF5E9B.406F7565@bmrtech.com>
Content-Type: text/plain
Date: 11 Nov 2002 14:12:02 +0100
Message-Id: <1037020322.22840.70.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2002-11-11 at 08:39, sjk wrote:
>
> Hi,
>
> I am porting Linux on EP405 board. So I use gdbserver and gdb to debug
> applications,but only the first
> breakpoint could be stopped.Then if i press 'step', the program will
> execute to end straightforwardly . Any other breakpoints could not break
> the execution.
>
> Please give me some advice!

I did some testing on the devel source and with gdb from debian I got
the same result. Strangely doing a next works ??

I turned off bdi and kgdb but still got the same problem. From reading
kernel/ptrace.c it dose look like the only problem should be single
step. The problem is probably that there exist some return path to user
space where we miss restoring the msr or debug register but I have to
look deeper into this.

Do somebody have testing code for ptrace?? running gdb is a bit heavy
I'm not even sure it's the single step that is wrong.

Also I tried to cross compile gdb5.2 and that did not work as I want
both host and target to be the same and build to be set to i386 but host
and build is the same in the makefile :(

Has anybody tried the bdi2000 is that also broken now ?

What version and patches do people use for gdb on 4xx ?

Strace do not use singlestep but still fails spectacularly when I tested
with my main application. I did not expect tracing an app to make this
app fail to run. tracing simple shell commands like ls works just fine.

What type of problems should I expect to have with strace ?



/me really should get my toolchain in order but print(f|k) is so much
easier to use than first fix the debugger :(



--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
