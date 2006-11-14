Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 7F0F867D9C
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 22:32:27 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAEBWQbC000383
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 20:32:26 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAEBWQl5000372
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 20:32:26 +0900 (JST)
Message-ID: <4559A943.3040108@am.sony.com>
Date: Tue, 14 Nov 2006 03:32:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
References: <4554DA9C.9040102@am.sony.com>	
	<1163391081.7410.65.camel@localhost.localdomain>	
	<4557F5C5.7080604@am.sony.com>	
	<1163469714.8048.54.camel@localhost.localdomain>	
	<45593060.10602@am.sony.com>
	<1163473988.8048.70.camel@localhost.localdomain>
In-Reply-To: <1163473988.8048.70.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Mon, 2006-11-13 at 18:56 -0800, Geoff Levand wrote:
>> Michael Ellerman wrote:
>> >> > Why can't your PS3 platform code fake-up device nodes for SPUs? It seems
>> >> > that would simplify this quite a lot.
>> >> 
>> >> 
>> >> Seems like a hack to me.  My concern is that I just have to keep adding some
>> >> extra hack for every new spu feature that comes out.  I would prefer to make
>> >> a proper design from the start, but if anyone can be more convincing I am
>> >> open to suggestions.
>> > 
>> > Well the whole thrust of the flattened-device-tree model, is that we do
>> > as much platform-specific hackery in a boot-loader/early-init, and
>> > present the hardware in as standard a way as possible to the kernel via
>> 
>> 
>> The thing is that the spus are visualized, so to create one takes up
>> HV resources, mainly HV memory.  Creating spus in the bootloader has
>> several problems.  One is that you could be allocating HV memory that would
>> never be used if the kernel is not configured for spu support, and this
>> is memory could be used for other HV support.  Another problem is the
>> management of those HV resources across kernel reloads, with kexec for
>> example.  If the management is split then both entities need to have
>> knowledge of the other, which complicates things.
> 
> Yeah I knew you were going to say that :)  How much memory does it take
> in the HV to create a "logical spu"?


I don't know the exact amount.  I guess with the current implementation it
is minimal though, since it now only supports one-to-one physical to logical.


> Kexec might complicate things, is it really high on your feature list?


Yes, the bootloader needs USB HID for the menu, plus the capability to
load the kernel with tftp or from HD, usb storage, etc.  The only
way currently is with kboot.  No other bootloader has been ported,
and there is no plan to do any other.


>> > The hope is that this isolates most of the kernel from platform specific
>> > details, as far as is possible - there will always be some things that
>> > need to be abstracted out - for that we have ppc_md and a few other
>> > callbacks.
>> > 
>> > The priv1_ops serve that purpose, providing callbacks, and there's
>> > really no way around that - you can't tap the priv1 area when you're
>> > running under a HV - fine. But for just finding the spus it strikes me
>> > that it would be _nicer_, perhaps not easier :), to have your
>> > "enumerate_spus" populate the flat device tree early on - which would
>> > leave more of the spu code untouched by the hv/bare-metal issue.
>> 
>> 
>> And how many would you like to find? 1? 5? 400? Although there is
>> a current limitation in the HV implementation, these are logical
>> spus.  It would seem the kernel could create spus based on the need,
>> and thus better balance resource usage, but this is not at all how
>> the current spu code works though.  I don't plan to do any work on
>> this, but it would be nice to keep it open.
> 
> Actually I'd like 8, or is it 7. I don't see why having more "logical
> spus" than "physical spus" is useful - the kernel can already schedule
> many spu contexts over a smaller number of physical spus. As far as
> giving unused spus back to the HV .. I'll believe it when I see it :)


The way it works is that the policy module reserves a number of the 
physical spus for the partition.  So for example, on a machine that
has eight spus, it might reserve five for a partition.  Now that
would mean the guest could have 100% of the five, and the potential to
share some of the others with another partition, but the current
implementation does not support the sharing part, so you only get
the reserved ones.  If the guest creates and destroys spus on demand,
the unused ones can be used to run shared contexts in other
partitions, at least that is what the design allows for.

-Geoff
