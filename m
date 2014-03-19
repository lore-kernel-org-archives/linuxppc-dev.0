Return-Path: <dan.j.williams@intel.com>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8B2F2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 02:43:56 +1100 (EST)
Received: by mail-vc0-f178.google.com with SMTP id im17so9588509vcb.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 08:43:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <30ef7093dcc247e490831a43355ec10f@BL2PR03MB147.namprd03.prod.outlook.com>
References: <1395131520-30207-1-git-send-email-xuelin.shi@freescale.com>
 <CAPcyv4gs-jos5TvfDbsaXTNebQf8VjJvbdjmjsbGZLZwZKi34g@mail.gmail.com>
 <30ef7093dcc247e490831a43355ec10f@BL2PR03MB147.namprd03.prod.outlook.com>
Date: Wed, 19 Mar 2014 08:43:52 -0700
Message-ID: <CAPcyv4imH14PuiZJwMw1B+UnxBgHzPAS22p4b171MrmKDBJM+Q@mail.gmail.com>
Subject: Re: [PATCH] fix dmaengine_unmap failure.
From: Dan Williams <dan.j.williams@intel.com>
To: Xuelin Shi <xuelin.shi@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vinod Koul <vinod.koul@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2014 at 11:39 PM, Xuelin Shi <xuelin.shi@freescale.com> wrote:
> Hi Dan,
>
> In async_mult(...) of async_raid6_recov.c, the count 3 is used to request an unmap.
> However the to_cnt and bidi_cnt are both set to 1 and from_cnt to 0.
> Then while trying to do unmap, we are getting the wrong "unmap" from a different mempool.
>
> In this patch, the mempool is associated with the unmap structure instead of computing it again.
> By this way, it is guaranteed that the unmap is the same when we get and put the unmap data.
>
> BTW: the mempool is just used to manage the struct unmap, not the pages.
>

I see, what about just storing the map_cnt at allocation time?  It
could be another byte in struct dmaengine_unmap_data rather than an 8
byte pointer.
