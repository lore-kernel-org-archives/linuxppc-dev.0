Message-ID: <83E3831A88E65844B01DB1A73FB66F93140801@CSDNT99.cdcgy.com>
From: "Dang, James" <James.Dang@gdcanada.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux console on virtual Uart?
Date: Mon, 3 Mar 2003 16:58:53 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I'm porting Denx linux 2.4.4 to my company MPC8260 board. The board doesn't
have the real UART to be configured as ttyS0. It has a virtual UART (a
memory location where characters are read/written from/to. Another processor
will take care of UART translation.)

I haved modified uart.c to provide basic serial i/o functions using the
virtual uart. When running with NFS root filesystem, I got this:

---------------------------Message------------------------------------------
modprobe: modprobe: Can't locate module char-major-4
INIT: version 2.78 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Mounting proc filesystem:                                  [  OK  ]
Configuring kernel parameters:                             [  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access
method.
Setting clock : Wed Dec 31 19:00:20 EST 1969               [  OK  ]
Activating swap partitions:                                [  OK  ]
Setting hostname bdevppc01:                                [  OK  ]
Finding module dependencies:                               [  OK  ]
Checking filesystems
                                                           [  OK  ]
Mounting local filesystems:                                [  OK  ]
Enabling swap space:                                       [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting system logger:                                    [  OK  ]
Starting kernel logger:                                    [  OK  ]
Starting xinetd:                                           [  OK  ]

bdevppc01 login: root
Last login: Wed Dec 31 19:02:17 on console

---------------------------Message------------------------------------------

There is no shell prompt??????

Using telnet, I can look at ps:
---------------------------Message------------------------------------------
root       161     1  0 19:01 ttyS0    00:00:00 login -- root
root       162   155  0 19:01 ?        00:00:00 in.telnetd: 172.30.254.69
root       163   162  1 19:01 ttyp0    00:00:00 login -- root
root       164   163  2 19:01 ttyp0    00:00:01 -bash
root       189   161 89 19:02 ttyS0    00:00:27 -bash
---------------------------Message------------------------------------------

When running with ramdisk, I got this:
---------------------------Message------------------------------------------
bash# ls
bin         dev         etc         lib         linuxrc     lost+found
bash# asdf
init: asdf: command not found
bash#
---------------------------Message------------------------------------------
Why "init:" is printed out in "init: asdf: command not found"?. Probably
some variables didn't get initialized properly?

Does anyone know where is the problem?

thanks in advance
james


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
