Subject: Level 7 interrupt
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Date: Fri, 4 Jan 2002 23:46:26 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A91E1@kolkrabbi.flaga.is>
From: =?Windows-1252?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am using linuxppc_2_4_devel.
I have been seeing ocational crash of the kernel during boot (I measured
around 1% crashes by putting /sbin/reboot in /etc/init.d/rcS).

After having spent some time debugging this I noticed that in
kernel/m8xx_setup.c there is registered an interrupt handler for the
tbint,
interrupt 15 (Level 7). In my desperation I removed this, since the
interrupt handler is not doing anyting (except printk-ing). Now the
board
has been booting for a while (673 times actually) and not a single
crash.
The old statistic predicts 6-8 crashes.

I had never noticed that this interrupt handler was beeing called, i.e.
I
have never seen the printk that is printed in the interrupt handler.

Is there any reason why enabling this interrupt might cause a crash of
the
kernel, especially if its interrupt handler is never called, i.e. the
interrupt is never received!?

The platform is custom board running MPC823E at 48MHz with 16Mb ram.

Thanks for all pointers,

K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
