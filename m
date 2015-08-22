Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AAA41A027F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2015 21:13:36 +1000 (AEST)
Message-ID: <1440242015.28532.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Fix mis-merge of OPAL support for LEDS
 driver
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 khandual@linux.vnet.ibm.com, stewart@linux.vnet.ibm.com
Date: Sat, 22 Aug 2015 21:13:35 +1000
In-Reply-To: <55D7F547.2090607@linux.vnet.ibm.com>
References: <1440200525-22360-1-git-send-email-mpe@ellerman.id.au>
 <55D7F547.2090607@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-08-22 at 09:36 +0530, Vasant Hegde wrote:
> On 08/22/2015 05:12 AM, Michael Ellerman wrote:
> > When I merged the OPAL support for the powernv LEDS driver I missed a
> > hunk.
> > 
> > This is slightly modified from the original patch, as the original added
> > code to opal-api.h which is not in the skiboot version, which is
> > discouraged.
> 
> Yeah. I should have made sure opal-api.h is in sync with skiboot. On skiboot
> side I added below macros to fsp-leds.h instead of opal-api.h :-(

Yeah, I should have remembered too. We'll try to remember in future.

> Anyway for now these macros are used by led driver only (on both side).. Hence I
> think its fine to add to driver code itself. But we should make sure these
> strings won't change as we use them while creating sysfs entries and use that
> information to identify the type of LED.

Sure. If you want to add a comment or something saying they must not change
that's fine by me.

> > Instead those values are moved into the driver, which is the only place
> > they are used.
> > 
> > Fixes: 8a8d91817aec ("powerpc/powernv: Add OPAL interfaces for accessing and modifying system LED states")
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Patch looks good.
> 
> Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

Thanks.

I've pushed it to next.

cheers
