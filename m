Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6C429679F9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 22:57:06 +1100 (EST)
Date: Thu, 30 Mar 2006 14:37:09 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Message-ID: <20060330143709.50464af5@vitb.ru.mvista.com>
In-Reply-To: <17451.30312.967754.699319@cargo.ozlabs.ibm.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<bed6c40abe7664da7506270a46611d00@embeddededge.com>
	<17451.30312.967754.699319@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Mar 2006 17:10:48 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Dan Malek writes:
> 
> > I haven't followed the device tree development in detail, but when
> > looking at this the only question that comes to mind is wondering
> > what this really does to help me.  None of the information provided
> > here is variable nor configurable .... except I guess for the internal
> > register base address (IMMR), which for some reason has turned
> > into a variable which hasn't changed since I did the first kernel port.
> > About the only thing that is variable, which is the two different bank
> > addresses of the CPM memory that affects the configuration of
> > the FCCs in Ethernet mode, isn't reflected here in any way.
> 
> I don't know much about the CPM or CPM2, so I don't know precisely why
> these bits have been put in.  If the CPM2 is completely unique and is
> identical across all possible past and future implementations, then
> indeed there isn't a lot of value in putting details about it in the
> device tree.  Having details in the device tree becomes useful if:
> 
> * there are variants that have different collections of subdevices, or
>   subdevices at different offsets, or
> 
Yes. Offsets differ across the different PQ families. Collections may differ even on the same reference design, 885 for instance could have all the scc's/smc's utilized as UARTs, while on classic SMC1+SMC2, only, SCC may be used as 10M network.

> * there are common subdevices between CPM and CPM2 (or future CPM*
>   devices), potentially with subtle variations in offset, method of
>   enabling, etc., or
> 
Yes, but this is similar with the first point... Well even cpm and cpm2 differ (different immap.h ), and we have CPM future heading for QE. 
> * there are subdevices in CPM/CPM2 which match some common device
>   (e.g. a 16550 uart) for which a generic driver can be used with some
>   appropriate configuration.
Yep - cpm_uart and fs_enet are live examples. Both are intended to deal with serial and Ethernet stuff from the different variations of CPM. Right now they are not ideal, because they still have to remap the whole immr (say to access cpm command register) ,and such parts are still board-specific which is not good...
> 
> As I say, I don't know if these points apply to CPM/CPM2 specifically.
> 
> Paul.
> 
> 
Thank you for your comments - now I'm sure all this following the right way...

-- 
Sincerely, 
Vitaly
