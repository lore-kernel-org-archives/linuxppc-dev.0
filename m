Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F33C2DE695
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 04:31:50 +1000 (EST)
Message-ID: <48346A88.40608@am.sony.com>
Date: Wed, 21 May 2008 11:31:36 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: PS3: Fix memory hotplug
References: <4829C07A.4040407@am.sony.com>	<1210834125.8297.80.camel@pasglop>
	<18476.1203.459931.530585@cargo.ozlabs.ibm.com>
In-Reply-To: <18476.1203.459931.530585@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: davem@davemloft.net, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
>> When you do an lmb_add you should probably also do an lmb_analyze to
>> update the total memory count etc...
>> 
>> That leads to some interesting issues such as the LMB stuff wasn't
>> really meant to be dynamically modified after boot, and thus the kernel
>> has no locks in there. That can be an issue...
>> 
>> Paul, any thoughts here ? Should we add a lock ? That would mean being
>> careful as the LMB stuff can be called very early, and spinlock wants
>> things like PACA and possibly lockdep to be around.. 
> 
> Either that, or we give in and use iomem_resource to track where
> system RAM is, as well as the other things in the physical address
> space, like other architectures do...

The generic hot plug routines already use iomem_resource
(mm/memory_hotplug.c).  Both __add_pages() and add_memory()
add the new mem to iomem_resource, and so it seems there
is no need for the powerpc specific walk_memory_resource(),
since the generic one does its check with iomem_resource.

I need to look a little closer at how the pSeries does
its memory hot plug, but I think removing the powerpc
specific walk_memory_resource() won't effect pSeries since
it seems to have its own hot plug routines that do their
own thing entirely with lmb.

It doesn't seem that it would be difficult to make the
pSeries hot plug code to use iomem_resource, but some of the
generic hot plug routines cannot be called until fairly
late in the startup.

The other thing to do then would be to change the other
powerpc startup code to use iomem_resource instead of lmb.

-Geoff
