Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06A86DDFCE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 01:36:05 +1000 (EST)
Message-Id: <41163AE2-5EE9-4273-B2F2-373034AE4DC4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1241102965.7356.7.camel@concordia>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/pci: Move pseries code into pseries platform
	specific area
Date: Thu, 30 Apr 2009 10:35:56 -0500
References: <1241100846-14216-1-git-send-email-galak@kernel.crashing.org>
	<1241102965.7356.7.camel@concordia>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2009, at 9:49 AM, Michael Ellerman wrote:

> On Thu, 2009-04-30 at 09:14 -0500, Kumar Gala wrote:
>> There doesn't appear to be any specific reason that we need to  
>> setup the
>> pseries specific notifier in generic arch pci code.  Move it into  
>> pseries
>> land.
>
> Yeah I guess. Although if some other platform ever wants to do PCI
> hotplug it probably wants to call update_dn_pci_info() also.

when that happens we can worry about, also the code I moved is pretty  
pseries specific  (seeing as the event is called PSERIES_RECONFIG_ADD)

>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -254,6 +255,31 @@ static void __init pseries_discover_pic(void)
>>               " interrupt-controller\n");
>> }
>>
>> +extern void * update_dn_pci_info(struct device_node *dn, void  
>> *data);
>
> Ahem :)

Yeah, was being lazy.  I'll move it into asm/pci-bridge.h

- k
