Return-Path: <tnt@246tNt.com>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53602DDEB9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:12:09 +1100 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CNBqfq007073
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 00:11:56 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45D0F411.4020306@246tNt.com>
Date: Tue, 13 Feb 2007 00:11:13 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 02/10] powerpc: Add device tree fixups for the EFIKA
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<9B771992-8763-4257-83B8-90F7D5A24EC0@kernel.crashing.org>
In-Reply-To: <9B771992-8763-4257-83B8-90F7D5A24EC0@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Feb 12, 2007, at 4:13 PM, Sylvain Munaut wrote:
>
>> We make the efika device tree compliant with the defined bindings
>> (at least compliant enough). This is mostly done by mangling
>> the device_type and compatible properties, but also adding
>> some missing bits.
>>
>> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>  arch/powerpc/kernel/prom_init.c |   81
>> +++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 81 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c
>> b/arch/powerpc/kernel/prom_init.c
>> index 520ef42..4fb5938 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -2117,11 +2117,92 @@ #else
>>  #define fixup_device_tree_pmac()
>>  #endif
>>
>> +#ifdef CONFIG_PPC_EFIKA
>>
>
> can't this EFIKA fixup live in efika board code (platforms/52xx/efika*)

It's too late by then.
Since some of these are needed just to make the board recognized as an
efika and not chrp.
Or for the sram not to be assimilated to normal RAM ...

Some of them probably could by "hacking" the tree after it's been built
I guess that would be possible.
But since some of them are needed in prom_init anyway I think it's
better to keep it grouped there.


    Sylvain
