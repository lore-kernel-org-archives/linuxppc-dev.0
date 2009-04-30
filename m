Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FC9BDDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 13:19:51 +1000 (EST)
Subject: Re: [MTD] ofpart: Partitions at same address cannot have the same name
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
In-Reply-To: <1240387541-16594-1-git-send-email-ricardo.ribalda@uam.es>
References: <1240387541-16594-1-git-send-email-ricardo.ribalda@uam.es>
Content-Type: text/plain
Date: Thu, 30 Apr 2009 13:19:37 +1000
Message-Id: <1241061577.29501.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David.Woodhouse@intel.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-22 at 10:05 +0200, Ricardo Ribalda Delgado wrote:
> Sometimes, an special partition is included in the device tree including all the
> partitions. Like in:
> 
> partition@ff000000 {
> 	reg = < 0x000000 0x800000 >;
> 	label = "Root File System";
> };
> partition@ff800000 {
> 	reg = < 0x800000 0x1a0000 >;
> 	label = "Bitstream";
> };
> ...
> partitionAll@ff000000 {
> 	reg = < 0x000000 0x1000000 >;
> 	label = "Full FLASH";
> };
> 
> Because two nodes of a device tree cannot have the same name, but all the 
> partitions must be named "partition", this special partition is invalid.
> 
> This patch makes ofpart.c only check for the firt part of the name, and 
> ignore the rest, allowing this special partition.

I fail to see the point of this "special" partition in the first
place...

Things would make more sense if you had a full flash device
whose child nodes are the partitions.

Ben.
