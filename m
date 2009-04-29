Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id C20E9DDFAA
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 17:42:17 +1000 (EST)
Received: by bwz19 with SMTP id 19so969869bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 00:42:12 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <0F60D78C-63E2-4A8A-9EBE-80AAFB3B00A0@kernel.crashing.org>
References: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
	<0F60D78C-63E2-4A8A-9EBE-80AAFB3B00A0@kernel.crashing.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Wed, 29 Apr 2009 09:41:52 +0200
Message-ID: <aa76a2be0904290041m27d6309eu76d04d294ca9ba3d@mail.gmail.com>
Subject: Re: [PATCH] [MTD] ofpart: Partitions at same address cannot have
	thesame name v3
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

Hello Segher

  Thanks for your comments.

>
> Your special "partition" isn't really a partition then, is it.
> Because of that, device nodes to represent your partitions doesn't
> work very well.

I think that they work pretty well. Unfortunately, since
4b08e149c0e02e97ec49c2a31d14a0d3a02f8074 all the partiton must be
named "partition"

>
> You really want to use something else, a partition table on the
> flash itself for example. =A0Or maybe the (platform? MTD?) code
> should create a Linux device for the "full" device.

This wont be very flexible. With the device tree aproach we can define
partitions not only for the full flash, but also for two partitions
merged, a partition inside a partition....

>
>> Because two nodes of a device tree cannot have the same name,
>
> This isn't true.

Are you sure? This is what I get if I try to compile a device tree
with two partitions with the same name starting at the same address.

$ arch/powerpc/boot/dtc -O dtb -b 0 -p 1024
arch/powerpc/boot/dts/q5-avnet.dts -o /tmp/kk
DTC: dts->dtb  on file "arch/powerpc/boot/dts/q5-avnet.dts"
ERROR (duplicate_node_names): Duplicate node name
/plb@0/flash@ff000000/partition@ff000000
ERROR: Input tree has errors, aborting (use -f to force output)



>
>> but all the
>> partitions must be named "partition",
>
> Bad binding, no cookie for you!

Sorry, I dont understand want you want to say here.


> You cannot claim a name as generic as "partition" for this. =A0Pick
> something else if you really must do things this way.


You choose :)


         Best regards


--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
