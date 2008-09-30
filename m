Return-Path: <bigeasy@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5560ADE15D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 03:22:09 +1000 (EST)
Message-ID: <48E26025.9030208@linutronix.de>
Date: Tue, 30 Sep 2008 19:21:41 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc/boot: add kernel,end node to the cuboot target
References: <20080923195404.GA10935@www.tglx.de>
	<200809240124.m8O1O2QK076012@sullivan.realtime.net>
	<20080929200448.GA23025@www.tglx.de>
	<5162f4985b6fa3ced7fe8670cdae926a@bga.com>
In-Reply-To: <5162f4985b6fa3ced7fe8670cdae926a@bga.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:

>> |load: entry = 0x80053c flags = 0
>> |nr_segments = 2
>> |segment[0].buf   = 0x1002b8f0
>> |segment[0].bufsz = 80
>> |segment[0].mem   = (nil)
>> |segment[0].memsz = 1000
>> |segment[1].buf   = 0x4803f008
>> |segment[1].bufsz = 3a3138
>> |segment[1].mem   = 0x800000
>> |segment[1].memsz = 3b0000
> 
> I would expect a third segment (kernel/zImage, dtb, and purgatory), but 
> its not clear that you are getting that far yet.

segment 0 looks like a small segment which should create "boot loader 
environment". That one does nothing.
Segment 1 is my cuImage. What is purgatory?

>> Now. The entry address in image->start is valid and is the entrypoint of
>> the "custom" cuImage. Custom means that it does not depend any register
>> values passed from u-boot (the original one needs a pointer to bd_t).
>> The only requirement is a valid 1:1 memory mapping.
> 
> ok sounds good.  does this have the dtb in it too?
Yes it does.

>> The branch above is taken, so I've found my current mapping
> 
> ok, but should you not be using PID0 explictly to say global only?
The kernel mapping should only be global and therefore that might be a 
good idea.

> obviously, a jtag or similar hardware debugger would be best.  Second 
I have here CodeWarrior usb tap but after more than one hour playing with 
that thing I started to hack assembly char put. It helper more :) kexec 
seems to work now :) I get "nobody cared irq X" from time to time so I 
thing I have to fix here something.....

> As a final note, it looks like you are currently replacing the code in 
> relocate_new_kernel with book-e code.  Obviously this will need 
> refinement to select or move to heat_xx to merge.
Yep, this is next what is going to happen. I would prefer to have them 
runtime switchable instead of build depend.

> Again, I don't have any direct experience, but mauybe this gives you 
> some ideas.
Your hints helped. Thx for that.

> milton
Sebastian
