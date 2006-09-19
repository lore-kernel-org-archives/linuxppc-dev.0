Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0030B67B53
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:00:03 +1000 (EST)
Message-ID: <45103C62.4080003@genesi-usa.com>
Date: Tue, 19 Sep 2006 20:52:18 +0200
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Fw: [PATCH] Remove powerpc specific parts of 3c509 driver
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
In-Reply-To: <20060919184243.GL29167@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	netdev@vger.kernel.org, jgarzik@pobox.com,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Some northbridges and PCI bridges have "clever" byteswapping in 
hardware, maybe this is just an effect of that. In theory depending on 
the host bridge, you should pass in big endian data and have it swap or 
not swap, not pick that way in the driver, UNLESS your driver expects 
bigendian data, in which case on a bigendian platform you can tell it to 
write without swapping. Voila, two functions.

However the existance of these PCI bridges these days? I haven't seen 
one in years, and when I have nobody has ever enabled the magic swappy 
thing as it's unreliable and can't always tell how you present the data.

One wishes that there was a ntoh and hton style macro in standard use 
for PCI access.. hang on though that jsut wouldn't work would it.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Linas Vepstas wrote:
> On Tue, Sep 19, 2006 at 02:54:33PM +1000, Stephen Rothwell wrote:
>> On powerpc and ppc, insl_ns and insl are identical as are outsl_ns and
>> outsl, so remove the conditional use of insl_ns and outsl_ns.
> 
> The rest of this patch might indeed be correct, but the above comment 
> bothers me. The "ns" versions of routines are supposed to be
> non-byte-swapped versions of the insl/outsl routines (which would
> byte-swap on big-endian archs such as powerpc.)
> 
>> diff --git a/drivers/net/3c509.c b/drivers/net/3c509.c
>> index cbdae54..add6381 100644
>> --- a/drivers/net/3c509.c
>> +++ b/drivers/net/3c509.c
>> @@ -879,11 +879,7 @@ #endif
>>  	outw(skb->len, ioaddr + TX_FIFO);
>>  	outw(0x00, ioaddr + TX_FIFO);
>>  	/* ... and the packet rounded to a doubleword. */
>> -#ifdef  __powerpc__
>> -	outsl_ns(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
>> -#else
>>  	outsl(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
>> -#endif
> 
> Dohh, a hack like this to work around some possbile byte-swapping
> bug should never have been done in the first place :-(
> 
> However, I presume someone added the  __powerpc__ define here
> because they picked up a 3c509 at a garage sale, stuck it in 
> a powerpc, found out it didn't work due to a byte-swapping bug,
> and then patched it as above. I'm disturbed that somehow 
> outsl_ns() became identical to outsl() at some point, presumably
> breaking this patch.
> 
> --linas
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
