Date: Tue, 15 Aug 2000 10:45:22 -0500
From: Dave Wolfe <dwolfe@lists.linuxppc.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: drand48() broken?
Message-ID: <20000815104522.B11780@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally got around to updating to Perl 5.6.0 over the weekend and
discovered something odd. I pretty much accepted everything Perl's
Configure suggested (except where to install) and it passed all the
self-tests. While I was debugging a new app that uses the Perl rand()
function, I kept getting the same output every time. I wasn't calling
srand() since Perl does that for you w/ a derived seed that's not the
same every time, so that's not it. When I tried the same code on the
same version of Perl built the same way on an x86 Linux box (RedHat
6.1), it worked as expected, returning a different value each time it
ran. The PCC system is a 2.1.125 kernel, gcc is egcs-2.90.25 980302
(egcs-1.0.2 prerelease), and glibc is 0.961212.

While digging into this weirdness, I noted that the man page for
drand48(), which Perl selected to use during configuration, is
deprecated. After rebuilding w/ rand() everything works identically to
the x86 build.

Is my PPC installation just too old and drand48() (actually it's
probably srand48() that's broken) is fixed now? To see what your Perl
uses, enter `perl -V:randfunc' (just `perl -V' gives you the version of
Perl). If it says `drand48', try this:

    while true;do perl -e 'print int rand(62), " "';done

(Hit ^C to stop it) then let's compare versions of the various parts.

--
 Dave Wolfe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
