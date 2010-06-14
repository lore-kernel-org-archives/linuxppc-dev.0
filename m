Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D99D1007FB
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 17:47:25 +1000 (EST)
Message-ID: <4C15DE2E.1050905@firmworks.com>
Date: Sun, 13 Jun 2010 21:45:50 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Request review of device tree documentation
References: <AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<1276408773.1962.574.camel@pasglop>
	<AANLkTinwL0XtMNG13inr_1UliOlqZkyr4dlvG-ZGL9JT@mail.gmail.com>
	<20100614073828.GA6095@n2100.arm.linux.org.uk>
In-Reply-To: <20100614073828.GA6095@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au,
	Olof Johansson <olof@lixom.net>, Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell King - ARM Linux wrote:
> On Sun, Jun 13, 2010 at 11:23:45PM -0600, Grant Likely wrote:
>   
>>>> Or perhaps the MMU and caches can be turned off for the duration of the
>>>> callback.
>>>> I don't have the details of ARM MMUs and caches reloaded into my head
>>>> yet.  Maybe next week...
>>>>         
>
> We've had these kinds of questions in the past.  Doing what you're asking
> above is not really an option - it requires:
>
> 1. disable all IRQs
> 2. setup 1:1 MMU mappings for code to turn off MMU
>    (requires new page table)
> 3. disable imprecise exceptions
> 4. flush caches and TLBS
> 5. jump to 1:1 mapping area for code to disable MMU
> 6. disable caches and mmu
> 7. call function
> 8. flush caches and TLBs
> 9. re-enable caches and mmu
> 10. re-enable imprecise exceptions
> 11. switch back to original MMU mappings
> 12. re-enable all IRQs
>
> This is fine if you don't care at all about interrupt latency.
> Unfortunately, most people do care about interrupt latency because
> that directly affects interactivity and system performance.  The
> called function could not enable interrupts or exceptions - as the
> CPU vectors are in virtual space, disabling the MMU effectively
> makes them disappear.
>
> Moreover, with the MMU and caches disabled, the CPU performance is
> extremely poor, so the called function will run slowly.
>
> So, disabling the MMU isn't really viable.
>   

None of this is a deal-breaker for the kind of debugging tasks that are 
the primary use case for the callback.

> Now, if the external code was fully PIC, we could then run it with
> the MMU enabled.  However, this wouldn't really help - the external
> code could not access any devices without knowledge of how the kernel
> setup the V:P translations.
>
> So you'd need to pass some kind of data structure giving locations of
> devices to the called code - but then what if the kernel doesn't have
> the device mapped?
>
>   
