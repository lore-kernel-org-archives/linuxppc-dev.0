Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2E9A679E8
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2005 03:39:55 +1000 (EST)
Message-ID: <429366DA.4000702@am.sony.com>
Date: Tue, 24 May 2005 10:39:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42926A07.20706@am.sony.com> <1116892416.30513.10.camel@gaston>
In-Reply-To: <1116892416.30513.10.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] add machine state register support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2005-05-23 at 16:40 -0700, Geoff Levand wrote:
> 
>>This patch adds routines to get and set the machine state register.  These 
>>are needed by power management code on some platforms.
>>
>>Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
> 
> 
> Hi Geoff !
> 
> Can you tell me more about this power management code ? I tend to think
> that code that wants to do more than just using the existing accessors
> should be written in assembly... 
> 
> Also, there is already
> 
> void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
> 
> That you can use for manipulating MSR bits.
> 
> Finally, I tend to prefer such small register accessors to be written as
> inline assembly in some headers. But then, I don't think you actually
> need to add anything here.
> 

Sorry for the trouble, Geert is right, there are already mfmsr() and 
mtmsr() in <ppc-asm/reg.h>.  I found get_msr in ppc64 and assumed they 
were missing for ppc.  I should have looked more carefully.

-Geoff
