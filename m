Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B343A1A05C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 13:20:16 +1100 (AEDT)
Message-ID: <1418178015.30244.5.camel@concordia>
Subject: Re: [PATCH V4] powerpc: add little endian flag to syscall_get_arch()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Moore <pmoore@redhat.com>
Date: Wed, 10 Dec 2014 13:20:15 +1100
In-Reply-To: <1557787.lOBez6GG22@sifl>
References: <24fcd2ea2c7633152e74a7a92abab1dd1782745d.1418157273.git.rgb@redhat.com>
 <1557787.lOBez6GG22@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tonyj@suse.de, Richard Guy Briggs <rgb@redhat.com>,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-audit@redhat.com, anton@samba.org, eparis@parisplace.org,
 sgrubb@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 21:11 -0500, Paul Moore wrote:
> On Tuesday, December 09, 2014 03:37:07 PM Richard Guy Briggs wrote:
> > Since both ppc and ppc64 have LE variants which are now reported by uname,
> > add that flag (__AUDIT_ARCH_LE) to syscall_get_arch() and add
> > AUDIT_ARCH_PPC64LE variant.
> > 
> > Without this,  perf trace and auditctl fail.
> > 
> > Mainline kernel reports ppc64le (per a058801) but there is no matching
> > AUDIT_ARCH_PPC64LE.
> > 
> > Since 32-bit PPC LE is not supported by audit, don't advertise it in
> > AUDIT_ARCH_PPC* variants.
> > 
> > See:
> > 	https://www.redhat.com/archives/linux-audit/2014-August/msg00082.html
> > 	https://www.redhat.com/archives/linux-audit/2014-December/msg00004.html
> > 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  arch/powerpc/include/asm/syscall.h |    6 +++++-
> >  include/uapi/linux/audit.h         |    2 ++
> >  2 files changed, 7 insertions(+), 1 deletions(-)
> 
> The audit changes look fine to me, but as I mentioned earlier, this should go 
> in via the ppc tree and not the audit tree.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks.

Yep I'll take it via the powerpc tree, I'll CC stable as well as presumably we
want this to work in all versions that had LE support.

cheers
