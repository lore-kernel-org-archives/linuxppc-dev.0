Message-ID: <20020524155815.98552.qmail@web21402.mail.yahoo.com>
Date: Fri, 24 May 2002 08:58:15 -0700 (PDT)
From: Venkatesh Rao <rpranesh@yahoo.com>
Subject: ZMII Code Panics on 440GP Ebony
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am using a Rev B board and when i compiled the
latest kernel (pulled yesterday after Matt's
Checkin)and booted my ebony board, i got a panic in
ZMII. I am including a portion of the bootup log.

I looked at the ibm_ocp_zmii code and found that it
panicked init_zmii() in the following code snippet. I
think it panicked while accessing the ioremapped
zmiip->fer.

Thanks
Venkatesh

Location Where it panicked
--------------------------
	if (mode == ZMII_AUTO) {
		if (zmiip->fer & (ZMII_MII0 | ZMII_MII1))
			fep->zmii_mode = MII;
		if (zmiip->fer & (ZMII_RMII0 | ZMII_RMII1))
			fep->zmii_mode = RMII;
		if (zmiip->fer & (ZMII_SMII0 | ZMII_SMII1))
			fep->zmii_mode = SMII;
	}


BootUP Log Snippet
------------------
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind
8192)
init_zmii: curr_zmii = 0
init_zmii: allocating dev
dev is c7ef5400
init_zmii: ocp_register
init_zmii, got dev c7ef5400
init_zmii: regs at d002b780, fep = c7fab960
Data machine check in kernel mode.
Oops: machine check, sig: 7
NIP: C0091C84 XER: 00000000 LR: C0091C6C SP: C0327ED0
REGS: c0327e10 TRAP: 0200    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0326000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C0327ED0 C0326000 0000002C 00001030
00000001 00000030 C0160000
GPR08: 00000842 00000000 00000000 C0327DF0 0000053F
00000000 00000000 FFF9E120
GPR16: 00000004 FFF837A9 00000024 00000000 47868C00
00010080 BFA62401 00000000
GPR24: 00000000 C0160000 D0006800 C0327ED8 00000004
D002B780 C7FAB800 C7FAB960
Call backtrace:
C0091C6C C008F624 C00A95B8 C00AACBC C013763C C0137DB0
C012A5DC
C012A628 C0001174 C0005BD0
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
