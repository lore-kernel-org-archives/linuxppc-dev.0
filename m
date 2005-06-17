Return-Path: <j.lu@tiesse.com>
Received: from eponet.it (gianonet.org [193.76.202.5])
	by ozlabs.org (Postfix) with ESMTP id 421FF67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Jun 2005 02:59:13 +1000 (EST)
From: "lu" <j.lu@tiesse.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 17 Jun 2005 16:15:29 +0200
Message-ID: <000001c57347$04a45d00$07070a0a@luj>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: problems on isp1362 driver
Reply-To: j.lu@tiesse.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

We are using Philips ISP1362 usb controller on our ppc-embedded system. We
have ported the phlips's driver, PHCI, to ppc. The Philips linux driver is
that of  2002.

Following are problems tha we've found in our  test:

1) ATL Interrupt doesn't work correctly. We have to use
ATL_THRESHOLD_TIMEOUT, that has the minimun resolution 1 msec, to bypass it.

2) The latency from PTD completion. From a usb frame analyzer we have seen
that the controller has gaps between every 4 64-bytes frames for 265 bytes
PTD configured in bulk transmission. The limit of 265 byte for PTD is due to
the end-point number.

3) The isochronous mode doesn' t work. That we've seen was we were loop on
frame number, so the machine went to hang!

>From the list I've seen that Wolfgang Denk  has worked for that driver and
test is for a lot of devices. I'd like to know from Wolfgang which driver is
used? Is the driver that you are using is open source? Where can we get it?
Thanks in advance!
Jianliang Lu
