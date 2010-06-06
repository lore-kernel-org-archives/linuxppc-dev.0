Return-Path: <kerstin.jonsson@ericsson.com>
Received: from mailgw9.se.ericsson.net (mailgw9.se.ericsson.net
	[193.180.251.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 819481007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Jun 2010 02:20:41 +1000 (EST)
Message-ID: <4C0BCAC7.4000708@ericsson.com>
Date: Sun, 6 Jun 2010 18:20:23 +0200
From: kerstin jonsson <kerstin.jonsson@ericsson.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: fsl_rio.c build problem
References: <4C08E25E.8000200@ericsson.com> <4C095C53.60002@freescale.com>
In-Reply-To: <4C095C53.60002@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/2010 10:04 PM, Scott Wood wrote:
> On 06/04/2010 06:24 AM, kerstin jonsson wrote:
>    
>> Hi,
>>
>> I'm using:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>
>> and building for ARCH=powerpc - mpc85xx_defconfig
>>
>> arch/powerpc/sysdev/fsl_rio.c will not build due to a missing
>> MCSR_MASK bitmask definition.
>>
>> The attached patch is based on code found in
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>>
>> and - at the least - will fix the build problem.
>>      
> Can we remove the use of MCSR_MASK from fsl_rio.c instead?  I don't see
> what it's accomplishing here.  MCSR_MASK will be wrong on e500mc, so
> exporting it as something that looks generic doesn't seem right.
>    
Thanks for pointing that out, I agree in the context it's currently
used in the fsl_rio.c, it's not obvious what purpose it serves.

I have a e500v2 so I guess that just removing the MCSR_MASK
from the fsl_rio.c will make no difference in my case.
> MCSR_BUS_RBERR also needs to change on e500mc -- you'll probably get
> MCSR_LDG.
>
>    
Someone that know the e500mc probably need to have a look
at this part of the fsl_rio.c then.

BR,
Kerstin
> -Scott
>    
