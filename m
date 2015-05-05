Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0111.outbound.protection.outlook.com [157.56.110.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CC641A035B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 06:45:57 +1000 (AEST)
Message-ID: <1430858734.16357.256.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/qman: Change fsl,qman-channel-id to cell-index
From: Scott Wood <scottwood@freescale.com>
To: Pledge Roy-R01356 <roy.pledge@freescale.com>
Date: Tue, 5 May 2015 15:45:34 -0500
In-Reply-To: <BN3PR0301MB126796C0EC18EEBB26702C588CD10@BN3PR0301MB1267.namprd03.prod.outlook.com>
References: <1429311187-19062-1-git-send-email-scottwood@freescale.com>
 <BN3PR0301MB126796C0EC18EEBB26702C588CD10@BN3PR0301MB1267.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Bucur
 Madalin-Cristian-B32716 <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-05 at 11:04 -0500, Pledge Roy-R01356 wrote:
> Sorry for the slow reply.
> 
> I don't believe this is correct - let me explain the rational why we had two properties in the QMan portal to begin with.
> 
> The two properties in question are cell-index and fsl,qman-channel-id.
> 
> The cell-index property is used in u-boot as an index for the software portal ID when adding the fsl,liodn from the U-boot table into the device tree.

The device tree is not supposed to contain arbitrary software
identifiers.

> The  fsl,qman-channel-id property is used in Linux and corresponds to a
> hardware value that indicates which channel is dedicated to the
> software portal.
> 
> While I'm not aware of a current SoC where the channel ID for a
> software portal does not match the index (i.e. SWP 0 uses channel 0,
> etc.) 

Thus there's no backward compatibility issue with redefining cell-index
to mean the channel ID.

> it is possible that future SoCs could stray from this model,
> there is no reason for portal index to equal channel ID at all times.

How can future SoCs dictate how we assign a software-defined identifier?
If software wants it to be the same as the channel id, then it will be.

If there is some aspect of the hardware itself (not the documentation)
that cell-index currently corresponds to, other than the channel id,
please make that clear.

-Scott
