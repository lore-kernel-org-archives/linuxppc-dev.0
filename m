Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: softirq context question
Date: Mon, 8 Dec 2003 11:48:04 +0100
Message-ID: <000501c3bd78$c2c8f1a0$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have impl. NAPI for 8xx/enet.c. I choose to handle
TX IRQs in the poll() function as well. NAPI runs the packet
processing in softirq context.

All is working well, but I am a bit unsure about the locking rules
w.r.t softirq and scc_enet_start_xmit().

What is the difference between softirq context and hard irq context?
Can softirqs suspend scc_enet_start_xmit() or vice versa?

I have been running lots of flood ping tests without any locking at all
in scc_enet_start_xmit() and it works very well. This is no
comprehensive test and I have probably overlooked something.

  Regards
        Joakim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
