Return-Path: <oakad@yahoo.com>
Received: from web37605.mail.mud.yahoo.com (web37605.mail.mud.yahoo.com
	[209.191.87.88]) by ozlabs.org (Postfix) with SMTP id 3A938B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Jan 2011 17:22:06 +1100 (EST)
Message-ID: <529099.8266.qm@web37605.mail.mud.yahoo.com>
Date: Sun, 9 Jan 2011 22:22:04 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: gianfar: incorrect TCP checksum when timestamps are enabled
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings.=0A=0AI'm working on MPC8548 based board (I started with 2.6.37-r=
c7, now upgraded=0Ato post release 2.6.37 git head).=0A=0AIt so appears, th=
at when tcp timestamps are enabled (default setting)=0ATCP checksums of out=
going SYN packets are calculated incorrectly. This=0Acauses remote machines=
 to reject such packets, effectively preventing any=0Auseful network use. T=
he problem is reproducible every time.=0A=0AOther protocols appear to work =
reliably (UDP/DHCP do work).=0A=0AIf tcp timestamps are disabled, checksums=
 are calculated correctly.=0A=0ANetdev guys tend to think that the problem =
is with hardware checksum=0Aoffloading, the theory I'm going to test now.=
=0A=0A=0A=0A      
