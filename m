Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29B81DE087
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 00:07:01 +1000 (EST)
Message-Id: <A77679ED-A2B8-4EC2-9632-EECA8D789D75@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080502085304.1c58d995@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 08:59:49 -0500
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<1209730435.2946.160.camel@vader.jdub.homelinux.org>
	<E55D097A-13D0-45BF-9AE8-E9741A0A869D@kernel.crashing.org>
	<20080502085304.1c58d995@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 8:53 AM, Josh Boyer wrote:

> On Fri, 2 May 2008 08:32:12 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> On May 2, 2008, at 7:13 AM, Josh Boyer wrote:
>>
>>> On Fri, 2008-05-02 at 03:11 -0500, Kumar Gala wrote:
>>>> GCC 4.4.x looks to be adding support for generating out-of-line
>>>> register
>>>> saves/restores based on:
>>>>
>>>> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
>>>>
>>>> This breaks the bootwrapper as we'd need to link with libgcc to get
>>>> the
>>>> implementation of the register save/restores.
>>>
>>> We don't link with libgcc anywhere in the kernel.  Is this going to
>>> have
>>> similar impacts for building the vmlinux itself?
>>
>> Not by default.  The issue only shows up with -Os.  Not sure if we  
>> can
>> build the kernel that way.
>
> We can.  See CONFIG_CC_OPTIMIZE_FOR_SIZE.  That's set in at least
> pseries_defconfig and ps3_defconfig.  It's also something I've been
> thinking about trying with 4xx.
>
> Seems we need a bit more than just the bootwrapper.

building w/this enabled and will produce a patch for the kernel if  
needed.

- k
