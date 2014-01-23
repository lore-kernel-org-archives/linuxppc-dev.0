Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 415D02C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 11:39:00 +1100 (EST)
Date: Wed, 22 Jan 2014 19:38:39 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH RFC 00/73] tree-wide: clean up some no longer required
 #include <linux/init.h>
Message-ID: <20140123003838.GA10182@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, rusty@rustcorp.com.au, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 gregkh@linuxfoundation.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [PATCH RFC 00/73] tree-wide: clean up some no longer required #include=
 <linux/init.h>] On 22/01/2014 (Wed 18:00) Stephen Rothwell wrote:

> Hi Paul,
>=20
> On Tue, 21 Jan 2014 16:22:03 -0500 Paul Gortmaker <paul.gortmaker@windriv=
er.com> wrote:
> >
> > Where: This work exists as a queue of patches that I apply to
> > linux-next; since the changes are fixing some things that currently
> > can only be found there.  The patch series can be found at:
> >=20
> >    http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git
> >    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> >=20
> > I've avoided annoying Stephen with another queue of patches for
> > linux-next while the development content was in flux, but now that
> > the merge window has opened, and new additions are fewer, perhaps he
> > wouldn't mind tacking it on the end...  Stephen?
>=20
> OK, I have added this to the end of linux-next today - we will see how we
> go.  It is called "init".

Thanks, it was a great help as it uncovered a few issues in fringe arch
that I didn't have toolchains for, and I've fixed all of those up.

I've noticed that powerpc has been un-buildable for a while now; I have
used this hack patch locally so I could run the ppc defconfigs to check
that I didn't break anything.  Maybe useful for linux-next in the
interim?  It is a hack patch -- Not-Signed-off-by: Paul Gortmaker.  :)

Paul.
--

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/includ=
e/asm/pgtable-ppc64.h
index d27960c89a71..d0f070a2b395 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma,=
 unsigned long address,
 			    pmd_t *pmdp);
=20
 #define pmd_move_must_withdraw pmd_move_must_withdraw
-typedef struct spinlock spinlock_t;
-static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
-					 spinlock_t *old_pmd_ptl)
+struct spinlock;
+static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+					 struct spinlock *old_pmd_ptl)
 {
 	/*
 	 * Archs like ppc64 use pgtable to store per pmd
