Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3qPx20s2zDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 07:40:53 +1000 (AEST)
Message-ID: <1470174043.25630.233.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Yangbo Lu <yangbo.lu@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>
Date: Tue, 02 Aug 2016 16:40:43 -0500
In-Reply-To: <HE1PR04MB0889EE0A961723541F9904A1F8050@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <1468723822-30457-5-git-send-email-oss@buserror.net>
 <4016699.uYaV8nWfqC@wuerfel> <1469039508.25630.17.camel@buserror.net>
 <146909676646.16700.8383344640490662952@concordia>
 <1469119526.25630.42.camel@buserror.net>
 <HE1PR04MB088913D39528958C6905D43DF80D0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <1469579882.25630.168.camel@buserror.net>
 <HE1PR04MB0889EE0A961723541F9904A1F8050@HE1PR04MB0889.eurprd04.prod.outlook.com>
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

On Tue, 2016-08-02 at 05:57 +0000, Yangbo Lu wrote:
> Hi Scott,
> 
> > 
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Wednesday, July 27, 2016 8:38 AM
> > To: Yangbo Lu; Michael Ellerman; Arnd Bergmann; Ulf Hansson
> > Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to
> > include/linux/fsl
> > 
> > On Mon, 2016-07-25 at 06:12 +0000, Yangbo Lu wrote:
> > > 
> > > Hi Scott,
> > > 
> > > 
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Scott Wood [mailto:oss@buserror.net]
> > > > Sent: Friday, July 22, 2016 12:45 AM
> > > > To: Michael Ellerman; Arnd Bergmann
> > > > Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linuxppc-
> > > > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Yangbo Lu
> > > > Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to
> > > > include/linux/fsl
> > > > 
> > > > On Thu, 2016-07-21 at 20:26 +1000, Michael Ellerman wrote:
> > > > > 
> > > > > 
> > > > > Quoting Scott Wood (2016-07-21 04:31:48)
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > From: yangbo lu <yangbo.lu@nxp.com>
> > > > > > > > 
> > > > > > > > Move mpc85xx.h to include/linux/fsl and rename it to svr.h
> > > > > > > > as a common header file.  This SVR numberspace is used on
> > > > > > > > some ARM chips as well as PPC, and even to check for a PPC
> > > > > > > > SVR multi-arch drivers would otherwise need to ifdef the
> > > > > > > > header inclusion and all references to the SVR symbols.
> > > > > > > > 
> > > > > > > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > > > > > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > > > > > > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > > > > > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > > > > > > > [scottwood: update description]
> > > > > > > > Signed-off-by: Scott Wood <oss@buserror.net>
> > > > > > > > 
> > > > > > > As discussed before, please don't introduce yet another vendor
> > > > > > > specific way to match a SoC ID from a device driver.
> > > > > > > 
> > > > > > > I've posted a patch for an extension to the soc_device
> > > > > > > infrastructure to allow comparing the running SoC to a table
> > > > > > > of devices, use that instead.
> > > > > > As I asked before, in which relevant maintainership capacity are
> > > > > > you NACKing this?
> > > > > I'll nack the powerpc part until you guys can agree.
> > > > OK, I've pulled these patches out.
> > > > 
> > > > For the MMC issue I suggest using ifdef CONFIG_PPC and
> > > > mfspr(SPRN_SVR) like the clock driver does[1] and we can revisit the
> > > > issue if/when we need to do something similar on an ARM chip.
> > > [Lu Yangbo-B47093] I remembered that Uffe had opposed us to introduce
> > > non- generic header files(like '#include <asm/mpc85xx.h>') in mmc
> > > driver initially. So I think it will not be accepted to use ifdef
> > > CONFIG_PPC and mfspr(SPRN_SVR)...
> > > And this method still couldn’t get SVR of ARM chip now.
> > Right, as I said we'll have to revisit the issue if/when we have the same
> > problem on an ARM chip.  That also applies if the PPC ifdef is still
> > getting NACKed from the MMC side.
> [Lu Yangbo-B47093] It's not clear for me about your idea :( 
> Do you mean we can still use this method, or not ?
> I think Uffe had opposed to use ifdef CONFIG_PPC and mfspr(SPRN_SVR).
> Is there any solution to resolve ?
> :)

As I said, I'm OK with using the SPR.  It's up to you to find out whether it's
still unacceptable with the MMC maintainers given all the discussion (it would
be the quickest way to get the workaround enabled), or just go with the method
below.

> > > Any other suggestion here?
> > The other option is to try to come up with something that fits into
> > Arnd's framework while addressing the concerns I raised.  The soc_id
> > string should be well-structured to avoid mismatches and compatibility
> > problems (especially since it would get exposed to userspace).  Maybe
> > something like:
> > 
> > svr:<SVR minus E bit>,svre:<full SVR including E bit>,name:<soc
> > name>,die:<soc die name>,rev:X.Y,<tag1>,<tag2>,<...>,
> [Lu Yangbo-B47093] The soc_device_attribut struct is defined as below.
> struct soc_device_attribute {
>         const char *machine;
>         const char *family;
>         const char *revision;
>         const char *soc_id;
> };
> 
> We can put the 'model' in root node of dts as machine, put 'Freescale QorIQ'
> as family,

I'd just put "QorIQ" to avoid the question of whether to use "Freescale" or
"NXP".

> and put x.x as revision. Is it ok?
> As you suggested, you like to use below string as soc_id. It's easy to get
> svr, but how does the software know the name and die,
> and put them into this string ? It's a large code to define them. 

Yes, there would need to be a table in the guts driver for each SVR.  If the
SVR isn't found in the table then the soc_id would only contain the svr: and
svre: fields.

> > 
> > svr:<SVR minus E bit>,svre:<full SVR including E bit>,name:<soc
> > name>,die:<soc die name>,rev:X.Y,<tag1>,<tag2>,<...>,
> Should we remove rev here since there is also a revision member?

Yes, I forgot there was a revision field -- it should go there obviously.

> Regarding the guts_init, we still call guts_init and then match the soc, or
> we change to use platform driver?
> Or do you know any better place to call guts_init to initialize only once?

Use a platform driver for now.  If we ever need to check an ARM SVR in the
clock driver or similar place, then Arnd can explain what he wants us to do
then :-)

-Scott
