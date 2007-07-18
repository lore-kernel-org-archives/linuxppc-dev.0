Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E688DE154
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:33:50 +1000 (EST)
Message-ID: <469E40E8.10604@freescale.com>
Date: Wed, 18 Jul 2007 11:33:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 32/61] mpc82xx: Move PQ2 restart and halt functions out
	of mpc8272-specific code.
References: <20070718013541.GD15238@ld0162-tx32.am.freescale.net>
	<5ED3F9B1-87FF-4046-ADFD-E7805925489A@kernel.crashing.org>
In-Reply-To: <5ED3F9B1-87FF-4046-ADFD-E7805925489A@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
> Kill pq2_halt, if this is all it does just dont set ppc_md.halt() and  
> get the generic behavior which is the same.

OK.

>> diff --git a/include/asm-ppc/immap_cpm2.h b/include/asm-ppc/ immap_cpm2.h
>> index 3c23d9c..8795bcc 100644
>> --- a/include/asm-ppc/immap_cpm2.h
>> +++ b/include/asm-ppc/immap_cpm2.h
>> @@ -10,6 +10,8 @@
>>  #ifndef __IMMAP_CPM2__
>>  #define __IMMAP_CPM2__
>>
>> +#include <linux/types.h>
>> +
> 
> 
> Why was this needed all of a sudden?

It uses types without including any headers.  It's always been needed, 
we just got away with it before because the file including immap_cpm2.h 
included other stuff earlier.

-Scott
