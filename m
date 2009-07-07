Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1D1D9B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 01:49:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C025DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 01:49:29 +1000 (EST)
Message-Id: <907E8777-61B9-493E-B958-A1926379278B@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A0ABEB1B-3A7A-4068-88EC-33D6D663C87A@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: dma_ops->map_page == NULL
Date: Tue, 7 Jul 2009 10:49:15 -0500
References: <4A523984.2080904@marel.com> <200907071015.24097.markn@au1.ibm.com>
	<1246964905.6066.41.camel@pasglop>
	<A0ABEB1B-3A7A-4068-88EC-33D6D663C87A@kernel.crashing.org>
Cc: Mark Nelson <markn@au1.ibm.com>,
	=?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>,
	Kumar Gala <galak@gate.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 7, 2009, at 9:37 AM, Kumar Gala wrote:

>
> On Jul 7, 2009, at 6:08 AM, Benjamin Herrenschmidt wrote:
>
>> On Tue, 2009-07-07 at 10:15 +1000, Mark Nelson wrote:
>>>
>>> When the 32 and 64bit DMA code was merged in .28 , map_/ 
>>> unmap_page() was
>>> added in favour of map_/unmap_single() (which was later removed  
>>> in .29)
>>> so you'll have to replace your calls to dma_map_single() with
>>> dma_map_page(). Just pass it the page and offset rather than the  
>>> address.
>>
>> Wait a minute ... dma_map_single() should still work, it will just  
>> call
>> dma_map_page() underneath. All dma_ops should have a ->map page
>> callback.

>>
>>
>> Do you have any dma_ops set for your device at all ? I wonder how we
>> set the dma_ops for platform devices nowadays ... We use to have this
>> fallback to direct ops when the dma_ops are NULL but that is gone and
>> I see no suitable replacement to set them on platform devices for
>> embedded archs ... oops...

There is a platform/of bus notifier that sets the dma_ops to a default  
value in arch/powerpc/kernel/setup-common.c.

>>
>>
>> Kumar, Becky, what's the situation there ?
>>
>> Cheers,
>> Ben.
>
> Is it possible the dev pointer is not valid?  I can't remember if  
> that was a .29 or .30 change that requires us to start passing a  
> valid dev pointer to get the proper dma_ops.

I'm pretty sure that went into .29.  And invalid dev pointer is the  
most likely culprit.  IIRC, the usual cause of this is that you're  
passing in the *wrong* dev pointer.  There are often struct  
hierarchies with, confusingly, multiple struct device pointers.  You  
need the one which has archdata dma_ops setup properly.  For an of  
device, you want the dev pointer that is part of the of_device struct.

If this isn't your problem, then please post some code so we can look  
at this further, and post a log of what's happening.

Cheers,
Becky
