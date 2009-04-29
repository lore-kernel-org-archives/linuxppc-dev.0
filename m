Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F219BDDF01
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 10:42:21 +1000 (EST)
In-Reply-To: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
References: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0F60D78C-63E2-4A8A-9EBE-80AAFB3B00A0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [MTD] ofpart: Partitions at same address cannot have the
	same name v3
Date: Wed, 29 Apr 2009 02:45:01 +0200
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

> Sometimes, an special partition is included in the device tree  
> including all the
> partitions. Like in:
>
> partition@ff000000 {
>        reg = < 0x000000 0x800000 >;
>        label = "Root File System";
> };
> partition@ff800000 {
>        reg = < 0x800000 0x1a0000 >;
>        label = "Bitstream";
> };
> ...
> full@ff000000 {
>        compatible = "partition";
>        reg = < 0x000000 0x1000000 >;
>        label = "Full FLASH";
> };

Your special "partition" isn't really a partition then, is it.
Because of that, device nodes to represent your partitions doesn't
work very well.

You really want to use something else, a partition table on the
flash itself for example.  Or maybe the (platform? MTD?) code
should create a Linux device for the "full" device.

> Because two nodes of a device tree cannot have the same name,

This isn't true.

> but all the
> partitions must be named "partition",

Bad binding, no cookie for you!

> -		if (strcmp(partname, "partition") != 0) {
> +		if ((strcmp(partname, "partition") != 0) &&
> +			(of_device_is_compatible(pp, "partition") != 1))
> +		{

You cannot claim a name as generic as "partition" for this.  Pick
something else if you really must do things this way.


Segher
