Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10E4FDE9F1
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 02:18:12 +1000 (EST)
Message-ID: <47FF8F56.50803@freescale.com>
Date: Fri, 11 Apr 2008 11:18:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/8] [POWERPC] fsl_lbc: implement few routines to	manage
	FSL UPMs
References: <20080311172106.GA4766@localhost.localdomain>	<20080311172408.GB7727@localhost.localdomain>	<EE642BFC-4262-44E8-BD48-E76E5418C276@kernel.crashing.org>
	<20080411161311.GA28067@polina.dev.rtsoft.ru>
In-Reply-To: <20080411161311.GA28067@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Fri, Apr 11, 2008 at 09:09:57AM -0500, Kumar Gala wrote:
>> On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
>>> These will be used by the FSL UPM NAND driver.
>> can this be a bit more descriptive.  What exactly are these functions  
>> trying to accomplish.
> 
> Yeah, sorry about that. Here is updated patch, with a bit more descriptive
> comment, and highly kernel-doc'ed functions.
> 
>>> +int fsl_upm_find(u32 base, struct fsl_upm *upm)
>> what is base?
> 
> Address base, as in LBC Base address register. Fixed down below.

Should it be phys_addr_t?

> +/**
> + * fsl_upm_find - find pre-programmed UPM via base address
> + * @addr_base:	base address of the memory bank controlled by the UPM
> + * @upm:	pointer to the allocated fsl_upm structure
> + *
> + * This function walks UPMs comparing "Base address" field of the BR registers
> + * with the supplied addr_base argument. When bases are match, this function
> + * fills fsl_upm structure so you can use it with the rest of UPM API. On
> + * success this function returns 0, otherwise it returns appropriate errno
> + * value.
> + */

The FCM driver does something very similar; could we name this something 
more generic such as fsl_lbc_find?

-Scott
