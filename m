Message-ID: <005d01c28eff$86c07640$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: a small patch to 8260_io/uart.c
Date: Mon, 18 Nov 2002 20:39:24 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

   Have you ever seen the strange output when the linux almost booted:

VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 52k i?
tty_io.c: process 1 (swapper) used obsolete /dev/cua/1 - update software to use /dev/ttyS1
tty_io.c: process 1 (init) used obsolete /dev/cua/1 - update software to use /dev/ttyS1

   Something missed at the end of "52k init\n". I found at last that's because the uart
driver needs to reset the serial speed in function change_speed(). It first save the enable/
disable info, and then change the smcmr, and then enable it if it was enabled before.
The problem is it will stop the SMC first if the SMC was enabled before. Thus, characters
missed. Ok, you don't care, just skip this mail:)

   I solved the problem like that:
prev_mode = smcp->smc_smcmr & (SMCMR_REN | SMCMR_TEN);
smcp->smc_smcmr = smcr_mk_clen(bits) | cval | SMCMR_SM_UART | prev_mode;

  the original code is like that(around line919):
prev_mode = smcp->smc_smcmr;
smcp->smc_smcmr = smcr_mk_clen(bits) | cval |  SMCMR_SM_UART;
smcp->smc_smcmr |= (prev_mode & (SMCMR_REN | SMCMR_TEN));

  It works for me, maybe you have other way.

Thanks,
Shenrong

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
