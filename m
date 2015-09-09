Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0103.outbound.protection.outlook.com [65.55.169.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 158571A2753
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 02:38:50 +1000 (AEST)
Message-ID: <1441816715.29081.8.camel@freescale.com>
Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Wed, 9 Sep 2015 11:38:35 -0500
In-Reply-To: <SN1PR0301MB1550873B24F8F9F4760F67049B550@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
 <1441011520-15424-2-git-send-email-qiang.zhao@freescale.com>
 <1441154062.4966.113.camel@freescale.com>
 <SN1PR0301MB1550873B24F8F9F4760F67049B550@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Sun, 2015-09-06 at 01:37 -0500, Zhao Qiang-B45475 wrote:
> On Mon, 2015-09-2 at 8:34 +0800, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 02, 2015 8:34 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage
> > muram
> > 
> > On Mon, 2015-08-31 at 16:58 +0800, Zhao Qiang wrote:
> > 
> > > @@ -187,12 +190,25 @@ static inline int qe_alive_during_sleep(void)  }
> > > 
> > >  /* we actually use cpm_muram implementation, define this for
> > > convenience */ -#define qe_muram_init cpm_muram_init -#define
> > > qe_muram_alloc cpm_muram_alloc -#define qe_muram_alloc_fixed
> > > cpm_muram_alloc_fixed -#define qe_muram_free cpm_muram_free -#define
> > > qe_muram_addr cpm_muram_addr -#define qe_muram_offset cpm_muram_offset
> > > +#define cpm_muram_init qe_muram_init
> > > +#define cpm_muram_alloc qe_muram_alloc #define cpm_muram_alloc_fixed
> > > +qe_muram_alloc_fixed #define cpm_muram_free qe_muram_free #define
> > > +cpm_muram_addr qe_muram_addr #define cpm_muram_offset qe_muram_offset
> > 
> > Why?  This is unnecessary churn.
> > 
> This is necessary. QE is on both ARM and PowerPC, its code is under public 
> code.
> But CPM is only on PowerPC and its code is under PowerPC.
> So when build ARM, QE will not find cpm_muram_* function.

If you move the cpm_muram functions to drivers/soc, then ARM will find them.  
There is no need to rename them.

-Scott
