Date: Fri, 7 Mar 2003 10:47:53 -0600
From: Nathan Ingersoll <ningerso@ruralcenter.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Runtime Altivec detection
Message-ID: <20030307164753.GA5240@ruralcenter.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've recently been working on some Altivec optimizations for a library,
and was looking for a relatively clean way to perform runtime detection.
I did quite a bit of searching and didn't find any good examples of
someone doing this, other than using the sysctl call on Mac OS X.

I decided to whip up a simple test program based on the assumption that
running Altivec code on a non-Altivec enabled CPU would cause a SIGILL.
Basically, I setjmp a position before an altivec instruction is
performed, and catch the SIGILL, then longjmp back into the main program
>from the signal handler.

This seems to work pretty well, at least in my simplistic test case. Is
anyone aware of some long term problems doing this? some possible side
effects? I've seen other projects catch the SIGILL and exit on it, are
they not attempting to fix up after because they know something I don't?

If this is a reasonable approach, I'm hoping to extend it for generic
feature testing on a variety of processors. I've heard that the process
state is undefined by POSIX after a SIGILL has occurred, does anyone know
of a platform where this could be an issue?

I've posted the code I'm testing at http://ningerso.atmos.org/code/alt.c
If no one points out a serious flaw to the approach, and the idea is useful
feel free to use the code under the BSD+advertising clause license.

Any comments or insights?
Thanks,
Nathan

--
------------------------------------------------------------------------
| Nathan Ingersoll           \\ Computer Systems & Network Coordinator |
| ningerso@ruralcenter.org    \\ http://www.ruralcenter.org            |
| http://ningerso.atmos.org/   \\ Minnesota Center for Rural Health    |
------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
