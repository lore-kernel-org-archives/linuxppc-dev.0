From: "Nicolas-Peter Pohland" <pohland@snom.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Doze / Low power Mode with MPC855T D3
Date: Thu, 19 Apr 2001 18:19:45 +0200
Message-ID: <HEEJLLLEHBIOHDGILMPNCEJJCGAA.pohland@snom.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I would like to put a MPC855T D3 on a custom board into doze mode when it is
not needed.
See code sample of arc/ppc/kernel/idle.c below.

It appears to be an easy task:

* TRST is connected to PORESET.
* SCCR bits CRQEN and PRQEN are 1.
* PLPRCR is 0x00900000 (MF = 10), i.e. TEXPS=0
* SIPEND = 0, i.e. no interrupts
* Then set TMIST=1 and LPM=1
* Then set POW and EE of the MSR
* Wait for dedrementer or interrupt to wake up the processor
* Take back the EE bit to ensure restore_flags() works

* I use _set_plprcr() to avoid the problem described in the errata of the
855T.

I put in code to count and to toggle ports on the MPC and it does not stop
running.
On the other hand if I take out the save_flags(), cli and restore_flags(), I
can
telnet on the board before power_save() is activated and then I can issue a
"ps aux"
by typing return twice on the telnet window and the decrementer also comes
to a halt.
It looks like every second interrupt is swallowed.

Am I missing something here ?

TIA,
Nicolas Pohland


--------------- Code sample ----------------------

void power_save(void)
{
  unsigned long msr, plprcr;

  save_flags(msr);
  __cli();
  if (!current->need_resched) {

      // go to doze mode:
      plprcr = ((volatile immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr;

    	_set_plprcr(plprcr | 0x00001100); // doze + timst

	/* set the POW bit in the MSR, and enable interrupts
	 * so we wake up sometime! */
	_nmask_and_or_msr(0, MSR_POW | MSR_EE);

	/* Disable interrupts again so restore_flags will work. */
	_nmask_and_or_msr(MSR_EE, 0);
    }
  }
  restore_flags(msr);
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
