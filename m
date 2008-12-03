Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B022DDDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 01:54:46 +1100 (EST)
Message-Id: <75DC3D14-4019-4C55-A553-C54063790DD8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20081203120640.GB9818@gondor.apana.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] crypto: talitos - Fix modpost warning
Date: Wed, 3 Dec 2008 08:52:29 -0600
References: <1228278556-1056-1-git-send-email-galak@kernel.crashing.org>
	<20081203120640.GB9818@gondor.apana.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2008, at 6:06 AM, Herbert Xu wrote:

> On Tue, Dec 02, 2008 at 10:29:16PM -0600, Kumar Gala wrote:
>> Removed __devexit from talitos_remove() since its also called from
>> talitos_probe().
>>
>> WARNING: vmlinux.o(.text+0x28a008): Section mismatch in reference  
>> from the function talitos_probe() to the  
>> function .devexit.text:talitos_remove()
>> The function talitos_probe() references a function in an exit  
>> section.
>> Often the function talitos_remove() has valid usage outside the  
>> exit section
>> and the fix is to remove the __devexit annotation of talitos_remove.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> OK, but what about the __devexit_p reference on talitos_remove?
> We should remove that too.

missed that one.  will fix up and post a new patch.

- k
