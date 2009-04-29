Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59B46DDF78
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 23:53:30 +1000 (EST)
In-Reply-To: <aa76a2be0904290041m27d6309eu76d04d294ca9ba3d@mail.gmail.com>
References: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
	<0F60D78C-63E2-4A8A-9EBE-80AAFB3B00A0@kernel.crashing.org>
	<aa76a2be0904290041m27d6309eu76d04d294ca9ba3d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D18D3A18-4388-4F0E-A688-BF375F9C7AB0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [MTD] ofpart: Partitions at same address cannot have
	thesame name v3
Date: Wed, 29 Apr 2009 15:56:38 +0200
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	David.Woodhouse@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Your special "partition" isn't really a partition then, is it.
>> Because of that, device nodes to represent your partitions doesn't
>> work very well.
>
> I think that they work pretty well.

With "real" devices you don't normally have two devices sitting at
the same address.  Since you _do_ have that with your partitions,
it doesn't fit the device node abstraction very well.

> Unfortunately, since
> 4b08e149c0e02e97ec49c2a31d14a0d3a02f8074 all the partiton must be
> named "partition"

Ah!  After writing my original reply, I read the documentation,
and this had me confused.

4b08e14 looks wrong to me.  It also didn't update the documentation.

>> You really want to use something else, a partition table on the
>> flash itself for example.  Or maybe the (platform? MTD?) code
>> should create a Linux device for the "full" device.
>
> This wont be very flexible. With the device tree aproach we can define
> partitions not only for the full flash, but also for two partitions
> merged, a partition inside a partition....

Well, except you have problems doing just that :-P

>>> Because two nodes of a device tree cannot have the same name,
>>
>> This isn't true.
>
> Are you sure?

Yes.

> This is what I get if I try to compile a device tree
> with two partitions with the same name starting at the same address.
>
> $ arch/powerpc/boot/dtc -O dtb -b 0 -p 1024
> arch/powerpc/boot/dts/q5-avnet.dts -o /tmp/kk
> DTC: dts->dtb  on file "arch/powerpc/boot/dts/q5-avnet.dts"
> ERROR (duplicate_node_names): Duplicate node name
> /plb@0/flash@ff000000/partition@ff000000
> ERROR: Input tree has errors, aborting (use -f to force output)

I think this error is trying to say both the names and the unit
addresses are identical (and the latter exist), which isn't
technically incorrect, but not very useful either.

>>> but all the
>>> partitions must be named "partition",
>>
>> Bad binding, no cookie for you!
>
> Sorry, I dont understand want you want to say here.

I was trying to say that if the "partition" binding says the "name"
of every partition node should be "partition", then it is a very
bad binding.  The binding does _not_ say that though, the code is
wrong.

>> You cannot claim a name as generic as "partition" for this.  Pick
>> something else if you really must do things this way.
>
> You choose :)

Picking good names is hard work (more than 50% of all programming, heh).
You choose :-)  [Hint: something with a comma, maybe  
"linux,mtd,partition"
or similar -- I don't really care.  OTOH, it seems you won't need this
at all].


Segher
