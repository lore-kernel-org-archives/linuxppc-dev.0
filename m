Message-ID: <3AD5170C.E6E369FC@kidar.org>
Date: Wed, 11 Apr 2001 19:46:36 -0700
From: nolan <nolan@radik.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, khendricks@ivey.uwo.ca
Subject: Re: another difference in gcc (2v) ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As long as we're "me too"ing, I might as well add that I suddenly hit the
same problem of non-caught exceptions.  I didn't install or upgrade
anything, just after about a month of intel only work, our system stopped
catching exceptions on PPC.  I tried upgrading from 2.95.2 to 2.95.3, but
got the exact same results.  All my simple test cases performed exactly
as expected, its only within the full system that exceptions break.  The
weird onset combined with my inability to reproduce the behavior in a
simple test suggest that only certain conditions cause the error.  I'm no
gcc hacker though.

Interestingly enough, -fno-schedule-insns and -fno-schedule-insns2 did
not help at all:

Program received signal SIGABRT, Aborted.
0xfdd4d9c in kill () at soinit.c:59
59      soinit.c: No such file or directory.
Current language:  auto; currently c
(gdb) bt
#0  0xfdd4d9c in kill () at soinit.c:59
#1  0xffd4ce8 in pthread_kill (thread=1024, signo=6) at signals.c:65
#2  0xffd5344 in raise (sig=6) at signals.c:226
#3  0xfdd62fc in abort () at ../sysdeps/generic/abort.c:88
#4  0xff40d08 in __default_terminate () from
/usr/lib/libstdc++-libc6.1-2.so.3
#5  0xff40d40 in __terminate () from /usr/lib/libstdc++-libc6.1-2.so.3
#6  0xff41d9c in __throw () from /usr/lib/libstdc++-libc6.1-2.so.3
#7  0x100f93f4 in Socket::writeBytes (this=0x7ffff048,
    pBuffer=0x10419090 "PUT /makefile.spec HTTP/1.1", iByteCount=27)
    at ./src/Socket.cpp:164
#8  0x100f9cac in HttpClient::sendRequest (this=0x7ffff048,
    header=@0x7fffeee8, body=0x7ffff248) at ./src/HttpClient.cpp:55
#9  0x100cc5cc in TestHttpClient::doRequest (this=0x7ffff538,
    client=@0x7ffff048, iRequestType=PUT, pBody=0x7ffff248)
    at ./test/HttpClientTest.cpp:103
#10 0x100cc230 in TestHttpClient::runTests (this=0x7ffff538)
    at ./test/HttpClientTest.cpp:87
#11 0x100cbcbc in main (argc=4, argv=0x7ffff654)
    at ./test/HttpClientTest.cpp:41
#12 0xfdcd69c in __libc_start_main (argc=4, argv=0x7ffff654,
envp=0x7ffff668,
    auxvec=0x7ffff71c, rtld_fini=0, stinfo=0x103111f0,
    stack_on_entry=0x7fffe850) at ../sysdeps/powerpc/elf/libc-start.c:106
(gdb)

The call to Socket::writeBytes in HttpClient::sendRequest is wrapped in a
try { } block set to catch exactly the exception thrown by
Socket::writeBytes.  Even generalizing the try to catch ALL exceptions
didn't actually result in it catching the exception.  It works fine on
Alpha Linux (gcc-2.96), intel Linux(gcc-2.96 and 2.95.2), and Solaris
(gcc-2.95.2).

This probably doesn't help at all, but hey, the more data points, the
merrier.

On Wed, 11 Apr 2001, Florin Boariu wrote:
>
> Sorry I jump in like this w/o atually knowing what you're talking about
> (I'm not familiar with PPC assembly language, and I didn't follow this
> thread), but I just heard the words "exception table" and "incorrect" and
> this attracted my attention: I'm now sure whether it's the same problem
> (or at least a similar one), but I had some strange segmentation faults
> while throwing some C++ exceptions in a project I'm working on. The same
> code runs without problems on an i586...
>
> I wasn't able to fix them yet since I was in pressure of time, but one day
> I'll have to face them again -- and I'm really not looking forward to
> that.
>
> Does this relate? If not, I'm sorry for the rude interruption...
>
> regards,
> florin.
>
> On Wed, 11 Apr 2001, David Edelsohn wrote:
>
> >
> >       "subf" and "srawi" only set condition codes if the "Rc" bit is
> > set, e.g. "subf." and "srawi."
> >
> >       Given the two sequences of code you have sent, I think the problem
> > is tht the exception table is being initialized with incorrect labels.
> >
> > David
> >
> >
> >

--
nolan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
