Date: Mon, 30 Jun 2003 16:32:08 +1200
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: problem with serial_putc in u-boot
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3EFFBD48.4090903@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What is the possible reason for the fault in function serial_putc (see below). The problem is that it pushing the single character *buf = c; but could not send it through and as result is never breaking the bottom loop - the flag tbdf->cbd_sc has value 0xA000 all the time.
I put below some debug output just in case.

I appreciate any help.

PS: The ADS860 board modification done to support MPC866ADS.

../cpu/mpc8xx/serial.c

void
serial_putc(const char c)
{
...
	/* Wait for last character to go.
	*/

	buf = (char *)tbdf->cbd_bufaddr;

	*buf = c;
	tbdf->cbd_datlen = 1;
	tbdf->cbd_sc |= BD_SC_READY;
	__asm__("eieio");

	while (tbdf->cbd_sc & BD_SC_READY) {
		WATCHDOG_RESET ();
		__asm__("eieio");
	}
}



(gdb) p *tbdf
$73 = {cbd_sc = 40960, cbd_datlen = 1, cbd_bufaddr = 4293928977}
(gdb) p tbdf
$74 = (volatile cbd_t *) 0xfff02808
(gdb) backtrace
#0  serial_putc (c=13 '\r') at serial.c:296
#1  0x02815314 in serial_putc (c=10 '\n') at serial.c:280
#2  0x028153c0 in serial_puts (s=0xfff02d50 "\n\nU-Boot 0.3.2 (Jun 30 2003 - 11:00:14)\n\n") at serial.c:608
#3  0x02809588 in puts (s=0xfff02d50 "\n\nU-Boot 0.3.2 (Jun 30 2003 - 11:00:14)\n\n") at console.c:213
#4  0x028095e0 in printf (fmt=0xd <Address 0xd out of bounds>) at console.c:232
#5  0x0280ef2c in display_options () at display_options.c:33
#6  0x028038ec in board_init_f (bootflag=1) at board.c:375
#7  0x028001c8 in in_flash () at /home/dmytro/Dev/PPCLinux/u-boot/cpu/mpc8xx/start.S:209


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
