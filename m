Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by lists.ozlabs.org (Postfix) with ESMTP id DA7151A0016
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 20:12:58 +1000 (EST)
Date: Fri, 27 Jun 2014 11:12:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] mmc: sdhci: host: add new f_sdh30
Message-ID: <20140627101248.GD7262@leverpostej>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1403763812-5495-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20140626110351.GN15240@leverpostej>
 <CAOEd-H3+MwT3DMqMO0XHaZQqYAN0zaQqRMjC_UjyJn5ZwCaMoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOEd-H3+MwT3DMqMO0XHaZQqYAN0zaQqRMjC_UjyJn5ZwCaMoQ@mail.gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "andy.green@linaro.org" <andy.green@linaro.org>,
 "patches@linaro.org" <patches@linaro.org>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "chris@printf.net" <chris@printf.net>,
 "Vincent.Yang@tw.fujitsu.com" <Vincent.Yang@tw.fujitsu.com>,
 "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 27, 2014 at 04:32:21AM +0100, Vincent Yang wrote:
> 2014-06-26 19:03 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> > On Thu, Jun 26, 2014 at 07:23:30AM +0100, Vincent Yang wrote:
> >> This patch adds new host controller driver for
> >> Fujitsu SDHCI controller f_sdh30.
> >>
> >> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> >> ---
> >>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 +++
> >>  drivers/mmc/host/Kconfig                           |   7 +
> >>  drivers/mmc/host/Makefile                          |   1 +
> >>  drivers/mmc/host/sdhci_f_sdh30.c                   | 346 +++++++++++++++++++++
> >>  drivers/mmc/host/sdhci_f_sdh30.h                   |  40 +++
> >>  5 files changed, 429 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> >>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
> >>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> >> new file mode 100644
> >> index 0000000..40add438
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> >> @@ -0,0 +1,35 @@
> >> +* Fujitsu SDHCI controller
> >> +
> >> +This file documents differences between the core properties in mmc.txt
> >> +and the properties used by the sdhci_f_sdh30 driver.
> >> +
> >> +Required properties:
> >> +- compatible: "fujitsu,f_sdh30"
> >
> > Please use '-' rather than '_' in compatible strings.
> 
> Hi Mark,
> Yes, I'll update it to '-' in next version.
> 
> >
> > This seems to be the name of the driver. What is the precise name of the
> > IP block?
> 
> The name of the IP block is "F_SDH30".
> That's why it uses "fujitsu,f_sdh30"

Hmm. I'd still be tempted to use "fujitsu,f-sdh30".

> >
> > [...]
> >
> >> +       if (!of_property_read_u32(pdev->dev.of_node, "vendor-hs200",
> >> +                                 &priv->vendor_hs200))
> >> +               dev_info(dev, "Applying vendor-hs200 setting\n");
> >> +       else
> >> +               priv->vendor_hs200 = 0;
> >
> > This wasn't in the binding document, and a grep for "vendor-hs200" in a
> > v3.16-rc2 tree found me nothing.
> >
> > Please document this.
> 
> Yes, it is a setting for a vendor specific register.
> I'll update it in next version.

It would be nice to know exactly what this is. We usually shy clear of
placing register values in dt. I can wait until the next posting if
you're goin to document that.

> >> +       if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width)) {
> >> +               if (bus_width == 8) {
> >> +                       dev_info(dev, "Applying 8 bit bus width\n");
> >> +                       host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> >> +               }
> >> +       }
> >
> > What if bus-width is not 8, or is not present?
> 
> In both cases, it will not touch host->mmc->caps at all. Then sdhci_add_host()
> will handle it and set MMC_CAP_4_BIT_DATA as default:
> 
> [...]
> /*
> * A controller may support 8-bit width, but the board itself
> * might not have the pins brought out.  Boards that support
> * 8-bit width must set "mmc->caps |= MMC_CAP_8_BIT_DATA;" in
> * their platform code before calling sdhci_add_host(), and we
> * won't assume 8-bit width for hosts without that CAP.
> */
> if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> mmc->caps |= MMC_CAP_4_BIT_DATA;

Ok, but does it make sense for a dts to have:

	bus-width = <1>;

If so, we should presumably do something.

If not, we should at least print a warning that the dtb doesn't make
sense.

Cheers,
Mark.
