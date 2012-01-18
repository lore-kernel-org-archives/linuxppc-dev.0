Return-Path: <matthias.fuchs@esd.eu>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 0817EB6EE6
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2012 00:44:11 +1100 (EST)
Message-ID: <4F16CC3C.6060005@esd.eu>
Date: Wed, 18 Jan 2012 14:42:20 +0100
From: Matthias Fuchs <matthias.fuchs@esd.eu>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: Problem with full speed devices on PowerPC MPC5121 host port
References: <Pine.LNX.4.44L0.1201061258040.1326-100000@iolanthe.rowland.org>
 <4F1581E2.9030400@esd.eu> <20120118120811.04f7c601@wker>
In-Reply-To: <20120118120811.04f7c601@wker>
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

Hi Anatolij,

On 18.01.2012 12:08, Anatolij Gustschin wrote:
> Hi Matthias,
> 
> On Tue, 17 Jan 2012 15:12:50 +0100
> Matthias Fuchs <matthias.fuchs@esd.eu> wrote:
> 
>> On 06.01.2012 19:03, Alan Stern wrote:
>>> On Fri, 6 Jan 2012, Matthias Fuchs wrote:
>>>
>>>> For my eyes it does not really look like a general USB issue.
>>>> It looks like a problem with the Freescale EHCI implementation that is
>>>> influenced by high interrupt or internal bus load caused by the flood ping.
>>>
>>> Indeed, it might be a problem with the built-in Transaction Translator.  
>>> That would explain why it affect full-speed devices.
>>>
>>> However, I would expect the resetting the controller hardware (which 
>>> happens when you reload the ehci-fsl driver) would fix any such issues.  
>>> It's hard to imagine how a problem could survive a reset like that.
>>
>> I did the tests again. When the error occured I reloaded the ehci-hcd driver and reconnected the device. It ends up with some kernel messages 
>> that come up time after time:
>>
>> usb 1-1: new full-speed USB device number 2 using fsl-ehci
>> usb 1-1: device descriptor read/64, error -110
>> usb 1-1: device descriptor read/64, error -110
>> usb 1-1: new full-speed USB device number 3 using fsl-ehci
>> usb 1-1: device descriptor read/64, error -110
>> usb 1-1: device descriptor read/64, error -110
>> usb 1-1: new full-speed USB device number 4 using fsl-ehci
>> usb 1-1: device not accepting address 4, error -110
>> usb 1-1: new full-speed USB device number 5 using fsl-ehci
>> usb 1-1: device not accepting address 5, error -110
>> hub 1-0:1.0: unable to enumerate USB device on port 1
>>
>> A recommondation from freescale was to check the TXFILLTUNING register settings ("Initialization of this registers can produce problem if full-speed device is used").
>>
>> So I tried various values in the TXFILLTUNING register (I added this
>> code to ehci_reset()). Finally I disabled USB streaming mode in the USBMODE register (set bit USBMODE_SDIS - btw., it should be defined as "1 << 4" in ehci_def.h at least for the MPC5121).
>>
>> All this does not fix the problem or even have an impact.
> 
> Can you try the attached patch? Does it have an impact?

Yes, in deed, it solved my problem :-) Finally I noticed that
the problem is listed in the CPU's errata document.

You could update the comment and commit message to "... when there is
heavy simultaneus PATA write or network activity".

I vote for getting this mainline.

Tested-by: Matthias Fuchs <matthias.fuchs@esd.ue>

Matthias
