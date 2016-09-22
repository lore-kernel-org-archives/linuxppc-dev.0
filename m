Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sg6Hb5nZWzDskv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 05:38:51 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id w84so15731643wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 12:38:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB11857AE8D2B0BE56121B97D391C90@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1469425427-33883-1-git-send-email-qiang.zhao@nxp.com>
 <1469425427-33883-2-git-send-email-qiang.zhao@nxp.com>
 <CADRPPNQaPjA1qBab-cRa1Yqmf5h53MPyC0OojO46btBuBjEhfA@mail.gmail.com>
 <AM3PR04MB11858157D9D1455AD49DBF6291F60@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <CADRPPNTJGSrNskUVz1xMmbXWGwyEAJ_toW+kHy3_JJTvxeq6gA@mail.gmail.com>
 <AM3PR04MB11857AE8D2B0BE56121B97D391C90@AM3PR04MB1185.eurprd04.prod.outlook.com>
From: Leo Li <pku.leo@gmail.com>
Date: Thu, 22 Sep 2016 14:38:48 -0500
Message-ID: <CADRPPNQ5qSy5KKe1KFd0cqcaJHHqjxmUHDs4DvzLOKs9r0fPzQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] QE: remove PPCisms for QE
To: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, "X.B. Xie" <xiaobo.xie@nxp.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 21, 2016 at 8:43 PM, Qiang Zhao <qiang.zhao@nxp.com> wrote:
> On Mon, Sep 22, 2016 at 2:19 AM, Leo Li wrote:
>> -----Original Message-----
>> From: Leo Li [mailto:pku.leo@gmail.com]
>> Sent: Thursday, September 22, 2016 2:19 AM
>> To: Qiang Zhao <qiang.zhao@nxp.com>
>> Cc: Scott Wood <oss@buserror.net>; linuxppc-dev <linuxppc-
>> dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>; X.B. Xie
>> <xiaobo.xie@nxp.com>
>> Subject: Re: [PATCH v5 2/2] QE: remove PPCisms for QE
>>
>> On Tue, Sep 20, 2016 at 8:13 PM, Qiang Zhao <qiang.zhao@nxp.com> wrote:
>> > On Mon, Sep 20, 2016 at 4:13 AM, Leo Li wrote:
>> >> -----Original Message-----
>> >> From: Leo Li [mailto:pku.leo@gmail.com]
>> >> Sent: Tuesday, September 20, 2016 4:13 AM
>> >> To: Qiang Zhao <qiang.zhao@nxp.com>
>> >> Cc: Scott Wood <oss@buserror.net>; linuxppc-dev <linuxppc-
>> >> dev@lists.ozlabs.org>; lkml <linux-kernel@vger.kernel.org>; X.B. Xie
>> >> <xiaobo.xie@nxp.com>
>> >> Subject: Re: [PATCH v5 2/2] QE: remove PPCisms for QE
>> >>
>> >> On Mon, Jul 25, 2016 at 12:43 AM, Zhao Qiang <qiang.zhao@nxp.com>
>> wrote:
>> >> > QE was supported on PowerPC, and dependent on PPC, Now it is
>> >> > supported on other platforms. so remove PPCisms.
>> >> >
>> >> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
>> >> > ---
>> >> > Changes for v2:
>> >> >         - na
>> >> > Changes for v3:
>> >> >         - add NO_IRQ
>> >> > Changes for v4:
>> >> >         - modify spin_event_timeout to opencoded timeout loop
>> >> >         - remove NO_IRQ
>> >> >         - modify virq_to_hw to opencoed code Changes for v5:
>> >> >         - modify commit msg
>> >> >         - modify depends of QUICC_ENGINE
>> >> >         - add kerneldoc header for qe_issue_cmd
>> >> >
>> >> >  drivers/irqchip/qe_ic.c       | 28 +++++++++------
>> >> >  drivers/soc/fsl/qe/Kconfig    |  2 +-
>> >> >  drivers/soc/fsl/qe/qe.c       | 80 ++++++++++++++++++++++++++----------
>> ----
>> >> ---
>> >> >  drivers/soc/fsl/qe/qe_io.c    | 42 ++++++++++-------------
>> >> >  drivers/soc/fsl/qe/qe_tdm.c   |  8 ++---
>> >> >  drivers/soc/fsl/qe/ucc.c      | 10 +++---
>> >> >  drivers/soc/fsl/qe/ucc_fast.c | 68 ++++++++++++++++++------------------
>> >> >  include/soc/fsl/qe/qe.h       |  1 -
>> >> >  include/soc/fsl/qe/qe_ic.h    | 12 +++----
>> >> >  9 files changed, 133 insertions(+), 118 deletions(-)
>> >> >
>> >>
>> >> [snip]
>> >>
>> >> > diff --git a/drivers/soc/fsl/qe/Kconfig
>> >> > b/drivers/soc/fsl/qe/Kconfig index 73a2e08..b26b643 100644
>> >> > --- a/drivers/soc/fsl/qe/Kconfig
>> >> > +++ b/drivers/soc/fsl/qe/Kconfig
>> >> > @@ -4,7 +4,7 @@
>> >> >
>> >> >  config QUICC_ENGINE
>> >> >         bool "Freescale QUICC Engine (QE) Support"
>> >> > -       depends on FSL_SOC && PPC32
>> >> > +       depends on OF && HAS_IOMEM
>> >> >         select GENERIC_ALLOCATOR
>> >> >         select CRC32
>> >> >         help
>> >>
>> >> You make it possible to build QE drivers on ARM, but the UCC_GETH
>> >> fails to build on arm64.  Please make sure all these drivers can
>> >> build on other architectures.  Or you can simply make them only build
>> >> for Power architecture as most of them are not available on ARM.
>> >>
>> >
>> > Most of them are not available on ARM and ARM64.
>> > Now, only qe-hdlc is available on ARM64.
>>
>> Then you should update the Kconfig for these drivers too, if they are only
>> depending on CONFIG_QUICC_ENGINE.
>
> You mean adding "depends on FSL_SOC && PPC32 " to the drivers that are not available for ARM?

Yes.  Previously these drivers get the architecture limitation from
CONFIG_QUICC_ENGINE, but now they need them by their own.

Regards,
Leo
