Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3587567B14
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 02:20:33 +1000 (EST)
In-Reply-To: <cb6c89fb776248d3a2ddbcd5d3d043ed@freescale.com>
References: <7f0a378a4f3b17a9db01773fcca5fafd@freescale.com>
	<cb6c89fb776248d3a2ddbcd5d3d043ed@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <014bd721f4bc5070a07e24fc4ac1c248@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 12 Apr 2005 12:20:12 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: Fix alignment exception checking on load/store
	multiple instructions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2005, at 11:26 AM, Kumar Gala wrote:

> Upon further review, the PEM and PPC Arch spec, say that its ok to 
> emulate lwarz as an lwz.  From the spec:

Hmmm ...  Seems weird.  Since the emulation won't create the 
reservation,
the subsequent stwcx will fail.  If the stwcx to the same unaligned 
address
will be a programming error.

Also, the EREF states that neither the lwarx nor stwcx should be 
emulated,
and it's a programming error to have unaligned accesses with these.
I still don't like this "similar but different" Book-E architecture, 
but I guess
we have to live with it ....


> The instructions lwz and lwarx give the same DSISR bits (all zero). 
> But if lwarx causes an Alignment interrupt, it should not be emulated.

???  Those are nearly the same words from the EREF, I just didn't find 
anything
like the following.

> ... It is adequate for the Alignment interrupt handler simply to treat 
> the instruction as if it were lwz. The emulator
> must use the address in the DAR, rather than compute it from RA/RB/D, 
> because lwz and lwarx have different instruction formats.

I guess it's done as lwz because it's not possible to actually emulate 
an
unaligned lwarx?

> So we are handled lwarx according to the arch specs already.

If that's the way you read it :-)   Probably not worth the discussion, 
but
I brought it up since we are here and it will be soon forgotten.

Thanks.


	-- Dan
