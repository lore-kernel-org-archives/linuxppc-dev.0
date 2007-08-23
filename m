Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD027DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 23:16:23 +1000 (EST)
In-Reply-To: <20070823161351.2a5f8096.sfr@canb.auug.org.au>
References: <20070823130913.2e9db6eb.sfr@canb.auug.org.au>
	<20070823131032.04d929e7.sfr@canb.auug.org.au>
	<DDBA4998-5BCC-413A-9759-3815693A68E6@kernel.crashing.org>
	<20070823161351.2a5f8096.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4073FFB-78FF-4276-BBD4-3C57CCC6DA63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] Size swapper_pg_dir correctly
Date: Thu, 23 Aug 2007 08:17:04 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2007, at 1:13 AM, Stephen Rothwell wrote:

> On Wed, 22 Aug 2007 22:26:35 -0500 Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>>> +#ifdef CONFIG_PPC64
>>> +	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
>>> +#endif
>>
>> Why limit this to ppc64?  The cleanup should be reasonable for all  
>> ppc.
>
> Because PGD_TABLE_SIZE only exists for ppc64 :-) for ppc32 the
> swapper_pg_dir will always be 1 page, right?

No, it can be 2 pages if we do > 32-bit physical on 44x/fsl_booke.

> So we could have
> #define PGD_TABLE_SIZE PAGE_SIZE
> for 32 bit and then go around and change the swapper_pg_dir's, but  
> that
> would be a separate patch.

- k
