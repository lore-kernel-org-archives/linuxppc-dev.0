Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (host32.eke.fi [194.100.64.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2B0267CDA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 00:21:12 +1100 (EST)
Date: Tue, 7 Nov 2006 15:21:00 +0200 (EET)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
In-Reply-To: <20061107150842.6ac9e8ce@vitb.ru.mvista.com>
Message-ID: <Pine.LNX.4.64.0611071451130.3291@host32.eke.fi>
References: <Pine.LNX.4.64.0611061523360.12023@host32.eke.fi>
	<20061106205543.43b2aacb@localhost.localdomain>
	<Pine.LNX.4.64.0611062237300.16727@host32.eke.fi>
	<20061107150842.6ac9e8ce@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 7 Nov 2006, Vitaly Bordug wrote:

> Well, yes, but are you _sure_ pram_base will be the same across all the 
> 82xx PQ2, that happen to have smc wired to Ethernet?
>
> If not I am considering storing it in the platform_data is better approach.

Yes, pram_base is always 0x87fc for SMC1 and 0x88fc for SMC2. This is
for all PowerQUICC II families (8260, 8272, and 8280). I'm not sure how 
PQ2 Pro and PQ3 and handled, but I suspect they don't share these 
definitions.

Anyway, I'm only extending the already existing conventions to the 
platform device approach. These same decisions have already been made in 
the past and are used in the cpm_uart compat mode. It may be that 
Freescale someday releases a microcode patch that relocates the SMC 
parameter RAM, but even in this case it would be better to use the same 
approach with compat mode and platform device mode to avoid confusion.

I could have used the numerical address offsets in the resource 
definition, but I wanted to emphasize the fact that the offsets are 
already defined by the DPRAM memory allocator (this is a little hackish, 
yes) instead of hardware directly requiring these exact values.

This snippet is from cpm2.h:

 	/* Dual Port RAM addresses.  The first 16K is available for almost
 	 * any CPM use, so we put the BDs there.  The first 128 bytes are
 	 * used for SMC1 and SMC2 parameter RAM, so we start allocating
 	 * BDs above that.  All of this must change when we start
 	 * downloading RAM microcode.
 	 */
 	#define CPM_DATAONLY_BASE       ((uint)128)

My patch puts pram_base exactly here.
