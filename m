Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 65813DDE00
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 12:29:56 +1100 (EST)
Date: Wed, 3 Dec 2008 20:29:53 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linux-usb@vger.kernel.org
Subject: USB reset errors in 2.6.28*
Message-ID: <20081203202953.1f9f3065@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a repost of a message sent to linuxppc-dev. It was recommended
a send it here.

The warp is a PPC based telephony appliance. You can get details from
the Pika website:
http://www.pikatechnologies.com/english/View.asp?x=608

Cheers,
   Sean MacLennan

Anybody else seeing USB problems in the 2.6.28 kernels? The warp has a
USB 1.1 port off the PPC 440EP processor. 

In 2.6.26 we had some problems with certain USB keys, but 2.6.27 fixed
it. However, the 2.6.28 stream broke it again before rc1. We get this
when you try to use a usb key:

sd 0:0:0:0: [sda] 990865 512-byte hardware sectors: (507 MB/483 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
sd 0:0:0:0: timing out command, waited 60s

It then seems to work, but I see corruption on the usb key. I haven't
looked into it too much since we aren't switching to 2.6.28 anytime
soon (it breaks our Secure Digital card driver).
