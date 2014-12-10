Return-Path: <rgb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF3F01A06EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 13:43:30 +1100 (AEDT)
Date: Tue, 9 Dec 2014 21:43:19 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4] powerpc: add little endian flag to syscall_get_arch()
Message-ID: <20141210024319.GI29175@madcap2.tricolour.ca>
References: <24fcd2ea2c7633152e74a7a92abab1dd1782745d.1418157273.git.rgb@redhat.com>
 <1557787.lOBez6GG22@sifl> <1418178015.30244.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418178015.30244.5.camel@concordia>
Cc: tonyj@suse.de, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Moore <pmoore@redhat.com>, linux-audit@redhat.com, anton@samba.org,
 eparis@parisplace.org, sgrubb@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/12/10, Michael Ellerman wrote:
> On Tue, 2014-12-09 at 21:11 -0500, Paul Moore wrote:
> > On Tuesday, December 09, 2014 03:37:07 PM Richard Guy Briggs wrote:
> > > Since both ppc and ppc64 have LE variants which are now reported by uname,
> > > add that flag (__AUDIT_ARCH_LE) to syscall_get_arch() and add
> > > AUDIT_ARCH_PPC64LE variant.
> > > 
> > > Without this,  perf trace and auditctl fail.
> > > 
> > > Mainline kernel reports ppc64le (per a058801) but there is no matching
> > > AUDIT_ARCH_PPC64LE.
> > > 
> > > Since 32-bit PPC LE is not supported by audit, don't advertise it in
> > > AUDIT_ARCH_PPC* variants.
> > > 
> > > See:
> > > 	https://www.redhat.com/archives/linux-audit/2014-August/msg00082.html
> > > 	https://www.redhat.com/archives/linux-audit/2014-December/msg00004.html
> > > 
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  arch/powerpc/include/asm/syscall.h |    6 +++++-
> > >  include/uapi/linux/audit.h         |    2 ++
> > >  2 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > The audit changes look fine to me, but as I mentioned earlier, this should go 
> > in via the ppc tree and not the audit tree.
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> 
> Thanks.
> 
> Yep I'll take it via the powerpc tree, I'll CC stable as well as presumably we
> want this to work in all versions that had LE support.

Yes, please!

(I was very tempted to change the #error to #warning, but figured the
placeholder comment in the uapi file was sufficient.)

> cheers

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
