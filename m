Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E92A9E8.7060101@imc-berlin.de>
Date: Tue, 08 Apr 2003 12:52:24 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I2C RTC causes boot delay...
References: <3E92A455.5040709@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote,

> I have an I2C RTC connected to my MPC855T to substitute the internal one.
>
> I noticed that between
>
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
> and the next lines printed while booting "nothing" happens for THREE
> seconds.
>
> I reckon that is has something to do with not having an external 32kHz
> clock on the MPC. But I can't find the place in the sources!

I migth have found it:

Is it ok and enough to set

         ppc_md.set_rtc_time             = NULL;
         ppc_md.get_rtc_time             = NULL;

in platform_init()? And then later - when I2C is initialized - set it
to the appropriate I2C RTC functions?

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
