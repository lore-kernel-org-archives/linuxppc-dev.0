Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: fstream on PPC?
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1069081757.25853.5.camel@toni>
Mime-Version: 1.0
Date: Mon, 17 Nov 2003 16:09:18 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

A programmer has written an GUI application that has to run on my EP405
board. When compiling the application without any fstream calls, it
works fine.
But when I allow the functions that use fstream (for saving and loading
small files over NFS), I get the following error:

Linking test...
/opt/eldk/usr/ppc-linux/bin/ld: warning: libstdc++-libc6.2-2.so.3,
needed by /opt/PPC_X/usr/X11R6/lib/libGLU.so, not found (try using
-rpath or -rpath-link)
test.o: In function `figure::save(ofstream &)':
test.o(.text+0x1574): undefined reference to
`ostream::operator<<(double)'
test.o(.text+0x1574): relocation truncated to fit: R_PPC_REL24
ostream::operator<<(double)
test.o(.text+0x157c): undefined reference to `ostream::operator<<(char
const *)'
....
and more than a dozen of these errors. It's a linking problem, that's
what I know. But I don't know how to get to the problem-core. Can I
solve this by a quick hack? Or is it hopeless to start messing with
fstream on PPC?

The app is written with FLTK support, and is compiled as a test-program
inside the standard FLTK-tree (after adding a Makefile entry for the
app, which is currently called test.cxx).
All written in C++.

PS: don't mind the warning about libstdc++-libc6.2-2.so.3, it's in place
on the embedded system.

PPS: Had to do a hack for the stream functions, because the original was
developed on Windows with MS Visual Studio. Calling them all with &f_in
etc)
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
