Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C08C667BC8
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 04:46:59 +1000 (EST)
In-Reply-To: <713AF674-0689-4F20-9896-70696969ED24@embeddededge.com>
References: <724D42AC-3DBA-4B32-8E4A-914441251470@kernel.crashing.org>
	<713AF674-0689-4F20-9896-70696969ED24@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F75246DE-A58C-43EA-875E-CD82A3668188@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: RFC: qe lib code location?
Date: Mon, 16 Oct 2006 13:46:33 -0500
To: Dan Malek <dan@embeddededge.com>
Cc: Li Yang <leoli@freescale.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kim Phillips <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2006, at 12:30, Dan Malek wrote:

>
> On Oct 3, 2006, at 12:34 PM, Kumar Gala wrote:
>
>> I was wondering what peoples thought were on having the qe lib code
>> live in drivers/qe instead of sysdev/qe_lib (with the exception of
>> the interrupt controller code)
>
> My personal reason for choosing one place or the other
> is based upon usefulness to architectures other than PowerPC,
> or general kernel APIs that may change.  If something is
> useful to architectures other than PowerPC, clearly it
> should go there.  If the software has dependencies on
> general kernel APIs (networking is a good example), I like
> to put is there in hopes that someone changing the APIs
> will at least make an attempt to keep this code up to
> date as well.
>
> I think it neither of these apply (and I don't think the VM
> interfaces are a good argument because they generally
> affect the architecture ports anyway), then I think it
> should stay in a more architecture specific place.

My feeling here is that, all things being equal, drivers/ is better.   
My reasoning is that, should Freescale decide to release a non- 
powerpc chip with a QUICC Engine, having the code in drivers/ makes  
this easier.  It would also allow for some screwier implementations  
(put an 8360 on a PCI card, and just use the QE directly from the  
host processor).  Of course, all of this is pure speculation, so if  
there's a good reason *not* to put it in drivers/, we should probably  
just maintain the status quo.

>
>
>> Yes, one can argue the cpm code should live in drivers/cpm by this
>> logic, but lets considered them grandfathered for now.
>
> I would say that based on my opinion above the cpm
> stuff should stay  in sysdev, too.  These are not only
> powerpc specific, but even Freescale embedded powerpc
> specific.  I don't think that code belongs in drivers.
>
> Thanks.
>
> 	-- Dan
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
