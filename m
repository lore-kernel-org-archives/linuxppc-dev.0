Message-ID: <39898ACB.E3CD752D@apus.co.at>
Date: Thu, 03 Aug 2000 17:07:55 +0200
From: Rene Pachernegg <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: sys_open fails with shared libs
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

We ported  linux (kernel, sysvinit, getty, login, sash ...) to our ppc
740 based system, which worked fine using static linked libs.
We are trying now  to support dynamic linking, which causes login to
fail.

I was tracking down the problem to the following:
static:    sys_open in the kernel gets correct filenames (e.g.:
/etc/passwd from getpwnam in libc)
dynamic:    sys_open gets senseless names and cant open the needed files
(--> login fails without passwd) whenever it is called from a libc
function. Opening files from elsewhere is working fine.

It seems to be a kind of adressing problem so I controlled the adresses
of the filename parameter in sys_open, which is always FFExxxxx (don't
know if that may be an important hint) whenever its called from the
shared libs.

Everything else works with the shared libs. They are properly loaded (as
it seems) and the programs work fine. Calls to library functions work
to. It's seems to be just the system call open, which does not work from
the shared libs.

For cross compiling we use:
    bin-utils 2.9.5.0.22
    gcc 2.95.2
    glibc 2.1.2

Any suggestions?
Thanks,
    Ren


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
