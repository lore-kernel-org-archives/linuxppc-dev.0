Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3BFCD67C00
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 23:08:43 +1100 (EST)
Date: Tue, 7 Nov 2006 15:08:42 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
Message-ID: <20061107150842.6ac9e8ce@vitb.ru.mvista.com>
In-Reply-To: <Pine.LNX.4.64.0611062237300.16727@host32.eke.fi>
References: <Pine.LNX.4.64.0611061523360.12023@host32.eke.fi>
	<20061106205543.43b2aacb@localhost.localdomain>
	<Pine.LNX.4.64.0611062237300.16727@host32.eke.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 6 Nov 2006 22:49:49 +0200 (EET)
Kalle Pokki <kalle.pokki@iki.fi> wrote:

> On Mon, 6 Nov 2006, Vitaly Bordug wrote:
> 
> >> This patch renames these the two existing resources, and introduces a
> >> new one, "pram_base", which is a pointer to the parameter RAM. The
> >> parameter RAM for SMC1 and SMC2 is put in the first 128 bytes of the
> >> DPRAM. This memory was already reserved from the DPRAM memory
> >> allocator for this purpose.
> >>
> > Well just one objection. pram_base should not be a device unless it applies to all the stuff of
> > SoC family which is not the case.
> >
> > For this aim, I'd put what you need into the platform_data, or follow the same approach 8xx stuff having.
> 
> I'm not sure I follow you now. "pram_base" is not a device by itself, but 
> it's just another resource in the PQ2 version of the SMC devices in the 
> platform_data. So the resource is only present when it is needed, and for 
> other platform devices that don't have this resource, the cpm_uart code 
> does nothing (as it should not).
> 
Well, yes, but are you _sure_ pram_base will be the same across all the 82xx PQ2, that happen to have smc wired to Ethernet? 

If not I am considering storing it in the platform_data is better approach.

> The only difference to the 8xx version is the new "pram_base" resource, 
> and it is required with PQ2, right?
Prolly, and I actually tried the same when introduced 8xx stuff. It was not permitted because such a thing could not be stuck to one value, and as long as we'll have it compiled into the devices table, others will have to use that offset (yet maybe having the specific dpram required for another purpose).

Hope that clarifies my position...
-- 
Sincerely, 
Vitaly
