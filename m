Message-ID: <39C9F8A2.9F1707B0@mpifr-bonn.mpg.de>
Date: Thu, 21 Sep 2000 14:01:38 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
CC: Linux-IrDA <linux-irda@pasta.cs.UiT.No>
Subject: IrDA speed w/LinuxPPC: again [long, sorry]
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I still had no success in changing the speed of the IrDA if on my Apple
PowerBook 1999 with Linux2.2.17pre20-ben3. To understand better what goes on, I
enabled all debugging in the macserial and irda drivers, adding/expanding some
more messages to the latter ones.

I first successfully tried to change the speed of the serial device to 115.2
kBd:

kernel: rs_open ttyS1, count = 0
kernel: startup() (ttyS1, irq 16)
kernel: starting up ttyS1 (irq 16)...
kernel: ttyS01: powering up hardware
kernel: setting up ttys1 SCC...
kernel: set speed to 4800 bds, <6>8 bits, <6>1 stop, <6>timeout=3/100s, base:0
kernel: enabling IRQ on ttyS1 (irq 16)...
kernel: rs_interrupt: irq 16, zs_intreg 0x1
kernel: rs_interrupt: irq 16, zs_intreg 0x0
kernel: rs_open ttys1 successful...
kernel: set speed to 115200 bds, <6>8 bits, <6>1 stop, <6>timeout=3/100s, base:0
kernel: rs_close ttys1, count = 1
kernel: waiting end of Tx... (timeout:3000)
kernel: waiting end of Rx...
kernel: Shutting down serial port 1 (irq 16)....
kernel: ttyS01: shutting down hardware

Then, I started the IrDA stuff:

kernel: IrDA (tm) Protocols for Linux-2.2 (Dag Brattli)
[...]
kernel: IrCOMM protocol (Dag Brattli)
kernel: rs_open ttyS1, count = 0
kernel: startup() (ttyS1, irq 16)
kernel: starting up ttyS1 (irq 16)...
kernel: ttyS01: powering up hardware
kernel: setting up ttys1 SCC...
kernel: set speed to 115200 bds, <6>8 bits, <6>1 stop, <6>timeout=3/100s, base:0
kernel: enabling IRQ on ttyS1 (irq 16)...
kernel: rs_interrupt: irq 16, zs_intreg 0x1
kernel: rs_interrupt: irq 16, zs_intreg 0x0
kernel: rs_open ttys1 successful...
kernel: set speed to 9600 bds, <6>8 bits, <6>1 stop, <6>timeout=3/100s, base:0
kernel: hashbin_insert()
kernel: enqueue_first()
kernel: IrDA: Registered device irda0
irattach: 1.1 Tue Nov  9 15:30:55 1999 Dag Brattli
irattach: 1.1 Tue Nov  9 15:30:55 1999 Dag Brattli
test: irattach startup succeeded
irattach: executing: 'echo 1 > /proc/sys/net/irda/discovery'
kernel: rs_open ttyS1, count = 1
kernel: startup() (ttyS1, irq 16)
kernel:  -> already inited
kernel: rs_open ttys1 successful...
kernel: rs_close ttys1, count = 2
irattach: Starting device irda0
[...]

Obviously, IrDA sets the speed of the associated tty device back to 9.k kBd. I
tried to change the speed of /dev/ircomm0 with a stty command, which gave the
following result:

[...]
kernel: ircomm_tty_do_event: state=IRCOMM_TTY_IDLE,
event=IRCOMM_TTY_ATTACH_CABLE
kernel: ircomm_tty_state_idle: state=IRCOMM_TTY_IDLE,
event=IRCOMM_TTY_ATTACH_CABLE
kernel: ircomm_tty_next_state: next state=IRCOMM_TTY_SEARCH, service type=6
kernel: irlmp_discovery_confirm()
kernel: ircomm_tty_block_til_ready()
kernel: ircomm_tty_block_til_ready(), O_NONBLOCK requested!
kernel: ircomm_tty_ioctl(cmd 1076655123 w/arg 0x7ffff818)
kernel: ircomm_tty_ioctl: ioctl 1076655123 = 0x402c7413     ##
kernel: ircomm_tty_ioctl(cmd -2144570347 w/arg 0x7ffff8e8)
kernel: ircomm_tty_ioctl: ioctl -2144570347 = 0x802c7415     ##
kernel: ircomm_tty_wait_until_sent()
kernel: ircomm_tty_set_termios()
kernel: ircomm_tty_change_speed()
kernel: ircomm_tty_change_speed 115200 baud
kernel: ircomm_tty_change_speed request 115200 baud
kernel: ircomm_param_request()
kernel: ircomm_param_data_rate(), data rate = 115200
kernel: irda_insert_integer(), pi=0x10, pl=4, pi=115200
kernel: ircomm_param_request(), skb->len=6
kernel: ircomm_param_request()
kernel: irda_insert_integer(), pi=0x11, pl=1, pi=318767104
kernel: ircomm_param_request(), skb->len=9
kernel: ircomm_param_request()
kernel: ircomm_param_flow_control(), flow control = 0x00
kernel: irda_insert_integer(), pi=0x12, pl=1, pi=0
kernel: ircomm_param_request(), skb->len=12
kernel: ircomm_tty_do_softint()
kernel: ircomm_tty_ioctl(cmd 1076655123 w/arg 0x7ffff818)
kernel: ircomm_tty_ioctl: ioctl 1076655123 = 0x402c7413     ##

I think there are two interesting things to remark:

1. The new speed is inserted in some sort of "command queue". I think
   ircomm_tty_ioctl is called to set some, maybe these, parameters, but the cmd
   arg of this function seems to be invalid, as EACH call falls through to the
   "default" branch (lines maked with "##"; cmd printed). I could not track down
   where this ioctl is actually called, but cmd is definitely NO valid tty
   ioctl.

2. This may be a result of the ioctl above, but the macserial speed change is
   never called.

Any help or comment on this is really welcome!

Thanks in advance, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
