Return-Path: <arvid.staub@mediornet.com>
Received: from mailbackup.inode.at (mailbackup.inode.at [213.229.60.24])
	by ozlabs.org (Postfix) with ESMTP id EDC38DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 17:21:14 +1100 (EST)
Received: from [62.99.145.10] (port=11023 helo=mx.inode.at)
	by mailbackup.inode.at with esmtp (Exim 4.62)
	(envelope-from <arvid.staub@mediornet.com>) id 1HJC0i-00009j-CJ
	for linuxppc-embedded@ozlabs.org; Mon, 19 Feb 2007 18:09:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: AW: Finding devices with dynamic IP addresses
Date: Mon, 19 Feb 2007 18:06:43 +0100
Message-ID: <8B59AE8CCFB44040B58FCBC1342ED3C420B01A@mnx.mediornet.lan>
From: "Arvid Staub" <Arvid.Staub@mediornet.com>
To: "Edward Jubenville" <edjubenville@adelphia.net>,
	"Linuxppc-Embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi!

>I need a way for any Windows PC on the subnet to locate the devices
>without prior knowledge of their IP address.  I'm hoping to find a
peer-to->peer solution that doesn't involve a third party (DNS) server.


IMO the most elegant way to do this is using zeroconf networking.
it uses multicast DNS and service announcement/browsers.

see http://developer.apple.com/networking/bonjour/index.html

apple's implementation is released under the apache license v2.

if you know your device's hostname, this is all you need.=20
after installing the mDNS client library on your dev machine it will be
able to resolve that hostname (eg. ping mydevice.local)

otherwise, you will have to set up a service announcement (like
_telnet._tcp) and browse for your device (the dns-sd utility does that).

We're using zeroconf networking on a Virtex2-Pro FPGA (70MHz PPC405) and
it works great. I really recommend it to you.

greetings,
arvid staub
