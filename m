Message-ID: <3D81A8A2.70904@ellemedia.com>
Date: Fri, 13 Sep 2002 11:58:10 +0300
From: Apostolos Meliones <meliones@ellemedia.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Segmentation fault and 8260 vs 8264
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

We are working on two identical custom boards. The first one is powered by
MPC8260 (revision A.1, mask 1K22A), while in the second system MPC8260 is
replaced with MPC8264 (revision A.0, mask 2K25A). Both systems are running
Linux 2.4.7. MPC8264 is a new version of the MPC8260 PowerQuicc II
microprocessor. Actually, it is the same cpu with some ATM additions and
manufacturing technology at 0.25 microns. Quite unexpectedly, most of the
user space applications stored in our JFFS flashdisk or NFS filesystem
crash (yield a segmentation fault) when running on the 8264 board, while
working perfectly on the 8260 one.

The problem reveals from within arch/ppc/mm/fault.c. User mode accesses
cause a SIGSEGV signal from within the do_page_fault() function.

I would be grateful if someone of you guys could provide any help.

We feel that this problem might be relevant to a message posted to the list
by Ralph Blach, dated Apr 02, 2001. At that time, he asked the list about
what kind of errors are responsible for segmentation faults. Some days
later he reported himself that marking all user pages as user/read/write
in the kernel caused the segmentation faults at application layer.

What is your opinion?

Sincerely Yours

Apostol

----------------------------------------
Dr. Apostol Meliones
Ellemedia Technologies
223 Syngrou Ave., 17121, Athens, Greece
Tel: +30-10-9373095, Fax: +30-10-9370386


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
