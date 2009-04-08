Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 103FFDDF7F
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 17:23:33 +1000 (EST)
Message-ID: <49DC405E.5050005@garzik.org>
Date: Wed, 08 Apr 2009 02:12:46 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	<1239156559.10104.7.camel@localhost>
In-Reply-To: <1239156559.10104.7.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Timur Tabi <timur@freescale.com>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2009-04-07 at 19:36 -0500, Timur Tabi wrote:
>> On Tue, Apr 7, 2009 at 6:57 PM, Tejun Heo <tj@kernel.org> wrote:
>>
>>> Hmmm... that means intx isn't set by default.  I'm not sure what is
>>> the right thing to do here.  I think it's something which should be
>>> handled by the PCI layer.  Oh well, maybe we should just revert the
>>> change and keep setting intx?
>> cc'ing linuxppc-dev
>>
>> I really don't know what should be done.  It seems to make sense to
>> have the PCI layer enable interrupts.
>>
>> This seems to be a powerpc-specific bug, but I don't know enough of
>> the PCI subsystem.
> 
> Have you confirmed that INTX is disabled before that call?

The symptoms definitely indicate such, as well as his reversing that commit.

My guess is that this is a ULI M1575-specific bug, and the PCI layer 
needs a quirk that knows this device does -not- disable INTX, when MSI 
is enabled.

But honestly, I never saw any harm in disabling INTX manually.  Indeed, 
I wrote the code that disabled INTX out of now-substantiated paranoia 
that some PCI devices would be too dumb to follow that particular MSI 
rule...  and the cost of twiddling INTX seemed quite low in comparison 
the potential problems created by the absence of INTX twiddling.

	Jeff
