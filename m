Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5C009B6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 15:45:36 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 1620FDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 15:45:35 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MnQr7-0003Ni-5i
	for linuxppc-dev@ozlabs.org; Mon, 14 Sep 2009 22:45:33 -0700
Message-ID: <25448161.post@talk.nabble.com>
Date: Mon, 14 Sep 2009 22:45:33 -0700 (PDT)
From: spa_kk <krishnakumar@spacomp.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8323 USB Host
In-Reply-To: <20090914135900.GA18534@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <25435195.post@talk.nabble.com>
	<20090914135900.GA18534@oksana.dev.rtsoft.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,
Thanks for the suggestion,
pins & clock configuration seems to be ok,
Need a help in understanding which register of MPC8323 is been mapped to 
fhci->vroot_hub->port.wPortChange & 
fhci->vroot_hub->port.wPortStatus
As this are the variable which is been checked while polling

File: "drivers/usb/host/fhci.h"
struct virtual_root_hub {
    int dev_num;    /* USB address of the root hub */
    u32 feature;    /* indicates what feature has been set */
    struct usb_hub_status hub;
    struct usb_port_status port;
};

File: "drivers/usb/core/hub.h"
/*
 * Hub Status and Hub Change results
 * See USB 2.0 spec Table 11-19 and Table 11-20
 */
struct usb_port_status {
    __le16 wPortStatus;
    __le16 wPortChange;
} __attribute__ ((packed));

struct usb_hub_status {
    __le16 wHubStatus;
    __le16 wHubChange;
} __attribute__ ((packed));

Need support in understand where is virtual_root_hub.hub and
virtual_root_hub.port are initialized

Thanks and best regards,
Krishna


Anton Vorontsov-2 wrote:
> 
> Hello,
> 
> On Mon, Sep 14, 2009 at 05:49:01AM -0700, spa_kk wrote:
>> 
>> Hello,
> [...]
>> The value in this variable are not getting changed even after connecting
>> &
>> disconnection the device.
> 
> Could be pins multiplexing or USB clocks misconfiguration.
> 
>> We have manual checked the USBRXP pin, this pin is 
>> HIGH => when device is connected
>> LOW => when device is not connected.
>>  
>> Kindly let us know how should we debug/proceed.
> 
> You might find this useful:
> 
> http://lkml.org/lkml/2009/4/1/481
> 
> -- 
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/MPC8323-USB-Host-tp25435195p25448161.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
