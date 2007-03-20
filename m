Return-Path: <gregoire.banderet@ge.com>
Received: from ext-ch1gw-6.online-age.net (ext-ch1gw-6.online-age.net
	[64.37.194.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A3665DDF31
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 19:31:36 +1100 (EST)
Received: from int-ch1gw-2.online-age.net (int-ch1gw-2 [3.159.232.66])
	by ext-ch1gw-6.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id l2K8HhAR001673
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Mar 2007 04:17:43 -0400
Received: from cinmlef09.e2k.ad.ge.com (int-ch1gw-2 [3.159.232.66])
	by int-ch1gw-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id l2K8HgV3018987 for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 04:17:42 -0400 (EDT)
Message-ID: <45FF989E.4090106@ge.com>
Date: Tue, 20 Mar 2007 09:17:34 +0100
From: Gregoire Banderet <Gregoire.Banderet@ge.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 2.6.21-rc4 fails to start USB HCD NEC 720101 with MPC8349EMDS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have an MPC8349EMDS board with an 2.6.21-rc4 kernel and u-boot 1.2.0.
I use the dts file from the kernel sources.

I've plugged a PCI board with a NEC 720101 
(http://www.necel.com/usb/en/product/upd720101.html).
This chip is a USB Host Controller with 1 EHCI if and 2 OHCI if.

It looks like the kernel sees the USB if, but it fails to start it:

ehci_hcd 0000:00:11.2: EHCI Host Controller
ehci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:11.2: reset hcs_params 0xffffffff dbg=15 ind cc=15 
pcc=15 ports=15
ehci_hcd 0000:00:11.2: reset portroute 15 15 15 15 15 15 15 15 15 15 15 
15 15 15 15
ehci_hcd 0000:00:11.2: reset hcc_params ffffffff caching frame 
256/512/1024 park 64 bit addr
ehci_hcd 0000:00:11.2: park 0
ehci_hcd 0000:00:11.2: bogus port configuration: cc=15 x pcc=15 < ports=15
ehci_hcd 0000:00:11.2: MWI active
ehci_hcd 0000:00:11.2: ...powerdown ports...
ehci_hcd 0000:00:11.2: supports USB remote wakeup
ehci_hcd 0000:00:11.2: irq 24, io mem 0xa0002000
ehci_hcd 0000:00:11.2: reset command ffffffff park=3 ithresh=63 LReset 
IAAD Async Periodic period=?? R
ehci_hcd 0000:00:11.2: startup error -19
ehci_hcd 0000:00:11.2: USB bus 2 deregistered
ehci_hcd 0000:00:11.2: init 0000:00:11.2 fail, -19
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:11.0: OHCI Host Controller
ohci_hcd 0000:00:11.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:11.0: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:11.0: USB HC takeover failed!  (BIOS/SMM bug)
ohci_hcd 0000:00:11.0: can't setup
ohci_hcd 0000:00:11.0: USB bus 2 deregistered
ohci_hcd 0000:00:11.0: init 0000:00:11.0 fail, -16
ohci_hcd: probe of 0000:00:11.0 failed with error -16
ohci_hcd 0000:00:11.1: OHCI Host Controller
ohci_hcd 0000:00:11.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:11.1: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:11.1: USB HC takeover failed!  (BIOS/SMM bug)
ohci_hcd 0000:00:11.1: can't setup
ohci_hcd 0000:00:11.1: USB bus 2 deregistered
ohci_hcd 0000:00:11.1: init 0000:00:11.1 fail, -16
ohci_hcd: probe of 0000:00:11.1 failed with error -16

Could someone help me to understand these messages?

-- 
Greg
