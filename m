Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CC35DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 03:21:29 +1100 (EST)
Message-Id: <18E479E7-5841-4F91-98FC-E61DAB3D62DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0812031716330.30629@vixen.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/85xx: Fix compile warnings in mpc85xx_mds.c
Date: Wed, 3 Dec 2008 10:21:23 -0600
References: <1228318727-29863-1-git-send-email-galak@kernel.crashing.org>
	<Pine.LNX.4.64.0812031716330.30629@vixen.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2008, at 10:17 AM, Geert Uytterhoeven wrote:

> On Wed, 3 Dec 2008, Kumar Gala wrote:
>> arch/powerpc/platforms/85xx/mpc85xx_mds.c: In function  
>> 'board_fixups':
>> arch/powerpc/platforms/85xx/mpc85xx_mds.c:244: warning: format '%x'  
>> expects type 'unsigned int', but argument 4 has type  
>> 'resource_size_t'
>> arch/powerpc/platforms/85xx/mpc85xx_mds.c:250: warning: format '%x'  
>> expects type 'unsigned int', but argument 4 has type  
>> 'resource_size_t'
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/ 
>> powerpc/platforms/85xx/mpc85xx_mds.c
>> index 2494c51..915e8d3 100644
>> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
>> @@ -241,13 +241,13 @@ static int __init board_fixups(void)
>> 		mdio = of_find_compatible_node(NULL, NULL, compstrs[i]);
>>
>> 		of_address_to_resource(mdio, 0, &res);
>> -		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
>> +		snprintf(phy_id, BUS_ID_SIZE, "%llx:%02x", (u64)res.start, 1);
>                                                            ^^^
> unsigned long? u64 differs for 32-bit and 64-bit.

This is proper.  This is a 32-bit only platform (and the format is  
long long).

> Doh, if you would put the whole resource range there, you could use  
> %pR ;-)

and if we had a %R ... :)

- k
