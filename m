Message-ID: <E0A487F3EEFFD111A3C5004033933F9ABBF6C3@postoffice.iotech.com>
From: Derrik Weeks <derrikW@iotech.com>
To: "'Sangmoon Kim'" <dogoil@etinsys.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: execve system call question
Date: Tue, 26 Feb 2002 09:34:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

This sounds like a problem I had a while back with the location of the IMMR
of on my processor.  What I discovered (via the archives of this mail list)
is the IMMR needs to be located in high memory above F0000000.  Check your
code to see if the memory map for your custom board has placed the IMMR at a
low memory address.

>From experience I know that if this is your issue, your kernel will crash
whether you're running NFS or a ram disk.  Once you move the IMMR to high
memory, you'll get to shell prompt with no problem.  I'm 75% sure you're
looking at the same situation as I was, but if not, I wish you luck in your
troubleshooting.

>From what I can tell by my limited time on this mail list, this issue has
snagged many people new to Linux.  It's apparently well known in lore that
the IMMR needs to be in high memory, it's just not particularly well
documented, although those details can be found with enough digging.

Hope this helps!
Derrik Weeks
Digital Hardware Architect
IOtech, Inc.

-----Original Message-----
From: Sangmoon Kim [mailto:dogoil@etinsys.com]
Sent: Tuesday, February 26, 2002 5:35 AM
To: linuxppc-embedded
Subject: execve system call question



Hi!
I'm debugging a custom MPC755 board
with linuxppc_devel from montavista rsync,
and /opt/hardhat/devkit/ppc/7xx/target for NFS root.
It booted and stoped after the message.

--------------------------------------------------------
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IP-Config: Complete:
      device=eth0, addr=203.239.17.200, mask=255.255.255.0,
gw=203.239.17.57,
     host=dogoil, domain=, nis-domain=(none),
     bootserver=203.239.17.57, rootserver=203.239.17.57, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 203.239.17.57
Looking up port of RPC 100005/1 on 203.239.17.57
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init
--------------------------------------------------------

I traced the code and the point of stopping is after calling
execve("/sbin/init", argv_init, envp_init)
in init/main.c

I was trying to trace more, but it was impossible
because of the complexity of the code.

Is there any method to debug this?
I'm debugging it for a month.

Please help me.

- Sangmoon Kim -


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
