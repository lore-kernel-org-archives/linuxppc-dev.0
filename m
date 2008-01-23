Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4295DDDEC8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 10:03:21 +1100 (EST)
Message-Id: <175876A0-9BC1-40D8-B204-93725BF45E1D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080124094017.8afc5077.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Move RapidIO support code from arch/ppc
Date: Wed, 23 Jan 2008 17:00:41 -0600
References: <Pine.LNX.4.64.0801230637510.4478@blarg.am.freescale.net>
	<20080124094017.8afc5077.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 23, 2008, at 4:40 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Wed, 23 Jan 2008 06:38:29 -0600 (CST) Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> +++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
>> @@ -190,6 +188,7 @@ mpc85xx_exclude_device(u_char bus, u_char devfn)
>> #endif /* CONFIG_PCI */
>>
>> #ifdef CONFIG_RAPIDIO
>> +extern void mpc85xx_rio_setup(int law_start, int law_size);
>
> Ooops! This should be in a header file, of course.
>
>> +++ b/arch/ppc/platforms/85xx/stx_gp3.c
>> @@ -270,6 +269,7 @@ int mpc85xx_exclude_device(u_char bus, u_char  
>> devfn)
>> #endif /* CONFIG_PCI */
>>
>> #ifdef CONFIG_RAPIDIO
>> +extern void mpc85xx_rio_setup(int law_start, int law_size);
>
> And again.
>
> I guess this is just temporary in which case we can probably live with
> it.  But do not forget to fix it up.
>
>> +++ b/arch/ppc/platforms/85xx/tqm85xx.c
>> @@ -309,6 +308,7 @@ int mpc85xx_exclude_device(u_char bus, u_char  
>> devfn)
>> #endif /* CONFIG_PCI */
>>
>> #ifdef CONFIG_RAPIDIO
>> +extern void mpc85xx_rio_setup(int law_start, int law_size);
>
> Third time lucky?   :-)

They were in a header file, however in moving the code over the header  
ends up in arch/powerpc/sysdev/fsl_rio.h.  I don't think there is a  
simple way to include that in arch/ppc code today (and I don't want to  
invent one).

My goal is to just kill 85xx for arch/ppc.

- k
