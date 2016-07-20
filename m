Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvpZg5pR0zDqdh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 06:35:39 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Wed, 20 Jul 2016 22:35:20 +0200
Message-ID: <5282323.HEP6x2M0Nh@wuerfel>
In-Reply-To: <1469039508.25630.17.camel@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <4016699.uYaV8nWfqC@wuerfel> <1469039508.25630.17.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, July 20, 2016 1:31:48 PM CEST Scott Wood wrote:
> On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> > On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > > 
> > > From: yangbo lu <yangbo.lu@nxp.com>
> > > 
> > > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> > > header file.  This SVR numberspace is used on some ARM chips as well as
> > > PPC, and even to check for a PPC SVR multi-arch drivers would otherwise
> > > need to ifdef the header inclusion and all references to the SVR symbols.
> > > 
> > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > > [scottwood: update description]
> > > Signed-off-by: Scott Wood <oss@buserror.net>
> > > 
> > As discussed before, please don't introduce yet another vendor specific
> > way to match a SoC ID from a device driver.
> > 
> > I've posted a patch for an extension to the soc_device infrastructure
> > to allow comparing the running SoC to a table of devices, use that
> > instead.
> 
> As I asked before, in which relevant maintainership capacity are you NACKing
> this?

I don't know why that's important, but I suggested the creation of
drivers/soc/ as a place to have a more general place for platform
specific drivers as part of being maintainer for arm-soc, and
almost all changes to drivers/soc go through our tree.

Olof does about half the merges, but I do the majority of the reviews
for drivers/soc patches. See also

git log --graph --format="%an %s" --merges drivers/soc/ 

	Arnd
