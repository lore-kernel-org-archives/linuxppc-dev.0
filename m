Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E92BE98.4090907@imc-berlin.de>
Date: Tue, 08 Apr 2003 14:20:40 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C RTC causes boot delay...
References: <IGEFJKJNHJDCBKALBJLLAENCFLAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund schrieb:
>>I wrote,
>>
>>
>>>I have an I2C RTC connected to my MPC855T to substitute the internal one.
>>>
>>>I noticed that between
>>>
>>>   Verifying Checksum ... OK
>>>   Uncompressing Kernel Image ... OK
>>>
>>>and the next lines printed while booting "nothing" happens for THREE
>>>seconds.
>>>
>>>I reckon that is has something to do with not having an external 32kHz
>>>clock on the MPC. But I can't find the place in the sources!
>>
>>I migth have found it:
>>
>>Is it ok and enough to set
>>
>>         ppc_md.set_rtc_time             = NULL;
>>         ppc_md.get_rtc_time             = NULL;
>>
>>in platform_init()? And then later - when I2C is initialized - set it
>>to the appropriate I2C RTC functions?
>
>
> Yes, that's it. If your kernel ever hangs after printing out
> "calibrating delay loop ...", try adding a set_tb(0,0) somewhere in m8xx_setup.c,
> to see if it fixes it.

Thanks Jocke!

> You may also want to add an "I2C reset sequence" in your firmware/kernel
> if your I2C clock gets stuck and don't respond(can happen if reset/power down while
> reading the RTC). Look in u-boot for details.

Yeah. I know. I should put into PPCBoot/U-Boot.
But in the docs it says it's only for SOFT_I2C aka bitbang!
So
a) can I toggle the pins using GPIO and still use HARD_I2C? or
b) can I use SOFT_I2C in PPCBoot and CPM I2C (8xx-algo) under linux?

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
