Subject: Re: Problems using shared library in corss environment
To: sugenius@doit.ajou.ac.kr (Seong-kyu Ko)
Date: Tue, 22 Aug 2000 11:34:11 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0008220121070.24904-100000@doit.ajou.ac.kr> from "Seong-kyu Ko" at Aug 22, 2000 01:22:29 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000822013411.88448206@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Seong-kyu Ko writes:
> First, I compile the binutils for powerpc cpu.
> Second, I build cross compiler with gcc.
> Third, I compile glibc for powerpc with cross compiler that I made.
> Last, I re-build cross compiler include glibc for library.

OK, sounds good.

> but I compile shell with shared labrary, it use ld.so.1 and libc.so.6
> The problem is ld.so.1 can't found libc.so.6
> The error message is this :
> 'error in loading shared libraries: libc.so.6: cannot open shared object
> file: No such file or directory'

In order to find libc.so.6 on the host, I found that I needed to edit
$prefix/powerpc-linux/lib/libc.so to use an absolute path to refer to
$prefix/powerpc-linux/lib/libc.so.6.  For some reason, gcc wouldn't find it
otherwise, even when I specified --rpath.

Next, to ensure that the dynamic linker could find libc.so.6 in the right
place on the target, I edited $prefix/lib/gcc-lib/powerpc-linux/2.95.2/specs
to add this right after -dynamic-linker:
    --rpath /lib --rpath-link /opt/gcc-2.95.2/powerpc-linux/lib

Good luck,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
