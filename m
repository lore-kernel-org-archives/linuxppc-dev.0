Message-ID: <3D31F6B2.3010900@dslextreme.com>
Date: Sun, 14 Jul 2002 15:09:54 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: [RFC/Patch] ppc4xx_pic
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello;

While farting around with some 4xx drivers,  I came accross a few that
changed the level and polarity of their irq before calling request_irq().
 So I am thinking of adopting how openpic defines and gets irq level and
polarity information and use it to define  external irqs in the board.c
files.

Basicaly I check to see if a table exists and if so, update the
interrupt controller during ppc4xx_pic_init with the proper values.
 Since the on-chip devices are all ready setup by the bootrom or at
least we have been assuming this is the case ,  I am not going to worry
about them.

Since I plan on updating the ppc4xx_pic , I have also added the ability
to properly report the level of the interrupt to irq_desc[] so that
proc/intrrupts will correct.

what do you think?

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
