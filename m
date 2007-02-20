Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 53BABDDD07
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 01:23:13 +1100 (EST)
Message-ID: <45DB0448.9080301@am.sony.com>
Date: Tue, 20 Feb 2007 06:23:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 3/3] zImage: Exception vector support
References: <45D7A914.4040000@am.sony.com>
	<20070220022538.GH17818@localhost.localdomain>
In-Reply-To: <20070220022538.GH17818@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
>> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
>> platforms which have entry points in the vector table.  This implements
>> SMP entry via the system reset vector.
> 
> I really don't like having always-included code take over the absolute
> start of the zImage's address space.  The whole idea in my entry
> cleanup patch is that the platform code gets control of the "head.S"
> area, so we can potentially support platforms with conflicting
> hard-wired requirements for things at specific offsets.
> 
> I think this belongs in a ps3.o, which will define _zimage_start to be
> identical to the reset vector.
> 

I need two entry points, one for the first stage loader (0x100), and one
for a second stage kexec loader (_zimage_start).

-Geoff
