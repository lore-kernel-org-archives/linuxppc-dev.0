To: linuxppc-dev@lists.linuxppc.org
Cc: Dan Malek <dan@embeddededge.com>
Subject: "slow" ports on MPC8255 ?
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Tue, 17 Jun 2003 22:47:03 +0200
Message-Id: <20030617204708.E8A31C5FD7@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

has anybody of you experienced problems with accesses  to  port  data
registers on a MPC8255 yet?

The environment:

- CPU: MPC8255 Rev 14, Mask B.1 4K25A
- happens independend of CPU and CPM clock
  (tried 300/200 Mhz and 166/133 MHz)
- happens in U-Boot and in Linux

The problem:

- writing port A data register (as 32  bit  word)  and  then  looping
  reading  it back will show that it takes some time for the write to
  take effect, i. e. we can read the old  value  for  some  time  and
  then, bit for bit, the new value becomes visible.

Example code:

void foo (unsigned char data, int pos)
{
	volatile unsigned int *datp =
			&((immap_t *) CFG_IMMR)->im_ioport.iop_pdata;
	unsigned int reg, tmp;
	unsigned long cnt;
	unsigned long buf[256];

	cnt = 0;

	reg = *datp;
	buf[cnt] = reg;

	reg &= ~(0xFF << (pos ? 0 : 8));
	reg |=  (data << (pos ? 0 : 8));
	*datp = reg;
	buf[++cnt] = reg;

	__asm__ ("eieio;sync;isync");

	while ((tmp = *datp) != reg) {
		if (++cnt < 256)
			buf[cnt] = tmp;
	}
	printf ("## %ld: %08lX -> %08lX:", cnt, buf[0], buf[1]);
	for (tmp = 2; tmp <= cnt; ++tmp)
		printf ("%08lX ", buf[tmp]);
	printf ("##\n");
}

What I get is this:

## 7: FFDE039F -> FFDE0325:FFDE0305 FFDE0305 FFDE0305 FFDE0305 FFDE0305 FFDE0305 ##
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
## 6: FFDE0325 -> FFDE030D:FFDE0305 FFDE0305 FFDE0305 FFDE0305 FFDE0305 ##
## 7: FFDE030D -> FFDE0399:FFDE0309 FFDE0309 FFDE0309 FFDE0309 FFDE0389 FFDE0389 ##
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
## 7: FFDE0399 -> FFDE0349:FFDE0309 FFDE0309 FFDE0309 FFDE0309 FFDE0309 FFDE0309 ##
## 7: FFDE0341 -> FFDE031F:FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE030F ##
## 7: FFDE0301 -> FFDE0309:FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0301 ##
## 7: FFDE0309 -> FFDE0311:FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0301 ##
## 8: FFDE0311 -> FFDE03C1:FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0381 FFDE0381 FFDE0381 ##
## 8: FFDE03C1 -> FFDE0363:FFDE0341 FFDE0341 FFDE0341 FFDE0341 FFDE0341 FFDE0341 FFDE0361 ##
## 7: FFDE0363 -> FFDE0385:FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0381 FFDE0381 ##
## 7: FFDE0385 -> FFDE0361:FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0301 FFDE0321 ##
## 7: FFDE0361 -> FFDE0371:FFDE0361 FFDE0361 FFDE0361 FFDE0361 FFDE0361 FFDE0361 ##
## 6: FFDE0371 -> FFDE9F71:FFDE0371 FFDE0371 FFDE0371 FFDE0371 FFDE8371 ##
# 7: FFDE9F71 -> FFDE9F03:FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 ##
## 7: FFDE9F03 -> FFDE9F9F:FFDE9F03 FFDE9F03 FFDE9F03 FFDE9F03 FFDE9F83 FFDE9F83 ##
## 7: FFDE9F9F -> FFDE9F25:FFDE9F05 FFDE9F05 FFDE9F05 FFDE9F05 FFDE9F05 FFDE9F05 ##
## 6: FFDE9F25 -> FFDE9F0D:FFDE9F05 FFDE9F05 FFDE9F05 FFDE9F05 FFDE9F05 ##
## 7: FFDE9F0D -> FFDE9F99:FFDE9F09 FFDE9F09 FFDE9F09 FFDE9F09 FFDE9F89 FFDE9F89 ##
## 7: FFDE9F99 -> FFDE9F49:FFDE9F09 FFDE9F09 FFDE9F09 FFDE9F09 FFDE9F09 FFDE9F09 ##
## 7: FFDE9F41 -> FFDE9F1F:FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F05 ##
## 6: FFDE9F01 -> FFDE9F09:FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 ##
## 6: FFDE9F09 -> FFDE9F11:FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 ##
## 7: FFDE9F11 -> FFDE9FC1:FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F01 FFDE9F81

If you look at the first marked (^^^) line the problem becomes obvious:

Port A data register contains FFDE039F and I'm writing a FFDE0325 to it.
The low 8 bits change from 9F -> 05 -> 25.

The second marked line is even more interesting: Here the register is
changing 0D -> 09 -> 89 -> 99.


eieio, sync and isync don't seem to have any effect. Also,  I  cannot
think of any cache effect that works like this.

To me it looks as if setting the register was implemented in the  CPM
in  microcode,  and in a non-atomic way, and not synchronized against
accesses by the CPU.


Ummm... by the way: the same code runs perfectly  fine  on  identical
hardware with a MPC8260 CPU.


Any ideas?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
One difference between a man and a machine is that a machine is quiet
when well oiled.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
