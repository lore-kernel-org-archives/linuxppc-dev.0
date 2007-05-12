Return-Path: <edjubenville@adelphia.net>
Received: from mta14.adelphia.net (mta14.mail.adelphia.net [68.168.78.137])
	by ozlabs.org (Postfix) with ESMTP id 9E32CDDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 May 2007 00:13:24 +1000 (EST)
Received: from EJ1 ([75.85.34.145]) by mta11.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with SMTP
	id <20070512134108.BWVM16517.mta11.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Sat, 12 May 2007 09:41:08 -0400
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: "Linuxppc-Embedded" <linuxppc-embedded@ozlabs.org>
Subject: DHCP lease renewal after boot
Date: Sat, 12 May 2007 06:41:00 -0700
Message-ID: <GPECLCIGPLHEOMGPMCPAEEPCEKAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I posted a similar question in the u-boot list, but this list seems more
appropriate...

When I configure u-boot to get an IP address using DHCP, and pass that IP
through the kernel command line, doesn't the kernel need to know that it was
obtained from DHCP, so that it can maintain the lease on the IP address?  Is
it allowable for the kernel to treat the command line IP address as a static
IP, and ignore the obligations of DHCP lease renewal?

I found the following in Documentation/kernel-parameters.txt.  The last
sentence suggests that it is OK for the kernel to abandon responsibility of
DHCP lease renewal.  This seems to violate the DHCP protocol, RFC 2131
"4.4.5 Reacquisition and expiration".

 "DHCP support
  CONFIG_IP_PNP_DHCP
    If you want your Linux box to mount its whole root file system (the
    one containing the directory /) from some other computer over the
    net via NFS and you want the IP address of your computer to be
    discovered automatically at boot time using the DHCP protocol (a
    special protocol designed for doing this job), say Y here. In case
    the boot ROM of your network card was designed for booting Linux and
    does DHCP itself, providing all necessary information on the kernel
    command line, you can say N here."

RFC 2131 describes a DHCPINFORM message that clients can use to announce
their static IP addresses to a DHCP server.  Therefore, it matters whether
the IP address u-boot passes to the kernel is dynamic or static, because it
implies different behaviors in the kernel after boot.

How do I tell the kernel whether its command line IP address is static or
dynamic?

I'm using u-boot 1.1.4 with kernel 2.4.25 from ELDK 3.1.1

Ed Jubenville
