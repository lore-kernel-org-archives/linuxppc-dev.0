Date: Wed, 16 Dec 1998 14:56:42 +0100
From: massin@col.bsf.alcatel.fr (Raphael Massin)
Message-Id: <199812161356.OAA01863@c5s144.clb>
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux with MPC860
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I am currently trying to use Linux on my MPC860 based board from an archive
working without any problem on another board based on MPC860.
The system clock speed is different on the two boards : 48MHz on my board
and 25MHz on the other.
The system is stable at 25MHz, at 48MHz i have a problem and the kernel crashes
after a few seconds. If i disconnect the ethernet, there is no more crash.

Nevertheless, before my crash, the target can be 'pinged' and the UART works
very well.

I made the following modifications to take into account the 48MHz system clock
frequency:
1) in arch/ppc/kernel/time.c (mbx_calibrate_decr)
	* the OSCM is used instead of the system clock to clock the decrementer
	 => no need to set bit 6 of SCCR
	* correct decrementer_count
2) in arch/ppc/boot/mbxtty.c (serial_init)
	* a 48MHz source clock is used instead of a 25MHz source clock
	=> modify accordingly BRGC1
3) in arch/ppc/8xx_io/commproc.c (mbx_cpm_setbrg)
	* idem => modify BRG_INT_CLK macro
4) in arch/ppc/8xx_io/enet.c
	* CLK2 and CLK3 are used for ethern emission/reception
	=> modify PAPAR, PADIR and SICR
	* port D, pin 12 is used to enable ethernet

These are my modifications, do you think i forgot something ?

	Raphael

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
