Return-Path: <jblack547@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id F1D97DE197
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 09:41:14 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so70293ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 14:41:12 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 29 Jan 2009 15:41:10 -0700
Message-ID: <b77025b40901291441j7790f85ewd70ee81dc09ed55b@mail.gmail.com>
Subject: mpc8270 and fs_enet
From: James Black <jblack547@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've got an mpc8270 running the fs_enet v1.0 driver and we are having
problems with randomly corrupted tx buffer descriptor ready bits. The
CPM never clears the bit. This is a 2.6.19.2 kernel. We have the same
kernel with the 8260_io driver (kernel is from the denx ELDK4.2)
running on the mpc8250 that works perfect.

I've been through the clock tree in u-boot and the kernel with both
processors and they are configured corrected. I've checked all the
pins and they are configured correctly. I back ported some spin_lock
tx issues from 2.6.27.xx and still it is not working on the mpc8270.

These are the tests I am failing.

nmap -sS -v <target ip>

mpc8270 Target Output
~ # fs_enet: eth0 FS_ENET ERROR(s) 0xe
fs_enet: eth0 FS_ENET ERROR(s) 0xe
fs_enet: eth0 FS_ENET ERROR(s) 0xc
fs_enet: eth0 FS_ENET ERROR(s) 0x4
fs_enet: eth0 FS_ENET ERROR(s) 0x4
fs_enet: eth0 FS_ENET ERROR(s) 0xc
fs_enet: eth0 FS_ENET ERROR(s) 0xc
fs_enet: eth0 FS_ENET ERROR(s) 0xc
fs_enet: eth0 FS_ENET ERROR(s) 0xc
fs_enet: eth0 FS_ENET ERROR(s) 0x4
fs_enet: eth0 FS_ENET ERROR(s) 0x4

Host output-------------------------------------------------------------------------
[root@localhost linux]# nmap -sS -v 172.22.250.113
Starting Nmap 4.52 ( http://insecure.org ) at 2009-01-29 14:59 MST
Initiating Ping Scan at 14:59
Scanning 172.22.250.113 [2 ports]
Completed Ping Scan at 14:59, 0.00s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 14:59
Completed Parallel DNS resolution of 1 host. at 14:59, 0.27s elapsed
Initiating SYN Stealth Scan at 14:59
Scanning 172.22.250.113 [1714 ports]
Discovered open port 23/tcp on 172.22.250.113
Discovered open port 80/tcp on 172.22.250.113
Discovered open port 21/tcp on 172.22.250.113
<eventually times out>

telnet <target ip>
ftpput -u <user name> -p <password> <host ip> <big file> <big file>

The telnet session hangs. Below is a BDI dump of the buffer
descriptors for the tx side.
Notice the BDs with a leading 0xd such as the ones at address
0x0e6e2100 and 0x0efe21d0. I can go in and clear the ready bit by hand
with the BDI and everything starts working again without a reboot. The
BDs on the rx side look text book perfect.

0e6e2100 : dc0005ea 0df8709e 1c0005ea 0df5f89e  ......p.........
0e6e2110 : 5c0005ea 0e29e89e 5c0005ea 0e29609e  \....)..\....)`.
0e6e2120 : 1c000358 0e29389e 5c00002a 0fa293c2  ...X.)8.\..*....
0e6e2130 : 5c00005a 0c42c202 5c00005a 0c42c802  \..Z.B..\..Z.B..
0e6e2140 : 1c00005a 0c42c602 5c00002a 0fa292c2  ...Z.B..\..*....
0e6e2150 : 5c0005ea 0df8909e 1c0005ea 0df8c09e  \...............
0e6e2160 : 5c0005ea 0e29a09e 1c0005ea 0e29a89e  \....).......)..
0e6e2170 : 5c0005ea 0e29989e 5c0005ea 0e29189e  \....)..\....)..
0e6e2180 : 1c0005ea 0df8989e 5c0005ea 0e29789e  ........\....)x.
0e6e2190 : 1c0005ea 0df8189e 5c0005ea 0df8109e  ........\.......
0e6e21a0 : 1c0005ea 0d86c09e 1c0005ea 0d86c89e  ................
0e6e21b0 : 5c0005ea 0e29d89e 1c0005ea 0e29d09e  \....).......)..
0e6e21c0 : 5c0005ea 0e2bd89e 5c0005ea 0e2bd09e  \....+..\....+..
0e6e21d0 : dc0005ea 0e29289e 5c0005ea 0df8689e  .....)(.\.....h.
0e6e21e0 : 1c0005ea 0e29f09e 5c0005ea 0e29909e  .....)..\....)..
0e6e21f0 : dc0005ea 0df8609e 3c0005ea 0df6109e  ......`.<.......

Anyone have any experience about what could make such a difference
between the two processors?

-- 
Jim Black
Senior Software Engineer
Aztek Networks, Inc.
2477 55th Street, Suite 202
Boulder, CO 80301
www.azteknetworks.com
