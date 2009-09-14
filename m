Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 91D38B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 23:07:49 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 4D0D6DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 23:07:49 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MnAzN-0001Je-7N
	for linuxppc-dev@ozlabs.org; Mon, 14 Sep 2009 05:49:01 -0700
Message-ID: <25435195.post@talk.nabble.com>
Date: Mon, 14 Sep 2009 05:49:01 -0700 (PDT)
From: spa_kk <krishnakumar@spacomp.com>
To: linuxppc-dev@ozlabs.org
Subject: MPC8323 USB Host
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,
 
This is regarding the MPC8323 in-built USB controller driver,
Environment:
LTIB: ltib-mpc832x_rdb-20070507
Linux: linux-2.6.20
In built usb driver is been ported from linux-2.6.30 to linux-2.6.20
(File: drivers/usb/host/fhci-hcd.c is been ported from
kernel.org/linux-2.6.30)
 
Problem description:
File: "drivers/usb/host/fhci-hcd.c "
In this file probe function:
of_fhci_probe(struct of_device *ofdev, const struct of_device_id *ofid)
is getting loaded successfully &  
FHCI Host Controller, interrupt and timer are getting registered
 
File:"drivers/usb/host/fhci-hub.c"
In this file function 
fhci_hub_status_data(struct usb_hcd *hcd, char *buf) 
is been polled continuosly, which is checking for the port change and port
status of the our virtual hub using
fhci->vroot_hub->port.wPortChange &
fhci->vroot_hub->port.wPortStatus
 
The value in this variable are not getting changed even after connecting &
disconnection the device. 
 
We have manual checked the USBRXP pin, this pin is 
HIGH => when device is connected
LOW => when device is not connected.
 
Kindly let us know how should we debug/proceed.
 
Thanks and regards,
Krishna kumar M.S & Arif
-- 
View this message in context: http://www.nabble.com/MPC8323-USB-Host-tp25435195p25435195.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
