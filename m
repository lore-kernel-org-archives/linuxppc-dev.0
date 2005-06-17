Return-Path: <j.lu@tiesse.com>
Received: from tiesse.com (city-port.it [193.76.202.5])
	by ozlabs.org (Postfix) with ESMTP id 869C367A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Jun 2005 00:30:48 +1000 (EST)
Date: Fri, 17 Jun 2005 16:03:22 +0200
Message-Id: <200506171603.AA76415730@tiesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jianliang Lu" <j.lu@tiesse.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Problems on Philips ISP1362 Driver
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
We are using ISP1362 usb host controller in our PPC-linux embedded 
system and we have had following problems:

1) ATL Interrupt doesn't work correctly. We have to use 
ATL_THRESHOLD_TIMEOUT, that has the minimun resolution 1 msec, to 
bypass it.

2) The latency from PTD completion. From a usb frame analyzer we 
have seen that the controller has gaps between every 4 64-bytes 
frames for 265 bytes PTD configured in bulk transmission. The 
limit of 265 byte for PTD is due to the end-point number.

3) The isochronous mode doesn' t work. That we've seen was we were 
loop on frame number, so the machine went to hang!


The driver is ported from those of philips (last updated was 
2002), I don't know if there is any updated driver.
I've seen on the list that Wolfgang Denk has test it on many 
devices and works fine. I'd like to know from Wolfgang which 
driver did you use? Is the driver is open source?

Thanks in advance!
Jianliang Lu

                   
