Message-ID: <03E3E0690542D211A1490000F80836F4877E30@zcard00f.ca.nortel.com>
From: "Jim Somerville" <somer@nortelnetworks.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Strange mapping at 0xffc00000
Date: Wed, 5 May 1999 16:48:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have started using the 2.2.5 kernel from 2.1.24 previously, and have found
a
new 4 Meg mapping up at 0xffc00000 that was not there before.  This mapping
is
setup in arch/ppc/kernel/pmac_setup.c, in routine pmac_setup_arch with the
following line:

        __ioremap(0xffc00000, 0x400000, pgprot_val(PAGE_READONLY));

It may be related to SMP support on some Macs (9600?) but the comments near
it
are vague.  I have not enabled SMP in the kernel via config, and this
mapping
does not look "config" optional.  I removed this line, rebuilt the kernel,
and
everything is fine, at least on the 7300.  This mapping interferes with a
large
emulator application that I maintain...I don't want junk returned when
dereferencing a bad pointer that happens to point up there.  Can anyone shed
some light, or provide a link to an explanation?  Thanks.

-Jim

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
