Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3362DDD06
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:45:59 +1100 (EST)
In-Reply-To: <45D29AE5.7090004@freescale.com>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <99f78ea51ed158e618ddd75221190e82@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Date: Thu, 15 Feb 2007 02:45:54 +0100
To: Timur Tabi <timur@freescale.com>
Cc: paulus@samba.org, Stuart Yoder <stuart.yoder@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I think that:
>>
>>  - The /chosen node should be present in the .dts even if empty
>
> Only one DTS file has it.  It's been removed from every other DTS.  Are
> you should that instead of removing the last one, I should *add* one to
> the other DTS files?

Every device tree is required to have a /chosen node.  Now
that doesn't mean DTS files need one; there are some more
options:

-- dtc could add the node whenever it is missing from the DTS;
-- it could be made a requirement of the boot loader to add it;
-- the kernel could be taught to fake one if needed.

Pick your poison :-)  I prefer the first option (dtc).


Segher
