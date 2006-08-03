Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 164F767A3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 02:27:51 +1000 (EST)
In-Reply-To: <528646bc0608030734j163acdd0gf37f19ece6f18c09@mail.gmail.com>
References: <311545913012eb141f24.1102520059.miltonm@bga.com>
	<528646bc0608030734j163acdd0gf37f19ece6f18c09@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b4c0f7394350325fbdbfe66afb1b4ec8@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Booting Linux Kernel without bootloader
Date: Thu, 3 Aug 2006 11:27:51 -0500
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 3, 2006, at 9:34 AM, Grant Likely wrote:

> On 8/3/06, Milton Miller <miltonm@bga.com> wrote:
>> On Tue Aug  1 2006 11:17:41 PM CDT,  Grant Likely  wrote:
>> > On 7/25/06, Clint Thomas <cthomas@soneticom.com> wrote:
>> > >
>> > > Basically, the system I want linux running on does not require the
>> > > initialization of hardware that U-boot provides, or at least it 
>> does not
>> > > need it to boot the linux kernel. I want to load an uncompressed 
>> linux
>> > > kernel into memory and start the execution of the kernel, without 
>> using any
>> > > kind of bootloader. Is this possible? Or does linux need some 
>> kind of
>> > > firmware or other software to tell it to start executing? Thanks 
>> for any
>> > > info you might have.
>>

>> > You could use the bootwrapper that is in the kernel source tree
>> > (zImage).  If a zImage's entry point is at the execution entry 
>> point,
>> > then it will start the Linux kernel correctly.  However, it is 
>> still a
>> > compressed image.
>> >
>>
>> The boot wrapper is a reference implementation, not a required piece 
>> of the
>> boot sequence.
...
>
> I agree.  However, the original post sounded to me like he was looking
> for a canned solution.  I know zImage isn't exactly what he asked for
> because it is a compressed image, but it does achieve the *effect* he
> asked for.

Actually the existing zImage will not do that, it requires a client
interface to allocate memory, etc.  There are alternates available
but they are not yet merged.

> I am curious as to the source of his requirements.  ie. what is
> loading the kernel into ram?  Where is it coming from?

That would be useful to help suggest alternatives.

> I've got a similar situation on my Virtex-4 platform.  The FPGA takes
> care of all device initialization.  However, the kernel is loaded of a
> CF card via a *slow* JTAG interface.  Loading an uncompressed image is
> more time consuming than loading a compressed image and uncompressing
> it in software.

This is often the case.  However, if its loaded via some kind of DMA 
access
from a higher powered cpu then loading the uncompressed kernel could be
the fastest way.  Since we don't know we can only mention things to
consider as we state what can be done.

milton
