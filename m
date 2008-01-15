Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12BCFDDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 06:14:54 +1100 (EST)
Message-ID: <478CF66C.3010405@freescale.com>
Date: Tue, 15 Jan 2008 12:07:40 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_soc: Fix get_immrbase() to use ranges, rather than
	reg.
References: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
	<BFCCA52A-85B7-4DD5-ACF4-2F3E65CFD7FD@kernel.crashing.org>
	<20080115164053.GA10812@ld0162-tx32.am.freescale.net>
	<17A215CC-EFAE-41B9-8DB7-C6CDB4E708F2@kernel.crashing.org>
In-Reply-To: <17A215CC-EFAE-41B9-8DB7-C6CDB4E708F2@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> Why go out of our way to fail on a childless soc node?
> 
> do we see any case in which we'd have a childless soc node?

It's possible that it could be used to communicate immrbase and soc 
type, but nothing else.  Not overly likely, but possible.

> I'm just concerned about make sure this works for all the various cases 
> of #address-cells and #size-cells.

It should.  We check the soc's #address-cells to skip the child bus 
address, and of_translate_address should take care of looking up the 
parent #address-cells.  The size portion of the ranges is ignored.

-Scott
