Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B83B6DDFB1
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 04:23:51 +1000 (EST)
Message-ID: <470A7572.4010904@ru.mvista.com>
Date: Mon, 08 Oct 2007 22:22:42 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: jyoung5@us.ibm.com
Subject: Re: [PATCH 0/3] usb: ehci ppc device-tree-aware driver
References: <20070917125039.GA29525@ru.mvista.com>	<fd46qj$s6r$1@sea.gmane.org>
	<1191867353.5618.17.camel@laptop> <470A746E.4050804@ru.mvista.com>
In-Reply-To: <470A746E.4050804@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> Jerone Young wrote:
>> So the issue here with the Sequoia board is that if you load a kernel or
>> initrd from usb stick while under u-boot environment, when Linux boots
>> it will see the network adapter & even set an ip for it. But no matter
>> what it is unable to access any outside ip.
>>
>> The way we recreated this scenario was:
>>
>> - Have a USB stick with
>>     - partition 1 is fat partition with our kernel & initrd
>>     - partition 2 is ext3 with our root filesystem
>>
>> 1) Boot Sequoia board with USB stick plugged in. Go to u-boot prompt.
>> 2) start usb using "usb start"
>> 3) Load kernel off usb stick using "fatload" command in uboot
>>    * Optionally load initrd off of usb stick
>>    * Example:
>>       fatload usb 0:1 4000000 cuImage.sequoia
>>     
>> 4) stop usb using "usb stop"
>> 5) Then boot kernel using bootm
>>
>> Now from this point linux loads and will mount the filesystem on the usb
>> stick.  But if you want to use networking in anyway you have a problem.
>> You can start the telnet daemon and access from the board using
>> 127.0.0.1 address (loopback). Trying to access the telnet from an
>> outside ip is unsuccessful.
>>
>> Also, if you have it setup so that the root filesystem is on a nfs root,
>> the kernel is never able to get to the nfs root. Basically something is
>> really borked.
>>
>> I'm a little late getting back to this email :-0
>>
>> On Sat, 2007-09-22 at 23:00 +0000, Hollis Blanchard wrote:
>>> On Mon, 17 Sep 2007 16:50:39 +0400, Valentine Barshak wrote:
>>>
>>>> Some PowerPC systems have a built-in EHCI controller.
>>>> This is a device tree aware version of the EHCI controller driver.
>>>> Currently it's been tested on the PowerPC 440EPx Sequoia board.
>>>> Other platforms can be added later.
>>>> The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.
>>> We're having a strange issue on our Sequoia where the network stops
>>> functioning when USB is active. Jerone can supply more detail...
>>>
>>> Have you seen anything like that?
>>>
> Please try this patch:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-October/043435.html
> Thanks,
> Valentine.

Also please, don't forget to uncomment this line:
#	select IBM_NEW_EMAC_RGMII
It's commented out in the original patch since new EMAC support hasn't 
been merged yet.
Thanks,
Valentine.

>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
