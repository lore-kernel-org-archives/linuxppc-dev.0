Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwKQn0XL5zDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 02:45:36 +1000 (AEST)
Message-ID: <1469119526.25630.42.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangbo Lu
 <yangbo.lu@nxp.com>
Date: Thu, 21 Jul 2016 11:45:26 -0500
In-Reply-To: <146909676646.16700.8383344640490662952@concordia>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <1468723822-30457-5-git-send-email-oss@buserror.net>
 <4016699.uYaV8nWfqC@wuerfel> <1469039508.25630.17.camel@buserror.net>
 <146909676646.16700.8383344640490662952@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-21 at 20:26 +1000, Michael Ellerman wrote:
> Quoting Scott Wood (2016-07-21 04:31:48)
> > 
> > On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> > > 
> > > On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > > > 
> > > > 
> > > > From: yangbo lu <yangbo.lu@nxp.com>
> > > > 
> > > > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> > > > header file.  This SVR numberspace is used on some ARM chips as well
> > > > as
> > > > PPC, and even to check for a PPC SVR multi-arch drivers would
> > > > otherwise
> > > > need to ifdef the header inclusion and all references to the SVR
> > > > symbols.
> > > > 
> > > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > > > [scottwood: update description]
> > > > Signed-off-by: Scott Wood <oss@buserror.net>
> > > > 
> > > As discussed before, please don't introduce yet another vendor specific
> > > way to match a SoC ID from a device driver.
> > > 
> > > I've posted a patch for an extension to the soc_device infrastructure
> > > to allow comparing the running SoC to a table of devices, use that
> > > instead.
> > As I asked before, in which relevant maintainership capacity are you
> > NACKing
> > this?
> I'll nack the powerpc part until you guys can agree.

OK, I've pulled these patches out.

For the MMC issue I suggest using ifdef CONFIG_PPC and mfspr(SPRN_SVR) like
the clock driver does[1] and we can revisit the issue if/when we need to do
something similar on an ARM chip.

-Scott

[1] One of the issues with Arnd's approach is that it wouldn't have worked for
early things like the clock driver, and he didn't seem to mind using ifdef and
mfspr() there.
