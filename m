Return-Path: <matthias.fuchs@esd.eu>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 80625B6EEC
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2012 01:14:06 +1100 (EST)
Message-ID: <4F1581E2.9030400@esd.eu>
Date: Tue, 17 Jan 2012 15:12:50 +0100
From: Matthias Fuchs <matthias.fuchs@esd.eu>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problem with full speed devices on PowerPC MPC5121 host port
References: <Pine.LNX.4.44L0.1201061258040.1326-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1201061258040.1326-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06.01.2012 19:03, Alan Stern wrote:
> On Fri, 6 Jan 2012, Matthias Fuchs wrote:
> 
>> For my eyes it does not really look like a general USB issue.
>> It looks like a problem with the Freescale EHCI implementation that is
>> influenced by high interrupt or internal bus load caused by the flood ping.
> 
> Indeed, it might be a problem with the built-in Transaction Translator.  
> That would explain why it affect full-speed devices.
> 
> However, I would expect the resetting the controller hardware (which 
> happens when you reload the ehci-fsl driver) would fix any such issues.  
> It's hard to imagine how a problem could survive a reset like that.

I did the tests again. When the error occured I reloaded the ehci-hcd driver and reconnected the device. It ends up with some kernel messages 
that come up time after time:

usb 1-1: new full-speed USB device number 2 using fsl-ehci
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full-speed USB device number 3 using fsl-ehci
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full-speed USB device number 4 using fsl-ehci
usb 1-1: device not accepting address 4, error -110
usb 1-1: new full-speed USB device number 5 using fsl-ehci
usb 1-1: device not accepting address 5, error -110
hub 1-0:1.0: unable to enumerate USB device on port 1

A recommondation from freescale was to check the TXFILLTUNING register settings ("Initialization of this registers can produce problem if full-speed device is used").

So I tried various values in the TXFILLTUNING register (I added this
code to ehci_reset()). Finally I disabled USB streaming mode in the USBMODE register (set bit USBMODE_SDIS - btw., it should be defined as "1 << 4" in ehci_def.h at least for the MPC5121).

All this does not fix the problem or even have an impact.

This is my stripped down version of the test:

on the MPC5121 unit I do nothing but:

$~ stty -F /dev/ttyUSB0 -echo -crtscts -cstopb
$~ stty -F /dev/ttyUSB0 115200
$~ while true; do \
        read LINE < /dev/ttyUSB0 \
        echo $LINE > /dev/ttyUSB0 \
done

The other side looks like this:

$~ while true; do \
	echo "_THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG 1234567890#" > /dev/ttyS0 \
done

and also I start a flood ping against the MPC5121 unit (.. to speed things up).

Can anybody with a MPC5121 board try to reproduce this?

Matthias
