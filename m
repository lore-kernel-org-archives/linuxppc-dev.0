Return-Path: <SRS0=DCot=PF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 5F7BDDDFDC
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 23:31:18 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
Date: Thu, 11 Oct 2007 15:31:12 +0200
References: <200710111408.34207.sr@denx.de>
	<1192107771.5534.120.camel@localhost.localdomain>
In-Reply-To: <1192107771.5534.120.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200710111531.13022.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 11 October 2007, Josh Boyer wrote:
> On Thu, 2007-10-11 at 14:08 +0200, Stefan Roese wrote:
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > +# CONFIG_MATH_EMULATION is not set
>
> Does the 405EX have an FPU?

No.

> If not, do you want this set by default so 
> floating point instructions work?

I just checked some existing arch/ppc defconfig files (and arch/powerpc too). 
Most if not all have MATH_EMULATION not set. Even on those PPC's without FPU. 
I assume we see no problems since soft-float is used while compiling.

Anyways, I'll change this and resubmit.

> > +CONFIG_RESOURCES_64BIT=y
>
> I'm not sure about that one.  I see walnut has the same thing for some
> reason, but is it really needed?

No, I don't think it is needed. As all 405 PPC's, the 405EX is 32bit only. 
I'll change this too.

> > +CONFIG_WANT_DEVICE_TREE=y
> > +CONFIG_DEVICE_TREE="walnut.dts"
>
> That looks wrong.  Should be selecting the Kilauea dts

Yes, good catch. Since I'm not using the bootwrapper, I should be able to get 
rid of WANT_DEVICE_TREE too. But it seems to be autoselected in 
arch/powerpc/platforms/Kconfig.cputype for 40x and most other "embedded" 
CPU's. Any idea why this is the case?

Thanks.

Best regards,
Stefan
