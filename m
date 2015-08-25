Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F0331A039D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 02:23:10 +1000 (AEST)
Message-ID: <1440519775.16577.4.camel@freescale.com>
Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: Laura Abbott <labbott@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "lauraa@codeaurora.org"
 <lauraa@codeaurora.org>, Xie Xiaobo-R63061 <X.Xie@freescale.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Li Yang-Leo-R58472
 <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Date: Tue, 25 Aug 2015 11:22:55 -0500
In-Reply-To: <SN1PR0301MB1550CE6B922CE64AA4F862759B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
 <55DBA98D.1070202@redhat.com>
 <SN1PR0301MB1550C9087AFB9FEB6CD1B0899B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <55DBEBBE.30702@redhat.com>
 <SN1PR0301MB1550CE6B922CE64AA4F862759B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Tue, 2015-08-25 at 02:19 -0500, Zhao Qiang-B45475 wrote:
> On 08/25/2015 12:15 PM, Laura Abbott wrote
> > -----Original Message-----
> > From: Laura Abbott [mailto:labbott@redhat.com]
> > Sent: Tuesday, August 25, 2015 12:15 PM
> > To: Zhao Qiang-B45475; Wood Scott-B07421
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage
> > muram
> > 
> > On 08/24/2015 08:03 PM, Zhao Qiang wrote:
> > > 
> > > > -----Original Message-----
> > > > From: Laura Abbott [mailto:labbott@redhat.com]
> > > > Sent: Tuesday, August 25, 2015 7:32 AM
> > > > To: Zhao Qiang-B45475; Wood Scott-B07421
> > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org;
> > > > Li Yang-Leo-R58472; paulus@samba.org
> > > > Subject: Re: [PATCH v6 3/3] qe_common: add qe_muram_ functions to
> > > > manage muram
> > > > 
> > > > There doesn't seem to be a check for allocation failure from the
> > > > gen_alloc.
> > > 
> > > gen_pool_alloc will return 0 if there is error, but if the address
> > > returned is just 0x0, it can't distinguish it is address or error.
> > > 
> > 
> > Yes, that's a bad limitation of gen_pool. Maybe one day that will get
> > fixed.
> > In a previous out of tree driver, I worked around this by offsetting the
> > gen_pool_add by a constant so any return value was non-zero and out of
> > memory was zero and then subtracting the constant off of the return value.
> > Not sure if that's better or worse than just fixing gen_alloc.
> > 
> 
> The workaround works for non alignment allocation, but for alignment 
> allocation,
> It need to align bytes to addr 0, offsetting the gen_pool_add maybe make 
> wrong alignment

It would work if the offset you add is a multiple of the size of muram.

-Scott
