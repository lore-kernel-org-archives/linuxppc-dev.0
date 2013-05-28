Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 57AF92C0335
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 09:15:04 +1000 (EST)
Message-ID: <1369782894.21216.25.camel@smoke>
Subject: Re: [PATCH 20/21] powerpc/ps3: remove inline marking of
 EXPORT_SYMBOL functions
From: Geoff Levand <geoff@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 May 2013 16:14:54 -0700
In-Reply-To: <CAMuHMdUU5+WJnYER8kO2Ne2iaBQESYp_bbBMTLDvTEJchDu15A@mail.gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
 <1368095819-11011-9-git-send-email-yefremov.denis@gmail.com>
 <CAMuHMdUU5+WJnYER8kO2Ne2iaBQESYp_bbBMTLDvTEJchDu15A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ldv-project@linuxtesting.org, Jiri Kosina <trivial@kernel.org>,
 Denis Efremov <yefremov.denis@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geert,

On Fri, 2013-05-17 at 18:05 +0200, Geert Uytterhoeven wrote:
> On Thu, May 9, 2013 at 12:36 PM, Denis Efremov <yefremov.denis@gmail.com> wrote:
> > -inline u64 ps3_get_spe_id(void *arg)
> > +u64 ps3_get_spe_id(void *arg)
> >  {
> >         return spu_pdata(arg)->spe_id;
> >  }
> 
> FYI, this symbol is not used in mainline.
> 
> IIRC, it's used for profiling only. Any chance the profile code will
> ever make it
> in mainline?

As I announced (below), I dropped the profiling patches since
ps3-queue-v3.8.

The profiling code does not use ps3_get_spe_id(), so I think we should
remove it.  I'll submit a patch.

-Geoff

-------- Forwarded Message --------
From: Geoff Levand <geoff@infradead.org>
To: cbe-oss-dev@lists.ozlabs.org
Subject: Dropping PS3 oprofile support in v3.8
Date: Wed, 13 Feb 2013 17:30:39 -0800

Hi All,

I'll be dropping the PS3 oprofile patches from my ps3-linux git tree
from linux-3.8.  These are the patches: 

 7f02610 ps3-debugging: Add oprofile test script
 49213b6 powerpc/ps3: PS3 oprofile support
 aee2985 powerpc/ps3: Add ps3 pmu platform routines
 531c3f4 powerpc/ps3: Rearrange order of lpm routines
 9d8a7d3 powerpc/cell: Add pmu platform abstraction
 6865b99 powerpc/cell: Rearrange order of pmu routines

These patches will still be available in the ps3-queue-v3.7 and earlier
branches for anyone who wants them.

-Geoff
