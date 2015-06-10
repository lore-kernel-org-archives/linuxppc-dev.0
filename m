Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C5C11A0F00
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 12:02:16 +1000 (AEST)
Message-ID: <1433901720.2477.105.camel@freescale.com>
Subject: Re: [PATCH v3] powerpc/cache: add cache flush operation for various
 e500
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao
 Chenhui-B35336" <chenhui.zhao@freescale.com>, Tang Yuantian
 <Yuantian.Tang@feescale.com>
Date: Tue, 9 Jun 2015 21:02:00 -0500
In-Reply-To: <DM2PR03MB574243DF3299029B2E67C97FABD0@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1433814827-10431-1-git-send-email-Yuantian.Tang@freescale.com>
 ,<1433888900.2477.104.camel@freescale.com>
 <DM2PR03MB574243DF3299029B2E67C97FABD0@DM2PR03MB574.namprd03.prod.outlook.com>
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

On Tue, 2015-06-09 at 21:00 -0500, Tang Yuantian-B29983 wrote:
> Please see my replay inline.
> ________________________________________
> From: Wood Scott-B07421
> Sent: Wednesday, June 10, 2015 6:28 AM
> To: Tang Yuantian-B29983
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; 
> linux-kernel@vger.kernel.org; Zhao Chenhui-B35336; Tang Yuantian
> Subject: Re: [PATCH v3] powerpc/cache: add cache flush operation for 
> various e500
> 
> On Tue, 2015-06-09 at 09:53 +0800,  Yuantian.Tang@freescale.comwrote:
> > From: Tang Yuantian <Yuantian.Tang@freescale.com>
> > 
> > Various e500 core have different cache architecture, so they
> > need different cache flush operations. Therefore, add a callback
> > function cpu_flush_caches to the struct cpu_spec. The cache flush
> > operation for the specific kind of e500 is selected at init time.
> > The callback function will flush all caches inside the current cpu.
> > 
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > Signed-off-by: Tang Yuantian <Yuantian.Tang@feescale.com>
> > ---
> > v3:
> >       - change all flush_caches to cpu_down_flush
> >       - replace whitespace with tab
> [snip]
>                 .cpu_setup              = __setup_cpu_e500v2,
> >               .machine_check          = machine_check_e500,
> >               .platform               = "ppc8548",
> > +             .cpu_down_flush = cpu_down_flush_e500v2,
> 
> It's still not lined up.  I'm not a fan of the "line up all the ="
> style, as it's a pain to maintain (and can be harder to read if the 
> "="
> is too far to the right), but mixing the two is worse.
> 
> [Yuantian]:
> I need more clear about this.
> The only difference here is that my function puts ONE tab before "=" 
> and ONE white space after "="; 
> but the other functions in this structure use TWO tabs before "=".  
> Is that what you want?

The existing code aligns all the "=" characters (using whatever number 
of tabs before "=" are required to accomplish that).  Yours doesn't.

-Scott
