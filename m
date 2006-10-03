Return-Path: <dan@embeddededge.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 7EF91679E0
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 03:36:50 +1000 (EST)
In-Reply-To: <724D42AC-3DBA-4B32-8E4A-914441251470@kernel.crashing.org>
References: <724D42AC-3DBA-4B32-8E4A-914441251470@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <713AF674-0689-4F20-9896-70696969ED24@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: RFC: qe lib code location?
Date: Tue, 3 Oct 2006 13:30:20 -0400
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kim Phillips <Kim.Phillips@freescale.com>, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2006, at 12:34 PM, Kumar Gala wrote:

> I was wondering what peoples thought were on having the qe lib code
> live in drivers/qe instead of sysdev/qe_lib (with the exception of
> the interrupt controller code)

My personal reason for choosing one place or the other
is based upon usefulness to architectures other than PowerPC,
or general kernel APIs that may change.  If something is
useful to architectures other than PowerPC, clearly it
should go there.  If the software has dependencies on
general kernel APIs (networking is a good example), I like
to put is there in hopes that someone changing the APIs
will at least make an attempt to keep this code up to
date as well.

I think it neither of these apply (and I don't think the VM
interfaces are a good argument because they generally
affect the architecture ports anyway), then I think it
should stay in a more architecture specific place.


> Yes, one can argue the cpm code should live in drivers/cpm by this
> logic, but lets considered them grandfathered for now.

I would say that based on my opinion above the cpm
stuff should stay  in sysdev, too.  These are not only
powerpc specific, but even Freescale embedded powerpc
specific.  I don't think that code belongs in drivers.

Thanks.

	-- Dan
