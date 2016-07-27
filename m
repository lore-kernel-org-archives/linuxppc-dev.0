Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzbgp0r6kzDqSY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:38:14 +1000 (AEST)
Message-ID: <1469579882.25630.168.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Yangbo Lu <yangbo.lu@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 26 Jul 2016 19:38:02 -0500
In-Reply-To: <HE1PR04MB088913D39528958C6905D43DF80D0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <1468723822-30457-5-git-send-email-oss@buserror.net>
 <4016699.uYaV8nWfqC@wuerfel> <1469039508.25630.17.camel@buserror.net>
 <146909676646.16700.8383344640490662952@concordia>
 <1469119526.25630.42.camel@buserror.net>
 <HE1PR04MB088913D39528958C6905D43DF80D0@HE1PR04MB0889.eurprd04.prod.outlook.com>
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

On Mon, 2016-07-25 at 06:12 +0000, Yangbo Lu wrote:
> Hi Scott,
> 
> 
> > 
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Friday, July 22, 2016 12:45 AM
> > To: Michael Ellerman; Arnd Bergmann
> > Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Yangbo Lu
> > Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to
> > include/linux/fsl
> > 
> > On Thu, 2016-07-21 at 20:26 +1000, Michael Ellerman wrote:
> > > 
> > > Quoting Scott Wood (2016-07-21 04:31:48)
> > > > 
> > > > 
> > > > On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> > > > > 
> > > > > 
> > > > > On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > From: yangbo lu <yangbo.lu@nxp.com>
> > > > > > 
> > > > > > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a
> > > > > > common header file.  This SVR numberspace is used on some ARM
> > > > > > chips as well as PPC, and even to check for a PPC SVR multi-arch
> > > > > > drivers would otherwise need to ifdef the header inclusion and
> > > > > > all references to the SVR symbols.
> > > > > > 
> > > > > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > > > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > > > > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > > > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > > > > > [scottwood: update description]
> > > > > > Signed-off-by: Scott Wood <oss@buserror.net>
> > > > > > 
> > > > > As discussed before, please don't introduce yet another vendor
> > > > > specific way to match a SoC ID from a device driver.
> > > > > 
> > > > > I've posted a patch for an extension to the soc_device
> > > > > infrastructure to allow comparing the running SoC to a table of
> > > > > devices, use that instead.
> > > > As I asked before, in which relevant maintainership capacity are you
> > > > NACKing this?
> > > I'll nack the powerpc part until you guys can agree.
> > OK, I've pulled these patches out.
> > 
> > For the MMC issue I suggest using ifdef CONFIG_PPC and mfspr(SPRN_SVR)
> > like the clock driver does[1] and we can revisit the issue if/when we
> > need to do something similar on an ARM chip.
> [Lu Yangbo-B47093] I remembered that Uffe had opposed us to introduce non-
> generic header files(like '#include <asm/mpc85xx.h>')
> in mmc driver initially. So I think it will not be accepted to use ifdef
> CONFIG_PPC and mfspr(SPRN_SVR)...
> And this method still couldn’t get SVR of ARM chip now.

Right, as I said we'll have to revisit the issue if/when we have the same
problem on an ARM chip.  That also applies if the PPC ifdef is still getting
NACKed from the MMC side.

> Any other suggestion here?

The other option is to try to come up with something that fits into Arnd's
framework while addressing the concerns I raised.  The soc_id string should be
well-structured to avoid mismatches and compatibility problems (especially
since it would get exposed to userspace).  Maybe something like:

svr:<SVR minus E bit>,svre:<full SVR including E bit>,name:<soc name>,die:<soc
die name>,rev:X.Y,<tag1>,<tag2>,<...>,

with the final comma used so that globs can put a colon on either end to be
sure they're matching a full field.  The SoC die name would be the primary
chip for a given die (e.g. p4040 would have a die name of p4080).  The "name"
and "die" fields would never include the trailing "e" indicated by the E bit.

Extra tags could be used for common groupings, such as all chips from a
particular die before a certain revision.  Once a tag is added it can't be
removed or reordered, to maintain userspace compatibility, but new tags could
be appended.

Some examples:

svr:0x82000020,svre:0x82000020,name:p4080,die:p4080,rev:2.0,
svr:0x82000020,svr
e:0x82080020,name:p4080,die:p4080,rev:2.0,
svr:0x82000030,svre:0x82000030,name:
p4080,die:p4080,rev:3.0,
svr:0x82000030,svre:0x82080030,name:p4080,die:p4080,re
v:3.0,
svr:0x82010020,svre:0x82010020,name:p4040,die:p4080,rev:2.0,
svr:0x820100
20,svre:0x82090020,name:p4040,die:p4080,rev:2.0,

svr:0x82010030,svre:0x82010030
,name:p4040,die:p4080,rev:3.0,
svr:0x82010030,svre:0x82090030,name:p4040,die:p4
080,rev:3.0,

Then if you want to apply a workaround on:
- all chips using the p4080 die, match with "*,die:p4080,*"
- all chips using the rev 2.0 p4080 die, match with "*,die:p4080,rev:2.0,*"
- Only p4040, but of any rev, match with "*,name:p4040,*"

Matching via open-coded hex number should be considered a last resort (it's
more error-prone, either for getting the number wrong or for forgetting
variants -- the latter is already a common problem), but preferable to adding
too many tags.

Using wildcards within a tag field would be discouraged.  

-Scott
