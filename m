Date: Fri, 29 Oct 1999 11:09:04 -0500 (CDT)
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel Math Emulation vs. -msoft-float and -nfp
Message-ID: <Pine.BSF.4.10.9910291051050.3718-100000@congo.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I finally got NFS root mounting working for the PowerPC 403GCX board port
I'm playing with and figured out why /sbin/init wasn't getting very far
(shared libraries, of course). However, that's about as far as things get.

I suspect that things are dying at this point because I'm using standard
files from Linux/PPC 1999 and that really assumes a PPC machine based on
the 6xx or 7xx processors.

So, I'm guessing that printf or one of the other routines that uses
varargs is killing things. I even compiled a simple, static, hello program
to replace /sbin/init and it too died.

So, I'm a little fuzzy on the issues with sans-FPU CPUs. What I'd like* to
accomplish is the ability to run a PowerPC binary compiled on ANY
Linux/PPC machine to run on this board. I think* I need kernel math
emualtion to accomplish this.

Anyway it seems to me that with the sans-FPU CPUs, there are three issues:
use of the floating point registers for argument passing, use of float and
double data types, and the use of arithmetic operations on those data
types.

So, my understanding is that -msoft-float does two things. First, it
prevents varags routines from using the floating point registers for
parameter passing, correct? Second, all floating / double math operations
are handled in inline or library code in user space, right?

So, my understanding of kernel math emulation is that it allows me to do
away with -msoft-float and instead all FP operations are emulated in the
kernel, right?

So, it seems the trade-off is more code (redundant for each app if it's
inline, shared if it's in the library) in user-space or a little more code
in the kernel (shared by ANY application needing it), right?

So, where does passing '-nfp' during the binutils, gcc, and glibc build
fit into all this?

Any light you can shed would be most appreciated.

Thanks,

Grant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
