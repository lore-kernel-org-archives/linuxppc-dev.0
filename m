Return-Path: <larry.finger@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62608B6FD0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 10:02:38 +1000 (EST)
Received: by iakh37 with SMTP id h37so2012656iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2012 17:02:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F9B3398.9060701@lwfinger.net>
Date: Fri, 27 Apr 2012 19:02:32 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop> <4F9ABD67.3060704@lwfinger.net>
 <1335565573.20866.7.camel@pasglop>
In-Reply-To: <1335565573.20866.7.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2012 05:26 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2012-04-27 at 10:38 -0500, Larry Finger wrote:
>
>> Sorry, I was unable to find anything in debugfs to help me learn about interrupt
>> mapping. The value of CONFIG_NR_IRQS is already 512. I have not tried reducing
>> it to 128. The setting for CONFIG_SPARSE_IRQ was on, and changing it to off did
>> not make any difference.
>>
>> I finished the bisection, which led to
>>
>> commit a79dd5ae5a8f49688d65b89a859f2b98a7ee5538
>> Author: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Date:   Thu Dec 15 11:13:03 2011 +1100
>>
>>       tty/serial/pmac_zilog: Fix suspend&  resume
>>
>> As this seemed to be an improbable result, I did the full test by checking out
>> the previous commit (43ca5d3). That resulted in a "good" result. Then I used
>> quilt to add commit a79dd5a as a patch and the fault returned. I then noticed
>> that you said in the commit message that "I removed some code for handling
>> unexpected interrupt which should never be hit...". It appears that my box does
>> indeed hit such an unexpected interrupt.
>>
>> I could always get rid of the fault by disabling CONFIG_SERIAL_PMACZILOG, but I
>> would like to fix the problem if possible.
>
> Right, it should be fixed. I need to understand where the unexpected
> interrupt comes from. Can you tell me (or remind me) what specific
> machine model you are using ? Are you putting the console on the serial
> port ?

It is a 15" Powerbook G4. I think they call it a Titanium. The console is not on 
a serial port. In fact, the reason that I did not think this patch was a problem 
is because the serial port does not appear to be connected to an external port. 
I was unaware that there was a serial port on the motherboard. There is a modem 
jack, but no 9 or 25-pin connectors that would indicate a standard serial port.

There are two stack dumps with the same trace. I posted the first, but the 
second is preceded by the lines

[<c02adca0] pmz_interrupt
Disabling IRQ #23
ttyPZ1: IrDA setup for 57600 bps, dongle version: 4
ttyPZ1: IrDA setup for 115200 bps, dongle version: 4
irq23: nobody cared (try booting with the "irqpoll" option

As I am not sure how to put options in with yaboot, I have not tried that.

Larry
