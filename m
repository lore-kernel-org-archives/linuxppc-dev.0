Message-ID: <3AED4153.CC2902EC@cern.ch>
Date: Mon, 30 Apr 2001 12:41:23 +0200
From: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Probelem with _set_L2CR!!(linux on IBM Spruce)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
        Recently we try to put linuxppc_2_5 on IBM Spruce. But it always
hangs after the machine executes _set_L2CR(0x8000000) in
spruce_setup_arch
which spruce_setup_arch is called from setup_arch in setup.c.
When we try to trace the execution of _set_L2CR in misc.S, we found that
after doing instruction "mtmsr r7" at the very last step, it causes
decrement exception. and we can't use step instruction to go forward.
Instead it goes backward. We really can't figure out the reason causes
this.
The value of r7 is 0x1032.
        We have tried to put _set_L2CR(0) before _set_L2CR(0x80000000)
as the
comment of _set_L2CR recommended. However, there is no difference, the
same problem happens after calling _set_L2CR(0x80000000). The other
question
is that why use 0x80000000 to set L2CR? As we do the step by step trace,
the
original content of L2CR is replaced with 0x80000000. Don't we have to
set other configuration bits of L2CR?
        If anyone has any idea, could you please tell me?

Best regards,
Pei-Jie Hong

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
