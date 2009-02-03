Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D4FDDDDF7F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 16:23:47 +1100 (EST)
Message-ID: <4987D4DB.70402@trimble.com>
Date: Mon, 02 Feb 2009 23:23:39 -0600
From: Mike Timmons <mike_timmons@trimble.com>
MIME-Version: 1.0
To: mike_timmons@trimble.com
Subject: kernel 2.6.24 USB wlan firmware loading issue(s): rt73.bin...
References: <497E81DD.9020408@trimble.com>	
	<fa686aa40901262101r48771b8oc9fdbb6a0ede01e8@mail.gmail.com>	
	<497EAEAF.3010108@trimble.com>
	<9e4733910901270610qd40bbacm8f1f1bf0bcc63ae9@mail.gmail.com>
	<497F4437.5060909@trimble.com>
In-Reply-To: <497F4437.5060909@trimble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: mike_timmons@trimble.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I received great help last week in getting a USB wi fi device working. 
Thanks again, but can someone read below and advise me on kernel 2.6.24? 
The best out-of-the box solution for me was 2.6.27.8, for which I needed 
a Denx eldx toolchain in place of the toolchain I was using to compile 
2.6.24. The significance of all this is that I did get  USB wi fi 
working, but...

I'm not in a position to upgrade from 2.6.24 at this time. I need to get 
the USB wi wi (Linksys WUSB54GC) working under 2.6.24.

After success with linking firmware with the 2.6.27.8 kernel, 2.6.24 I 
keep hitting this error when loading from user space (I don't appear to 
have the, "link with kernel" option with 2.6.24)...

sh-2.05b# ifconfig wlan0 up
[  764.744354] phy0 -> rt2x00lib_request_firmware: Info - Loading 
firmware file 'rt73.bin'.

I have spent many, many hours following leads (and links) this group has 
directed me to. I've done the following...

1)placed rt73.bin in various locations (/lib/firmware, 
lib/firmware/'uname -a', and the location specified by my 
/etc/hotplug/firmware.agent)

None of this appears to make a difference.

2) I'm a bit confused by the hotplug dependancy, although I do have 
hotplug enabled. "hotplug" makes me think I should be configuring some 
script to load the firmware upon device insertion, but, "ifconfig wlan0 
up" appears to want to load the firmware anyway so I'm guessing if I 
just get rt73.bin in the right spot it should work.


Comparing my working 2.6.27.8 to 2.6.24 in the areas of "firmware: and 
the ralink rt2x00 drivers reveals MANY changes, no doubt for the better.

QUESTIONS:
1) Am I missing something VERY simple on this firmware loading topic 
that should make this work under 2.6.24, or am I bumping into the reason 
so much of this code has changed between 2.6.24 and 2.6.27.8?

2) am I correctly, "installing" the firmware just by placing rt73.bin in 
the correct location in my filesystem, or is there some other magic 
required before, "request_firmware()" will work?

Just when I thought I understood some of the kernel I hit a new topic: 
firmware loading! Any help much appreciated...

-Mike




Mike Timmons wrote:
> Thanks Jon. I'm still struggling with this rt73.bin issue. My 2.6.24 
> Kconfig presents options slightly different from what you describe 
> below. I've tried a few different settings and I placed the rt73.bin 
> you sent me under /lib/firmware.
>
> I'm still getting the "failure to load rt73.bin" error on "ifconfig 
> wlan0 up".
>
> my "generic" Kconfig options read as follows. I'm not sure if/what 
> option maps to, "include in-kernel firmware blobs in kernel binary"
>
> Could this be a udev issue?
>
> (/sbin/hotplug) path to uevent helper
> ? ? [*] Select only drivers that don't need compile-time external 
> firmware
> ? ? [ ] Prevent firmware from being built
> ? ? {*} Userspace firmware loading support
> ? ? [ ] Driver Core verbose debug messages
> ? ? [ ] Managed device resources verbose debug messages
>
>
> I'll keep trying different things, but if you can provide additional 
> guidance I will appreciate it very much. Thanks again.
>
>
> Jon Smirl wrote:
>> On Tue, Jan 27, 2009 at 1:50 AM, Mike Timmons 
>> <mike_timmons@trimble.com> wrote:
>>  
>>> Thanks. Yes, USB  wi fi is what I'm after.  I did find the driver I 
>>> needed
>>> after enabling the WLAN80211 and EXPERIMENTAL options. The device 
>>> discovery
>>> appears to work, and with wireless tools I can iwconfig and see my
>>> interface.
>>>
>>> QUESTION: when I "ifoncfig wlan0 up" it results in an attempt to load a
>>> firmwmare file as follows. as you can see, it fails. What are these 
>>> firmware
>>> files? I can't find it in my build output. How do I build it or 
>>> where do I
>>> get it? Where would I put it on my target?
>>>     
>>
>> Kconfig
>> Device drivers
>>   generic driver options
>>      user space firmware support
>>         check - include in-kernel firmware blobs in kernel binary
>>
>>  
>>> I did search for answers to these questions and tried to stick an 
>>> rt73.bin
>>> of unknown origin (to me anyway) in /lib/firmware but I got the same 
>>> error.
>>>
>>> -sh-2.05b# ifconfig wlan0 up
>>> [ 2212.027071] phy1 -> rt2x00lib_request_firmware: Info - Loading 
>>> firmware
>>> file 'rt73.bin'.
>>> [ 2272.058793] phy1 -> rt2x00lib_request_firmware: Error - Failed to 
>>> request
>>> Firmware.
>>> SIOCSIFFLAGS: No such file or directory
>>>
>>> Thanks again,
>>> Mike
>>>
>>>
>>>
>>> \
>>> Grant Likely wrote:
>>>    
>>>> On Mon, Jan 26, 2009 at 8:39 PM, Mike Timmons 
>>>> <mike_timmons@trimble.com>
>>>> wrote:
>>>>
>>>>      
>>>>> I'm running 2.6.24 with Freescale's lite5200 as my base. I'm 
>>>>> interested
>>>>> in
>>>>> this USB adaptor for wireless USB, but my web search does not make me
>>>>> confident that my effort will yield fruit.
>>>>>
>>>>> Can anyone direct me to a good source outlining success stories with
>>>>> wireless USB adaptors? At present I'm mesing with Linksys WUSB54GC 
>>>>> and
>>>>> some
>>>>> driver source from Ralink, but my cross-compile is not working.
>>>>>
>>>>>         
>>>> Umm, the WUSB54GC is not a "wireless USB" adapter.  It is a USB WiFi
>>>> adapter.  If you're looking for wireless USB then it is the wrong
>>>> device.
>>>>
>>>> If you are looking for a suitable wifi adapter, then that device
>>>> should work, but if you can go with a PCI or a miniPCI WiFi adapter
>>>> instead then you should get better performance.  The 5200 only has USB
>>>> 1.1.
>>>>
>>>> I'm having good success with an Atheros miniPCI adapter at the moment
>>>> using a 2.6.28 kernel.
>>>>
>>>> g.
>>>>
>>>>       
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>>
>>>     
>>
>>
>>
>>   
>
>
