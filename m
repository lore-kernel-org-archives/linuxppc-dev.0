Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D94BE2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 11:06:06 +1100 (EST)
Message-ID: <41E5B318.3060304@mvista.com>
Date: Wed, 12 Jan 2005 16:30:32 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@somerset.sps.mot.com>
References: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
In-Reply-To: <Pine.LNX.4.61.0501120133080.21665@blarg.somerset.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>All,
>
>Please take a look at the following patch.  It adds driver model support 
>via platform devices to 85xx.  This is originally based on patches from 
>Jason M. 
>
>The idea behind the code is that for a give family: 4xx, 8xx, 82xx, 83xx, 
>85xx, 86xx we will have structure defns for the following:
>
>enum ppc_soc_devices 
>in asm-ppc/<family.h>:
>  list of all unique devices in the family
>
>struct platform_device soc_platform_devices[]
>in arch/ppc/platforms/<family>/<family>_devices.c:
>  describes all platform devices that exist in the family
>
>struct soc_spec soc_specs[]
>in arch/ppc/platforms/<family>/<family>_soc.c:
>  describes each unique chip in the family and what devices it has
>
>Plus the following functions:
>
>identify_soc_by_id() -- determine soc by an int id
>identify_soc_by_name() -- determin soc by name (useful in some 82xx cases)
>ppc_soc_get_pdata() -- get platform_data pointer so board code can modify
>ppc_soc_update_paddr() -- update iomem resources with a given paddr
>
>Please provide feedback, I want to get this into 2.6.11 for 85xx.
>  
>

My $0.02.

I didn't go thru in complete detail but I like the idea.  I have a 
couple minor comments, though.

1) Can we pick something other than 'soc' since the Marvell bridges 
really aren't SOCs?  I don't really know what is better but just to 
throw something out, how about haing them all look like ppc_pd_xxx()?

2) In 8540_ads.c you're digging out platform_device entries and 
modifying them in your mpc8540ads_setup_arch() routine.  I think the 
platform_device "way" of doing that would be to make your mods via the 
platform_notify() hook (eventually called by device_add() which was 
ultimately called from platform_add_devices()).

Mark
