Message-ID: <3C85DE01.6000006@capflow.com>
Date: Wed, 06 Mar 2002 10:14:41 +0100
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: linux-2.4.18 & copy-back cache mode
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody

I tried to boot a FADS860T board with the 2.4.18 linux kernel, and
experienced problems with cache set in Copy-Back mode.

The kernel configuration help states that you can say 'Y' to Copy-Back
mode if 'you don't know what that is about', so that's what I did.

I then got a 'kernel access of bad area' just after the 'CPM UART driver
version 0.03' message.

I traced the problem to rs_8xx_init, and found out that a write to .data
was causing the crash.

After some more investigation I found that disabling Copy-Back mode
(thus enabling Write-Through mode) fixed the problem.

The problem seems to have been solved in the linuxppc repository, so the
purpose if this message is not to ask for help but rather to give help
to people who will experience the same problem (no doubt there will be
some, as the Copy-Back mode is advised by the kernel configurator).

Laurent Pinchart

PS: I posted a few patches based on the latest linuxppc tree (to fix
some compilation warnings and a problem with xmon) about one week ago. I
got no feedback. Have they got through to the list ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
