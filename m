Return-Path: <matthias.fuchs@esd.eu>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 004A51007D6
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Jan 2012 23:09:06 +1100 (EST)
Message-ID: <4F06E132.5070905@esd.eu>
Date: Fri, 06 Jan 2012 12:55:30 +0100
From: Matthias Fuchs <matthias.fuchs@esd.eu>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: Problem with full speed devices on PowerPC MPC5121 host port
References: <4EF3191D.9040508@esd.eu> <20111222173900.GD28856@kroah.com>
In-Reply-To: <20111222173900.GD28856@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22.12.2011 18:39, Greg KH wrote:
> On Thu, Dec 22, 2011 at 12:48:45PM +0100, Matthias Fuchs wrote:
>> Hi,
>>
>> I ran into trouble when using the MPC5121 with full speed
>> USB devices. I've seen the issue with USB serial converters
>> based on FTDI and Prolific chips.
>>
>> After connecting the device they first work fine. But when
>> I stress the converter communications stalls. I can even force
>> this behavior when doing a flood ping against the device.
>> Then it only takes a few seconds until USB gets weird.
>>
>> After some time and several CTRL-C to stop the application
>> that uses the ttyUSBx port I get a kernel message:
>>
>> 	ftdi_sio ttyUSB0: error from flowcontrol urb
>>
>> The only thing that reanimates the USB port is doing a reboot.
> 
> Not removing and inserting the device again?  unloading the ftdi_sio
> driver and reloading it?
Right. First I used a monolithic kernel with ftdi_sio and ehci_hcd build
in. Now I did the test again with fsl_mph_dr_of, ehci_hcd, usbserial and
ftdi_sio loaded as modules. After the error occured, I
removed the device and unloaded the modules. After reloading them
USB is still weird.

usb 1-1: new full-speed USB device number 2 using fsl-ehci
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -110
usb 1-1: new full-speed USB device number 3 using fsl-ehci
usb 1-1: device descriptor read/64, error -110

> If you look at the data using usbmon, does anything look odd?
As long as everything works fine usbmon outputs data like this. It stops
a short time after I started the flood ping to the board.
df9c16c0 697164417 C Bi:1:002:1 0 2 = 0160
df9c16c0 697164436 S Bi:1:002:1 -115 512 <
df9c16c0 697165417 C Bi:1:002:1 0 2 = 0160
df9c16c0 697165441 S Bi:1:002:1 -115 512 <
df9c16c0 697166417 C Bi:1:002:1 0 2 = 0160
df9c16c0 697166435 S Bi:1:002:1 -115 512 <
df9c16c0 697167417 C Bi:1:002:1 0 9 = 01605f54 48452051 55
df9c16c0 697167450 S Bi:1:002:1 -115 512 <
df9c16c0 697168417 C Bi:1:002:1 0 14 = 01604943 4b204252 4f574e20 464f
df9c16c0 697168450 S Bi:1:002:1 -115 512 <
df9c16c0 697169420 C Bi:1:002:1 0 13 = 01605820 4a554d50 53204f56 45
df9c16c0 697169453 S Bi:1:002:1 -115 512 <
df9c16c0 697170418 C Bi:1:002:1 0 14 = 01605220 54484520 4c415a59 2044
df9c16c0 697170451 S Bi:1:002:1 -115 512 <
df9c16c0 697171417 C Bi:1:002:1 0 14 = 01604f47 20313233 34353637 3839
df9c16c0 697171450 S Bi:1:002:1 -115 512 <

Then I try to abort my application. This result in

df9c1340 712766944 S Co:1:002:0 s 40 02 0000 0000 0000 0
df9c1340 717776208 C Co:1:002:0 -2 0
df9c1340 717776503 S Co:1:002:0 s 40 01 0300 0000 0000 0
df9c1340 722786213 C Co:1:002:0 -2 8 >
df9c16c0 722796202 C Bi:1:002:1 -2 0

And finally I try to restart my application:

df9c12c0 791192447 S Co:1:002:0 s 40 00 0000 0000 0000 0
df9c12c0 796202240 C Co:1:002:0 -2 0
df9c12c0 796203289 S Co:1:002:0 s 40 02 0000 0000 0000 0
df9c12c0 801213213 C Co:1:002:0 -2 0
df9c16c0 801213518 S Bi:1:002:1 -115 512 <
df9c12c0 801213560 S Co:1:002:0 s 40 01 0303 0000 0000 0
df9c12c0 806223208 C Co:1:002:0 -2 0
df9c12c0 806223411 S Co:1:002:0 s 40 02 0000 0000 0000 0
df9c12c0 811233210 C Co:1:002:0 -2 0
df9c1440 821344904 S Co:1:002:0 s 40 02 0000 0000 0000 0
df9c1440 826354209 C Co:1:002:0 -2 8 >
df9c1440 826354515 S Co:1:002:0 s 40 01 0300 0000 0000 0
df9c1440 831364204 C Co:1:002:0 -2 0
df9c16c0 831374203 C Bi:1:002:1 -2 0

> And what kernel version are you using here?
Now I switched to 3.2.0 with only minimal changes for our hardware.
But (as expected) I get the same problems.

For my eyes it does not really look like a general USB issue.
It looks like a problem with the Freescale EHCI implementation that is
influenced by high interrupt or internal bus load caused by the flood ping.

I put linuxppc-dev on CC. Perhaps soneone in that community can double
check it on a Freescale evaluation board.

Matthias
