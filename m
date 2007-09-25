Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070925021144.GF30338@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
	<b312e03ef67dcd6cdc5f57e90da746ef@kernel.crashing.org>
	<20070925021144.GF30338@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9c20d018e890250443516b886317ceb9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Date: Tue, 25 Sep 2007 22:33:58 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Hrm... we probably want an "i2c" device_type class, but I don't think
>>> we've actually defined one, which is a problem
>>
>> By defining new device_type's, or new semantics for device_type,
>> you open the door to (accidentally) becoming incompatible with
>> "real" OF.
>
> Hrm... perhaps.  But is it a realistic danger - I'll have to think
> more about that.

It is trivial to avoid these dangers completely by not overloading
the meaning of "device_type".

>>> I think we want to think a bit more carefully about how to do  
>>> bindings
>>> for RTC devices.  No "rtc" device_type is defined, but again we might
>>> want to.
>>
>> Actually, "device_type" = "rtc" _is_ defined (in the "device support
>> extensions" recommended practice), and there is no useful way a flat
>> device tree can implement it (it merely defines get-time and set-time
>> methods).
>
> Ah.. right.  That changes things a bit, in that we might want to
> include device_type purely for similarity with real OF tree.

You should include the device_type only if you implement its binding,
and a flat device tree does not, and cannot.  (In almost all cases,
a flat device tree cannot implement device_type's semantics -- this
means that pretty much the only case where a flat tree should use
device_type is to have it as a workaround for bad kernel requirements).

> Real OF has a device_type == "nvram" too, doesn't it?

Yes, same "device support extensions" document.

> AFAICT the real
> OF systems I have (which I think all have ISA-like CMOS RTC/NVRAM
> chips) the RTC is labelled as "nvram" rather than "rtc".

Sounds buggy.

>>> The fact that NVRAM+RTC chips are so common is a bit of an issue from
>>> the point of view of defining a device class binding - a device can't
>>> have type "rtc" and "nvram".
>>
>> You should match OS drivers on "compatible" only anyway.
>
> Absolutely.  I was only thinking of defining "device classes" where
> for some reason it is useful to examine them without needing to pick a
> particular driver.

Yeah I understand.  In what situations would this be useful?
Answering that question will make the requirements for this more
clear; or maybe it will show we do not need this at all.

>> Those cases where OS drivers don't nicely 1-1 match device nodes are a
>> bit of a headache; for RTC/NVRAM devices, these problems are nicely
>> side-stepped by handling this from platform code.
>
> Not necessarily.  The new RTC class drivers are just drivers like
> anything other and are not especially instantiated from the platform
> code.

I meant "can be nicely side-stepped", or "usually are ..." :-)

Obviously, when you cannot avoid the problem, you have a problem.

> And drat.  I was only really mentioning stuff about device_type in
> passing, but it's the only thing anyone's responded to.  I was also
> mostly suggesting changing the format of compatible, for greater
> similarity with the existing ds1385 binding.

Okay, quoting from your earlier message:

> I did find one real OF binding for a different Dallas RTC (and NVRAM),
> see:
>
> http://playground.sun.com/1275/proposals/Closed/Remanded/Accepted/346- 
> it.txt
>
> It's a little different from the example above.

That is a binding for the nvram part only, not for the RTC.


Segher
