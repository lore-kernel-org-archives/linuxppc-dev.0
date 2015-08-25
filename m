Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0118.outbound.protection.outlook.com [207.46.100.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DA6C1A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 02:25:49 +1000 (AEST)
Message-ID: <1440519935.16577.7.camel@freescale.com>
Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Tue, 25 Aug 2015 11:25:35 -0500
In-Reply-To: <SN1PR0301MB1550A026A5C471382BB293A69B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
 <1440434073.30043.21.camel@freescale.com>
 <SN1PR0301MB1550A026A5C471382BB293A69B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Tue, 2015-08-25 at 02:52 -0500, Zhao Qiang-B45475 wrote:
> On Tue, 2015-08-25 at 12:35 +0800, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, August 25, 2015 12:35 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage
> > muram
> > 
> > On Mon, 2015-08-24 at 17:31 +0800, Zhao Qiang wrote:
> > 
> > > @@ -187,12 +190,41 @@ static inline int qe_alive_during_sleep(void)
> > >  }
> > > 
> > >  /* we actually use cpm_muram implementation, define this for
> > convenience */
> > > -#define qe_muram_init cpm_muram_init
> > > -#define qe_muram_alloc cpm_muram_alloc
> > > -#define qe_muram_alloc_fixed cpm_muram_alloc_fixed
> > > -#define qe_muram_free cpm_muram_free
> > > -#define qe_muram_addr cpm_muram_addr
> > > -#define qe_muram_offset cpm_muram_offset
> > > +int qe_muram_init(void);
> > > +
> > > +#if defined(CONFIG_QUICC_ENGINE)
> > > +unsigned long qe_muram_alloc(unsigned long size, unsigned long align);
> > > +int qe_muram_free(unsigned long offset);
> > > +void __iomem *qe_muram_addr(unsigned long offset);
> > > +unsigned long qe_muram_offset(void __iomem *addr);
> > > +dma_addr_t qe_muram_dma(void __iomem *addr);
> > > +#else
> > > +static inline unsigned long qe_muram_alloc(unsigned long size,
> > > +                                         unsigned long align)
> > > +{
> > > +     return -ENOSYS;
> > > +}
> > 
> > What code calls these functions without CONFIG_QUICC_ENGINE?
> > 
> > Are you converting qe without cpm?  Why?
> 
> CPM just work on PowerPC old boards, it is not necessary to convert it.  

I disagree.  Converting it would remove a user of rheap, and not converting 
it introduces code duplication.  The muram code is currently shared between 
CPM and QE, so converting it doesn't add much effort.

-Scott
