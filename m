Return-Path: <Jason.Jin@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C0390140084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 14:45:53 +1100 (EST)
From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH 1/2] video/fsl: make the diu driver work without
 platform hooks
Date: Thu, 27 Mar 2014 03:30:35 +0000
Message-ID: <f6883c3f759a4544936acec5dc7e542b@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <533320A0.8010507@tabi.org>
In-Reply-To: <533320A0.8010507@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On 03/26/2014 12:41 PM, Jason Jin wrote:
> > This board sepecific initialization mechanism is not feasible i for
> > corenet platform as the corenet platform file is a abstraction of
> > serveral platforms.
>=20
> You can't make it 100% abstract.  The DIU driver requires some sort of
> board support.  I think you can make a generic platform file for the DIU.
>=20
[Jason Jin-R64188] Provide the generic diu platform file is reasonable, but=
 it is will be just the board specific initialization file collection, if w=
e really need to reinitialize something in kernel.=20

> > However, the DIU is already initialized in u-boot and we can rely on
> > the settings in u-boot for corenet platform,
>=20
> I don't like that at all.
[Jason Jin-R64188] What's the potential issue of this? Most of the IPs need=
 the platform initialization in u-boot. For example, the hwconfig in u-boot=
 used for board specific settings for most platform.

The diu_ops structure is still open for any board specific initialization i=
f the platform needed. We at least can let the platform to select to use th=
e diu_ops or not. This is the purse for this patch.

>=20
> > the only
> > issue is that when DIU wake up from the deepsleep, some of the board
> > specific initialization will lost, such as the pixel clock setting.
>=20
> That is a BIG issue.  This is why we have a platform file -- to handle
> the platform issues.
[Jason Jin-R64188] Yes, this is an issue, Actually, this is a SOC level iss=
ue, We can try to fix it in the driver by saving the pixel clock in suspend=
 function and restored it in resume function.

Thanks.
