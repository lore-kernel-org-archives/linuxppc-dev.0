Date: Wed, 23 Feb 2000 05:40:30 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000223124030.ZM2395@saguaro.lan>
In-Reply-To: "jjs" <Jerry.Sexton@insignia.com>
        "gdb and multi-threaded applications." (Feb 23, 10:09am)
References: <001101bf7de6$07263dc0$571170c1@honda.isltd.insignia.com>
To: "jjs" <Jerry.Sexton@insignia.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gdb and multi-threaded applications.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 23, 10:09am, jjs wrote:

> I recently installed linuxppc-1999 on my beige G3. The main motivation for
> doing this was to debug a multi-threaded application, which I could not do
> under the Release 4 that I previously had installed.
>
> The version of gdb that comes with the distribution (which I got from
> ftp.linuxppc.org) is 4.17.0.11, which is not multi-thread aware. I therefore
> got hold of the sources for 4.17 from ftp.gnu.org and H.J.Lu's patches for
> 4.17.0.14 and compiled up the resulting sources. According to the release
> notes for 4.17.0.14, the change form 4.17.0.11 to 4.17.0.12 adds support for
> LinuxThreads on PowerPC, so the version I have should work for
> multi-threaded applications. However, typing 'info threads' on the
> resultingexecutable, just returns me to the gdb prompt. Typing 'thread 1',
> yields the message 'Thread ID 1 not known. Use the "info threads" command to
> see the IDs of currently known threads.'. According to the gdb info, this is
> typical behaviour of a gdb that does not have multi-threaded support.
>
> Also, running the gdb.threads test in the testsuite that comes with the
> distribution, tells me that my gdb does not support pthreads for this
> machine.
>
> All the evidence points to my gdb build not supporting multiple threads. Can
> anybody tell me what I am doing wrong?

I'm not sure that you're doing anything wrong.  Was the program in
question multithreaded?  I see the same behavior on linux/x86 when
debugging a single threaded program.

Regardless, you may want to try the latest gdb sources from the CVS
repository at sourceware.cygnus.com.  I've recently merged the gdb
patches for linux/ppc into the "official" source base and need help
testing this code.  This version is thread aware and passes all of the
thread related tests in the test suite.  In fact overall, I'm seeing
only 31 failures.  (This number rises to 70 if you also build/test
insight (gdbtk)).

See http://sourceware.cygnus.com/gdb/ for information on how to obtain
the sources.

Kevin

--
Kevin Buettner
kev@primenet.com, kevinb@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
