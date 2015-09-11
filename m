Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E18C1A0066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 12:05:32 +1000 (AEST)
Message-ID: <1441937116.2909.36.camel@freescale.com>
Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Thu, 10 Sep 2015 21:05:16 -0500
In-Reply-To: <SN1PR0301MB1550DA987B6F8F249BF255679B500@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
 <1441011520-15424-2-git-send-email-qiang.zhao@freescale.com>
 <1441154062.4966.113.camel@freescale.com>
 <SN1PR0301MB1550873B24F8F9F4760F67049B550@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1441816715.29081.8.camel@freescale.com>
 <SN1PR0301MB1550D133A4FE7FE3DB8870D19B510@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1441922945.2909.12.camel@freescale.com>
 <SN1PR0301MB1550DA987B6F8F249BF255679B500@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Thu, 2015-09-10 at 20:59 -0500, Zhao Qiang-B45475 wrote:
> On Mon, 2015-09-11 at 06:09 -0500, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, September 11, 2015 6:09 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage
> > muram
> > 
> > On Wed, 2015-09-09 at 21:34 -0500, Zhao Qiang-B45475 wrote:
> > > On Mon, 2015-09-10 at 12:39 -0500, Wood Scott-B07421 wrote:
> > > 
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Thursday, September 10, 2015 12:39 AM
> > > > To: Zhao Qiang-B45475
> > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org;
> > > > Li Yang-Leo-R58472; paulus@samba.org
> > > > Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions to
> > > > manage muram
> > > > 
> > > > On Sun, 2015-09-06 at 01:37 -0500, Zhao Qiang-B45475 wrote:
> > > > > On Mon, 2015-09-2 at 8:34 +0800, Wood Scott-B07421 wrote:
> > > > > > -----Original Message-----
> > > > > > From: Wood Scott-B07421
> > > > > > Sent: Wednesday, September 02, 2015 8:34 AM
> > > > > > To: Zhao Qiang-B45475
> > > > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > > > lauraa@codeaurora.org; Xie Xiaobo-R63061;
> > > > > > benh@kernel.crashing.org; Li Yang-Leo-R58472; paulus@samba.org
> > > > > > Subject: Re: [PATCH V7 2/3] qe_common: add qe_muram_ functions
> > > > > > to manage muram
> > > > > > 
> > > > > > On Mon, 2015-08-31 at 16:58 +0800, Zhao Qiang wrote:
> > > > > > 
> > > > > > > @@ -187,12 +190,25 @@ static inline int
> > > > > > > qe_alive_during_sleep(void)  }
> > > > > > > 
> > > > > > >  /* we actually use cpm_muram implementation, define this for
> > > > > > > convenience */ -#define qe_muram_init cpm_muram_init -#define
> > > > > > > qe_muram_alloc cpm_muram_alloc -#define qe_muram_alloc_fixed
> > > > > > > cpm_muram_alloc_fixed -#define qe_muram_free cpm_muram_free
> > > > > > > -#define qe_muram_addr cpm_muram_addr -#define qe_muram_offset
> > > > > > > cpm_muram_offset
> > > > > > > +#define cpm_muram_init qe_muram_init #define cpm_muram_alloc
> > > > > > > +qe_muram_alloc #define cpm_muram_alloc_fixed
> > > > > > > +qe_muram_alloc_fixed #define cpm_muram_free qe_muram_free
> > > > > > > +#define cpm_muram_addr qe_muram_addr #define cpm_muram_offset
> > > > > > > +qe_muram_offset
> > > > > > 
> > > > > > Why?  This is unnecessary churn.
> > > > > > 
> > > > > This is necessary. QE is on both ARM and PowerPC, its code is
> > > > > under public code.
> > > > > But CPM is only on PowerPC and its code is under PowerPC.
> > > > > So when build ARM, QE will not find cpm_muram_* function.
> > > > 
> > > > If you move the cpm_muram functions to drivers/soc, then ARM will
> > > > find them.
> > > > There is no need to rename them.
> > > 
> > > Yes, moving cpm_muram can handle this issue. However, cpm is not
> > > necessary To move to public code, and a churn is simpler than moving
> > cpm_muram.
> > > Please consider my suggestion, Thank you!
> > 
> > What do you mean by "public code"?  You're already moving cpm_muram.  I'm
> > just asking that you not rename it while you do so.  If it absolutely
> > must be renamed, do it in a different patch from the one that moves the
> > code, though I don't see why the rename is helpful.
> 
> "Public code" is "driver/soc" here. I moved the qe_muram into driver/soc, 
> not cpm_muram,

They are the same thing.

> And the functions are named qe_muram_*, 

Only after you renamed them.  Before that they were just #defined aliases.

> and removed cpm_muram_*, let cpm_muram
> Use the same functions code with qe_muram, and define cpm_muram_* 
> qe_muram_*. 
> 
> Previously, cpm/qe-muram functions are named cpm_muram_* because CPM is the 
> predecessor
> Of QE,

Yes, and just because marketing decided they wanted to change the name when 
they came out with a new version doesn't mean we need to rename 
infrastructure that is common between them.  E.g. we still classify PPC QorIQ 
chips as "mpc85xx".

Again, if you really want to do the rename, at least do it in a separate 
patch from moving the code, so that git will detect the code movement and we 
can see if anything else changed during the move.

-Scott
