Message-Id: <200209061149.g86BnwH05287@wnaw252.uab.ericsson.se>
Date: Fri, 06 Sep 2002 13:49:58 +0200
From: "Hans dot Feldt at uab.ericsson.se" <"Hans dot Feldt at uab.ericsson.se"@uab.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: immap_8260.h: volatile missing in immr definition
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been trying to get the watchdog timer to run in a 2.4.18 kernel
on our custom 750/8260 board. Finally I realised what was the problem
by disassembling with objdump. Due to the missing volatile declaration,
the dog kicking code

	immr->im_siu_conf.sc_swsr = 0x556c;
	immr->im_siu_conf.sc_swsr = 0xaa39;

gets optimised into this by gcc:
	immr->im_siu_conf.sc_swsr = 0xaa39;

which don't make the dog happy.

Sorry if this is an old issue, I searched for it and couldn't find
anything. The patches for 2.4.18 does not contain this fix.

I don't know how it works but could someone who feel responsible change
the original source please?

Change from: extern immap_t *immr:
to: extern volatile immap_t *immr;

The actual variable declaration in 8260_io/commproc.c should probably
be volatiled to.

The system now boots with a 1.8s watchdog timer!

Cheers,
Hans


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
