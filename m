Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 36A99DDE29
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 15:55:23 +1100 (EST)
Message-ID: <478AEB39.70106@pikatech.com>
Date: Sun, 13 Jan 2008 23:55:21 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
In-Reply-To: <200801051041.18173.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
>
>> +#ifdef CONFIG_TACO
>> +/* The NDFC may allow 32bit read/writes, but it sure doesn't work on
>> + * the taco!
>> + */
>>     
>
> We definitely don't want to see such board specific stuff in the common
> NDFC driver. And I really doubt that you need this change for your board.
> We are using this ndfc driver on multiple boards, and all have no
> problems accessing the controller with 32bit read/writes. So you most
> likely have a problem with your board port. Perhaps something with
> with the EBC setup. Please re-check and compare with boards that are know
> to work, like Sequoia.
>   
How about adding a config option that lets you specify 8 bit access? 
Something like CONFIG_NDFC_8BIT_ACCESS. We could default it to no and 
put a little blurb that says something like:

On some platforms the 32bit read/writes cause a machine access 
exception. If you get a machine access exception while reading the NAND 
bad block table, try turning on 8 bit access.

Cheers,
   Sean
