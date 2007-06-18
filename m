Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5B291DDEEF
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 02:25:42 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <Pine.LNX.4.62.0706151529380.14899@pademelon.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bc61eb97d01812aeccaff374fd1d775b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 1/6] ps3: Preallocate bootmem memory for the PS3 FLASH 
Date: Mon, 18 Jun 2007 11:25:30 -0500
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Jun 15 23:32:41 EST 2007, Geert Uytterhoeven wrote:
> On Fri, 15 Jun 2007, Benjamin Herrenschmidt wrote:
>> On Fri, 2007-06-15 at 13:39 +0200, Geert Uytterhoeven wrote:
>>> Preallocate 256 KiB of bootmem memory for the PS3 FLASH ROM storage 
>>> driver.
>>
>> I still very much dislike the #ifdef xxx_MODULE in main kernel code.
>
> Me too, but there's no other reliable way to allocate it after boot 
> up...
>
>> At the end of the day, is it realistic to ever use a PS3 without the
>> storage driver ? I would suggest just allocating those 
>> unconditionally.
>
> If you don't plan to (a) boot into GameOS or (b) update the kboot 
> kernel, then the answer is: yes, you can live without the FLASH ROM 
> driver, and save one promille of RAM.
>

In that case, why not make it an early_param, and only change the 
default based on the config varables?   It sounds like I might want to 
reclaim this memory even if I compiled in the driver.

Statement (a) is because one has to write the flag to say don't' boot 
OtherOS to go back to GameOS (or reset all defaults) I presume.

milton
