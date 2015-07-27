Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0111.outbound.protection.outlook.com [65.55.169.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 488401A0631
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 06:39:19 +1000 (AEST)
Message-ID: <1438012638.2993.289.camel@freescale.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-esdhc: add workaround for T4240
 incorrect HOSTVER value
From: Scott Wood <scottwood@freescale.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Yangbo Lu <yangbo.lu@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, linux-mmc <linux-mmc@vger.kernel.org>
Date: Mon, 27 Jul 2015 10:57:18 -0500
In-Reply-To: <CAPDyKFp8ZStYVaFm8tjPL190dqV6vCE+oT706M=6wVCckWesLw@mail.gmail.com>
References: <1437471937-34218-1-git-send-email-yangbo.lu@freescale.com>
 <CAPDyKFpf6Ayw28dmbHhLJ8HSOSie60sUjaAnK7qqONHsRN4BDA@mail.gmail.com>
 <1437791242.2993.268.camel@freescale.com>
 <CAPDyKFp8ZStYVaFm8tjPL190dqV6vCE+oT706M=6wVCckWesLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-27 at 09:58 +0200, Ulf Hansson wrote:
> On 25 July 2015 at 04:27, Scott Wood <scottwood@freescale.com> wrote:
> > On Tue, 2015-07-21 at 15:02 +0200, Ulf Hansson wrote:
> > > On 21 July 2015 at 11:45, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> > > > For T4240-R1.0-R2.0, the HOSTVER register has incorrcet vender
> > > > version value and sdhc spec version value. This will break down
> > > > the ADMA data transfer. So add workaround to get right value
> > > > VVN=0x13, SVN = 0x1.
> > > 
> > > So T4240-R1.0-R2.0 is the version of the controller, right?
> > > 
> > > If I understand correct you are checking what CPU/SoC you are running
> > > on, to figure out which controller version you are using, as that
> > > can't be fetched (trusted) from the registers of the esdhc controller
> > > itself!?
> > > 
> > > Instead, you could deal with this directly in the DTS files. I assume
> > > you have some DTS file for each SoC/board variant, right?
> > 
> > No, we do not have a separate DTS file for each revision of an SoC -- and 
> > if
> > we did, we'd constantly have people using the wrong one.
> > 
> > > In principle, in your DTS file specific for the board/SoC that holds
> > > the T4240-R1.0-R2.0 version of the controller, should add a specific
> > > esdhc DT property to indicate this errata.
> > 
> > No, because (in addition to the above issue about chip revisions) the 
> > device
> > tree is stable ABI and errata are often discovered after device trees are
> > deployed.
> 
> Fair enough. Then what is your suggestion for the solution here?

As I said in my comment on patch 2/3, read SVR from the device-config/guts 
MMIO block, which works on both PPC and ARM.

-Scott
