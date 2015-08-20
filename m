Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0108.outbound.protection.outlook.com [207.46.100.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 820E21A05A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 02:54:02 +1000 (AEST)
Date: Thu, 20 Aug 2015 11:53:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Pledge Roy-R01356 <roy.pledge@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Bucur
 Madalin-Cristian-B32716" <madalin.bucur@freescale.com>, Wang Haiying-R54964
 <Haiying.Wang@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/qman: Change fsl,qman-channel-id to cell-index
Message-ID: <20150820165348.GA4881@home.buserror.net>
References: <1429311187-19062-1-git-send-email-scottwood@freescale.com>
 <BN3PR0301MB126796C0EC18EEBB26702C588CD10@BN3PR0301MB1267.namprd03.prod.outlook.com>
 <1430858734.16357.256.camel@freescale.com>
 <BN3PR0301MB1267E5A61E7E5BC2789F9E898CDA0@BN3PR0301MB1267.namprd03.prod.outlook.com>
 <1431470762.16357.511.camel@freescale.com>
 <BN3PR0301MB12670C0BE318280D1C53FE0F8C670@BN3PR0301MB1267.namprd03.prod.outlook.com>
 <20150819213021.GA22290@home.buserror.net>
 <BN3PR0301MB12675C1EC30FBC1E823161908C660@BN3PR0301MB1267.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <BN3PR0301MB12675C1EC30FBC1E823161908C660@BN3PR0301MB1267.namprd03.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 20, 2015 at 09:52:46AM -0500, Pledge Roy-R01356 wrote:
> I guess my point isn't getting through - channel-id and cell-index are
> too independent concepts that are coincidentally the same.  Cell-index
> is only used by u-boot and is used to determine the portal number.  It
> is absolutely possible that we produce and SoC where portal number 0
> has channel 0x1000.  We've changed these things in the past as well -
> this is why we introduced the channel-id property.  This is also
> consistent with other blocks (FMan, PME, DCE) that have channels
> associated with them.
> 
> The cell-index is useless - the portal ID can be derived from the
> portal address.  The fact that you're unwilling to remove cell-index
> doesn't mean that channel-id is redundant and should be removed.

I guess my point isn't getting through.  Any concept that cell-index
represented that was not identical to channel id is dead and gone, as is
the concept of "portal number".  Every time you see cell-index just
pretend you are seeing fsl,qman-channel-id.

cell-index is *not* defined as anything to do with the portal address.

> > > The only thing cell-index indicates is the offset of the portal in the
> > > QMan address space.
> > 
> > cell-index has been redefined to not mean that at all.  It now only means
> > channel ID.  We can do this because the value happens to be the same for all
> > existing SoCs (and we should be sure to avoid putting things into the SDK for
> > the aforementioned ARM chips that are contrary to the new definition).
> > 
> 
> U-boot doesn't dictate the HW architecture and shouldn't - you're
> trying very hard not to admit you changed something you didn't fully
> understand and actually making the system harder to deal with.  At no
> point in time have we ever assumed portal ID would equal channel id. 

cell-index does not mean "portal ID".

> With your logic u-boot is broken because it is using channel ID to
> index into an array that is per portal not per channel.  We shouldn't
> have removed channel-id in the first place - trying to redefine that
> portals = channels is just plain incorrect.

That's not what happened.

> I'm not sure how else to get through to you on this, your base
> assumption is wrong.

Likewise.

-Scott
