Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: Init hangs
Date: Thu, 5 Aug 2004 11:54:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408051154.54426.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

my kernel hangs by initializing the system. My target is mpc8270-based. I use ELDK 3.0 and mount my root-fs over nfs.
Denx-kernel 2.4.25.


I added some printk's in the function "static int init(void * unused)" of  linux/init/main.c to see what happens.

#############################################################

	.
	.
	.
	(void) dup(0);
	(void) dup(0);

	/*
	 * We try each of these until one succeeds.
	 *
	 * The Bourne shell can be used instead of init if we are
	 * trying to recover a really broken machine.
	 */
	if (execute_command)
		run_init_process(execute_command);
	printk("before /sbin/init\n");
	run_init_process("/sbin/init");
	printk("before /etc/init\n");
	run_init_process("/etc/init");
	printk("before  /bin/init\n");
	run_init_process("/bin/init");
	printk("before  /bin/sh\n");
	run_init_process("/bin/sh");

##################################

the last lines of my boot messages
#######################################
IP-Config: Complete:
      device=eth0, addr=192.168.55.3, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.55.3, domain=, nis-domain=(none),
     bootserver=192.168.55.1, rootserver=192.168.55.1, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.55.1
Looking up port of RPC 100005/1 on 192.168.55.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 72k init
before /sbin/init

##############################################

It seems like it hangs in "run_init_process("/sbin/init");" or the /sbin/init - file does not work.
Sometimes the message "INIT: version 2.84 booting" is showed. And after printing this message it hangs, too.
But the most times it looks like above.

Any ideas?
Thanks in advance

Marco



---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:      +49 (0)9929/301112

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
