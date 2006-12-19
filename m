Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09C7EDDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 22:57:34 +1100 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBJBuxR5018131
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 12:57:07 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4587D338.7060906@246tNt.com>
Date: Tue, 19 Dec 2006 12:55:36 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	<1166522096.25827.76.camel@pmac.infradead.org>
	<1166528379.19254.69.camel@localhost.localdomain>
In-Reply-To: <1166528379.19254.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2006-12-19 at 09:54 +0000, David Woodhouse wrote:
>   
>> The Efika matches chrp_probe() too, so put its own probe first to make
>> sure we get it right in a multiplatform build.
>>     
>
> Hrm... I told them to remove that from their device-tree ... dammit !
>   
Yes, I told them to do some other changes to their device-tree, but no
luck so far.

I think I'll end up with a bunch of device-tree fix in the efika probe
function. (Either
that, or force the user to have a nvramrc for the firmware that makes
the appropriate
changes, but that's kindof an hassle for the user)

That won't solve the problem with chrp though.
I've seen that pseries will also match chrp. And in the pseries probe
function,
the Cell blades are explicitely 'refused'.

Maybe instead of putting 52xx first, it would be "better" to put chrp
and pseries
last as they seem more "generic". So that anything that match before
that has
priority.


    Sylvain


>> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
>>
>> --- linux-2.6.19.ppc/arch/powerpc/platforms/Makefile~	2006-12-17 14:55:49.000000000 +0000
>> +++ linux-2.6.19.ppc/arch/powerpc/platforms/Makefile	2006-12-17 17:16:52.000000000 +0000
>> @@ -5,9 +5,9 @@ ifeq ($(CONFIG_PPC64),y)
>>  obj-$(CONFIG_PPC_PMAC)		+= powermac/
>>  endif
>>  endif
>> +obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
>>  obj-$(CONFIG_PPC_CHRP)		+= chrp/
>>  obj-$(CONFIG_4xx)		+= 4xx/
>> -obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
>>  obj-$(CONFIG_PPC_83xx)		+= 83xx/
>>  obj-$(CONFIG_PPC_85xx)		+= 85xx/
>>  obj-$(CONFIG_PPC_86xx)		+= 86xx/
>>
>>     
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
