Message-ID: <3846A74F.2110114C@agelectronics.co.uk>
Date: Thu, 02 Dec 1999 17:07:27 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Thermal Management
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been working on use of the thermal assist unit to control the
temperature of G3s.  A code fragment is below. This works to keep a
below-normal-spec chip at a junction temperature below the limit of 65C,
but is quite crude. In particular, I just made up the value of ICTC.
Does anyone have any suggestions for a good control stratgy for running
at constant temperature?

- Adrian Cox, AG Electronics

asmlinkage void do_THERM(struct pt_regs *regs)
{
 unsigned t2 = _get_THRM2();
 if (t2 & THRM1_TIN) {
  int threshold = (t2 & THRM1_THRES) >> 23;
  if (t2 & THRM1_TID) {
   printk("Below threshold temp %d\n", threshold);
   _set_THRM2(((threshold + 4) << 23) |  THRM1_V | THRM1_TIE);
   _set_ICTC(0);
  } else {
   printk("Above threshold temp %d\n", threshold);
   _set_THRM2(((threshold - 4) << 23) | THRM1_TID | THRM1_V |
THRM1_TIE);
   _set_ICTC(0x5);
   }
  _set_THRM3(0x00003f69);
   } else
   printk("Unexpected TAU trap at PC: %lx, SR: %lx, vector=%lx\n",
    regs->nip, regs->msr, regs->trap);
}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
