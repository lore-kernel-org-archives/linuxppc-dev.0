Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0115.outbound.protection.outlook.com [207.46.100.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 262D21A09A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 18:36:27 +1100 (AEDT)
Message-ID: <1445931372.701.327.camel@freescale.com>
Subject: Re: [PATCH v12 4/6] QE/CPM: move muram management functions to
 qe_common
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Tue, 27 Oct 2015 02:36:12 -0500
In-Reply-To: <SN1PR0301MB1550F9AB9D4FCC0F3D74E8CC9B220@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
 <1444806968-4627-4-git-send-email-qiang.zhao@freescale.com>
 <1445569799.701.142.camel@freescale.com>
 <SN1PR0301MB1550CC4F282309872FF5ACBD9B260@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1445633780.701.228.camel@freescale.com>
 <SN1PR0301MB155083232AD1076F0779F7A49B230@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1445921289.701.301.camel@freescale.com>
 <SN1PR0301MB1550974588581984B4146FB19B220@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1445928629.701.323.camel@freescale.com>
 <SN1PR0301MB1550F9AB9D4FCC0F3D74E8CC9B220@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Tue, 2015-10-27 at 02:34 -0500, Zhao Qiang-B45475 wrote:
> On Tue, Oct 27, 2015 at 2:50 PM, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, October 27, 2015 2:50 PM
> > To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061 <X.Xie@freescale.com>;
> > benh@kernel.crashing.org; Li Yang-Leo-R58472 <LeoLi@freescale.com>;
> > paulus@samba.org
> > Subject: Re: [PATCH v12 4/6] QE/CPM: move muram management functions to
> > qe_common
> > 
> > On Tue, 2015-10-27 at 01:24 -0500, Zhao Qiang-B45475 wrote:
> > > On Tue, Oct 27, 2015 at 12:48 PM, Wood Scott-B07421 wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Tuesday, October 27, 2015 12:48 PM
> > > > To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
> > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > lauraa@codeaurora.org; Xie Xiaobo-R63061 <X.Xie@freescale.com>;
> > > > benh@kernel.crashing.org; Li Yang-Leo-R58472 <LeoLi@freescale.com>;
> > > > paulus@samba.org
> > > > Subject: Re: [PATCH v12 4/6] QE/CPM: move muram management
> > functions
> > > > to qe_common
> > > > 
> > > > On Sun, 2015-10-25 at 21:42 -0500, Zhao Qiang-B45475 wrote:
> > > > > On Sat, Oct 24, 2015 at 04:56 AM, Wood Scott-B07421 wrote:
> > > > > > -----Original Message-----
> > > > > > From: Wood Scott-B07421
> > > > > > Sent: Saturday, October 24, 2015 4:56 AM
> > > > > > To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
> > > > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > > > lauraa@codeaurora.org; Xie Xiaobo-R63061 <X.Xie@freescale.com>;
> > > > > > benh@kernel.crashing.org; Li Yang-Leo-R58472
> > > > > > <LeoLi@freescale.com>; paulus@samba.org
> > > > > > Subject: Re: [PATCH v12 4/6] QE/CPM: move muram management
> > > > functions
> > > > > > to qe_common
> > > > > > 
> > > > > > On Fri, 2015-10-23 at 02:45 -0500, Zhao Qiang-B45475 wrote:
> > > > > > > On Fri, 2015-10-23 at 11:10 AM, Wood Scott-B07421
> > > > > > > <scottwood@freescale.com>
> > > > > > > wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: Wood Scott-B07421
> > > > > > > > Sent: Friday, October 23, 2015 11:10 AM
> > > > > > > > To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
> > > > > > > > Cc: linux-kernel@vger.kernel.org;
> > > > > > > > linuxppc-dev@lists.ozlabs.org; lauraa@codeaurora.org; Xie
> > > > > > > > Xiaobo-R63061 <X.Xie@freescale.com>;
> > > > > > > > benh@kernel.crashing.org; Li Yang-Leo-R58472
> > > > > > > > <LeoLi@freescale.com>; paulus@samba.org
> > > > > > > > Subject: Re: [PATCH v12 4/6] QE/CPM: move muram management
> > > > > > functions
> > > > > > > > to qe_common
> > > > > > > > 
> > > > > > So then why are you selecting QUICC_ENGINE?  And again, what
> > > > > > does it have to do with this patch?
> > > > > 
> > > > > Cpm-spi is dependent on qe_muram, if not select it, Cpm-spi will
> > > > > failed to build.
> > > > 
> > > > Why QUICC_ENGINE and not CPM?
> > > 
> > > QE and CPM use the same muram, and it has been moved to qe_muram
> > from
> > > cpm_muram.
> > 
> > Fix the makefiles so that the muram code continues to be built for both
> > QUICC_ENGINE and CPM.  It's not acceptable to have to bring in the entire 
> > QE
> > code just for the muram.
> > 
> How about to define and CONFIG_QE_MURAM in Kconfig for muram?

That's fine.

-Scott
