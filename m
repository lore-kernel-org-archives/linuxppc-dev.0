Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <govindan@india.tejasnetworks.com>
From: "Govindan" <govindan@india.tejasnetworks.com>
To: <svacca@valcom.com>,
	"LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	<govindan@tejasnetworks.com>
Subject: RE: Execute Reset via CheckStop approach
Date: Wed, 24 Jul 2002 10:49:39 +0530
Message-ID: <NEBBINFJMPEFJBMDGBGMAEOGFAAA.govindan@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <01C2322D.B3A24AF0.svacca@valcom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is something we found working:
-Govindan

#include <asm/8xx_immap.h>
#include <asm/mpc8xx.h>

#define IMAP_ADDR         ((uint)0xff000000)        /* Internal memory map
address for our board. */
#define PLPRCR_CSR      0x00000080      /* CheskStop Reset value */
int csreset (void)
{
      unsigned int msr,addr;

      ((volatile immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= PLPRCR_CSR;
      /* Interrupts and MMU off */
      asm("mtspr 81,0");
      asm("mfmsr %0": "=r"(msr));
      msr &= ~0x1030;
      asm ("mtmsr %0" : /* no output */ : "r" (msr));

      addr = 0x10000000;  // This should be a non-accessible memory
location.
      ((void (*)(void ))addr)();
        return 0;
}

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Steven
Vacca
Sent: Tuesday, July 23, 2002 7:16 PM
To: LinuxEmbeddedMailList (E-mail); govindan@tejasnetworks.com
Subject: Execute Reset via CheckStop approach



I would like to execute an Internal Hard Reset on an MPC860T
bd. using the Checkstop Reset approach.

Does anyone have some code that I could utilize to implement
this?

Thanks,

ShutEye Thinkin
Valcom, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
