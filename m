Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 988F02BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 04:34:57 +1100 (EST)
Message-ID: <41E6B12B.1020705@mvista.com>
Date: Thu, 13 Jan 2005 10:34:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <41E5B318.3060304@mvista.com>
	<579DFDF6-651A-11D9-92A0-000393DBC2E8@freescale.com>
In-Reply-To: <579DFDF6-651A-11D9-92A0-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, Kumar Gala <galak@somerset.sps.mot.com>
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

>> My $0.02.
>>
>> I didn't go thru in complete detail but I like the idea.  I have a
>> couple minor comments, though.
>>
>> 1) Can we pick something other than 'soc' since the Marvell bridges
>>  really aren't SOCs?  I don't really know what is better but just to
>> throw something out, how about haing them all look like ppc_pd_xxx()?
>
>
> What about ppc_plat_xxx() or ppc_sys_xxx() [for system]?  'sys' maybe 
> more consistent with our naming conventions in that arch/ppc/platforms 
> is more board focused, and arch/ppc/syslib is bridge and non-core chip 
> functionality. 


ppc_sys_xxx() sounds good to me.

>
>
>> 2) In 8540_ads.c you're digging out platform_device entries and
>> modifying them in your mpc8540ads_setup_arch() routine.  I think the
>> platform_device "way" of doing that would be to make your mods via the
>> platform_notify() hook (eventually called by device_add() which was
>> ultimately called from platform_add_devices()).
>
>
> This is problematic for some things like the updating of the IOMEM 
> resources since that needs to occur before platform_device_register is 
> called.


I don't think so.  In fact, the platform_notify() will be called from 
[platform_add_devices()]/platform_device_register()/device_register()/device_add()/platform_notify().  
There is an example in the bk://source.mvista.com/linux-2.5-marvell tree 
inside arch/ppc/platforms/katana.c.  It was only a suggestion anyway, so 
its not a big deal.

Mark
