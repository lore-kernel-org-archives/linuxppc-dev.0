Message-ID: <36DEDAED.F8384894@jlc.net>
Date: Thu, 04 Mar 1999 14:11:42 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Embedded 8xx libraries
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




OK....Finally.  I promised these a long time ago and now they are
on the linuxppc.cs.nmt.edu server in the embedded directory.
The file libc-1.99-8xx-tar.gz contains the files with symbolic links
for everything found in the source RPM (I think :-).  I didn't build this as
an RPM because I think it is easier to choose the pieces you need and
install on an embedded system.

These are built from Gary's glibc-0.961212-1o.src.rpm using
egcs-1.0.2 and the -mcpu=860 flag.

In addition to having the software floating point, I "fixed" an assumption
about the cache line size.  The 8xx uses a 16 byte cache line while the
other PPC cores seems to all use 32 bytes.  This caused problems
flushing the copy back cache during dynamic library loading.  You can
enable the copy back cache initialization (in head.S in the kernel) when
you use these libraries.

Make sure you also use the -mcpu=860 (or -msoft-float) when compiling
and linking your programs since there are different compiler run-time
support functions that must also be linked into the program.

Once we all catch up to glibc2 I will do this again.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
