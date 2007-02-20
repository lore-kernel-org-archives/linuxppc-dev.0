Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 027D5DDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 01:32:10 +1100 (EST)
Message-ID: <45DB0663.3020600@am.sony.com>
Date: Tue, 20 Feb 2007 06:32:03 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 2/3] zImage: SMP hold
References: <45D7A910.60702@am.sony.com>
	<20070220022216.GG17818@localhost.localdomain>
In-Reply-To: <20070220022216.GG17818@localhost.localdomain>
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
> On Sat, Feb 17, 2007 at 05:17:04PM -0800, Geoff Levand wrote:
>> Add SMP secondary hold helper routines to the powerpc zImage
>> bootwrapper.  For platforms which are entered with multiple cpus.
>> These routines can be used to hold the secondary cpus until the
>> kernel is ready for entry.
> 
> Could we have these functions in their own library module.  That way
> they can be omitted in the wrappers for strictly-UP platforms (many
> embedded), or platforms where the secondary CPUs are held in firmware
> until the kernel releases.

After some feedback, I decided to drop trying to support calling C from
the secondary CPUs.  That will simplify this to just a few bytes.  We can
think about optimization if another platform needs to use either the
exception vectors or the SMP support.  They are independent, but I'll just
put them together in in head.c for convenience.

-Geoff
