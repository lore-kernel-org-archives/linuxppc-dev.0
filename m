Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav14.bay1.hotmail.com [65.54.244.118])
	by ozlabs.org (Postfix) with ESMTP id 8735967A7F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 19:41:01 +1100 (EST)
Message-ID: <BAY1-DAV14832A4F3F8FB6B55FDCD78B6E0@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "LinuxPPC Support" <linuxppc-embedded@ozlabs.org>,
	"BusyBox Support" <busybox@mail.busybox.net>
Date: Fri, 18 Feb 2005 14:10:37 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: David Bruce <dbruce@ll.mit.edu>, Achim Machura <achim.machura@berghof.com>
Subject: telnet and ioremap probs seem to be solved
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

Just thought I'd let everyone know regarding the status of the problems I
was facing.

The first problem I was facing was telnetd getting stuck whenever a
significant amount of data transfer was happening between the target and a
remote host. It turned out that the problem was related to MTU size.

I now set the MTU size to 192 bytes and all seems to be fine now.

ifconfig eth0 192.168.144.222 netmask 255.255.255.0 mtu 192

This seems to be ok so far.

The second problem was about not being able to access ioremapped memory. As
some of you suggested on this forum, it turned out to be a problem with the
MMU not having been configured to access that memory region. In other words,
we set the appropriate ORx and BRx registers to map that memory range, and
then the ioremapped memory was accessible perfectly fine. So that's that.

Thanks to all of you guys for your invaluable assistance!

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
