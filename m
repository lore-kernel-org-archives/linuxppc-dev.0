Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD7E02C0253
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 08:49:55 +1000 (EST)
Message-ID: <520EAC8D.5080802@wwwdotorg.org>
Date: Fri, 16 Aug 2013 16:49:49 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
 <20130814032658.GA16915@S2101-09.ap.freescale.net>
 <20130814053016.GF31651@MrMyself>
 <20130814063931.GB31141@S2101-09.ap.freescale.net>
 <20130814063444.GG31651@MrMyself>
 <20130814081445.GC31141@S2101-09.ap.freescale.net>
 <520BA687.4030905@wwwdotorg.org> <20130815021823.GA1846@MrMyself>
 <20130815092428.GI16915@S2101-09.ap.freescale.net>
In-Reply-To: <20130815092428.GI16915@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 linuxppc-dev@lists.ozlabs.org, Nicolin Chen <b42378@freescale.com>,
 timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org,
 p.zabel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2013 03:24 AM, Shawn Guo wrote:
> On Thu, Aug 15, 2013 at 10:18:23AM +0800, Nicolin Chen wrote:
>> Hi Stephen,
>>
>> On Wed, Aug 14, 2013 at 09:47:19AM -0600, Stephen Warren wrote:
>>> If the clock source name list is different, then it needs a different
>>> compatible value, so that each compatible value can specify which clock
>>> names are required.
>>>
>>> Also, the compatible value itself should always include the exact HW
>>> that's present (most specific HW version), as well as any other HW it's
>>> compatible with.
>>  
>> Thank you for the comments. Yes, I did so in v1-v3, but after rethinking
>> about the situation (Actually both the HW version and the clock mux itself
>> are same, just the clock sources connecting to the mux might be different),
>> so I decided to do this by abstracting the driver from those source info
>> and letting DT binding to pass such information. Because I think putting 
>> the clock sources into the driver differed by compatible value would make
>> the driver more like SoC-specified, not the ideal way -- SoC-independent,
>> since the clock sources are based on SoC design, not on itself.
> 
> +1
> 
> It's pretty much the differences at SoC integration level not the IP
> itself, and it just happens to be handled in a register of the IP.

OK, if the difference are the sources of the clocks and not the set of
clocks, then there's no issue. I can't remember what triggered my
comments above, but obviously it wasn't clear that this was the case.
