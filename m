Message-Id: <200212180101.gBI11p816867@p2.parker.boston.ma.us>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: bug in early_uart_init()?  linuxppc_2_4_devel
Date: Tue, 17 Dec 2002 20:01:51 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think there's a bug in early_uart_init() from linuxppc_2_4_devel.
It sets up a structure and calls early_serial_setup() which crashes
because "req->line" is huge.

early_uart_init() does

  ...
  serial_req.line = rs_table[0].port;
  ...

and then calls early_serial_setup() in drivers/char/serial.c, which
uses "line" as an index into rs_table. I'm not sure how that's
supposed to work, since in my case port is 0xf40005f0 :-) As a hack I
changed it to

  ...
  serial_req.line = rs_table[0].magic;
  ...

since the magic # is zero (and seems to be often an index). And that
works, but it's a hack.  Seems like "port" will always be a rather
largish hex number.

What's up with ocp_uart?  Is there a document which describes what the
ocp code is trying to do?

This is a for a ibm 403GCX, so the following are defined

CONFIG_40x=y
CONFIG_4xx=y
CONFIG_403GCX=y

-brad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
