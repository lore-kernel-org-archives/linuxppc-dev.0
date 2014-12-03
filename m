Return-Path: <pmoore@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F02771A0B66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 08:59:59 +1100 (AEDT)
From: Paul Moore <pmoore@redhat.com>
To: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH] powerpc: add little endian flag to syscall_get_arch()
Date: Wed, 03 Dec 2014 16:59:55 -0500
Message-ID: <1687038.iUVICprQqD@sifl>
In-Reply-To: <547E3508.2080500@suse.de>
References: <fbe03529d720e75aa8663f8b521af5b11b33d52f.1417553967.git.rgb@redhat.com>
 <547E3508.2080500@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Richard Guy Briggs <rgb@redhat.com>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-audit@redhat.com, eparis@parisplace.org,
 sgrubb@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, December 02, 2014 01:54:16 PM Tony Jones wrote:
> On 12/02/2014 01:27 PM, Richard Guy Briggs wrote:
> > Since both ppc and ppc64 have LE variants which are now reported by uname,
> > add that flag (__AUDIT_ARCH_LE) to syscall_get_arch() and add
> > AUDIT_ARCH_PPC*LE variants.
> > 
> > Without this,  perf trace and auditctl fail.
> > 
> > Mainline kernel reports ppc64le (per a058801) but there is no matching
> > AUDIT_ARCH_PPC64LE.
> > 
> > See:
> > 	https://www.redhat.com/archives/linux-audit/2014-August/msg00082.html
> > 	https://www.redhat.com/archives/linux-audit/2014-December/msg00004.html
> > 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > 
> >  arch/powerpc/include/asm/syscall.h |    6 +++++-
> >  include/uapi/linux/audit.h         |    2 ++
> >  2 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/syscall.h
> > b/arch/powerpc/include/asm/syscall.h index 6fa2708..a58acab 100644
> > --- a/arch/powerpc/include/asm/syscall.h
> > +++ b/arch/powerpc/include/asm/syscall.h
> > @@ -90,6 +90,10 @@ static inline void syscall_set_arguments(struct
> > task_struct *task,> 
> >  static inline int syscall_get_arch(void)
> >  {
> > 
> > -	return is_32bit_task() ? AUDIT_ARCH_PPC : AUDIT_ARCH_PPC64;
> > +	int arch = is_32bit_task() ? AUDIT_ARCH_PPC : AUDIT_ARCH_PPC64;
> > +#ifdef __LITTLE_ENDIAN__
> > +	arch |= __AUDIT_ARCH_LE
> > +#endif
> > +	return arch;
> > 
> >  }
> >  #endif	/* _ASM_SYSCALL_H */
> > 
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 4d100c8..fe29a99 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -364,7 +364,9 @@ enum {
> > 
> >  #define AUDIT_ARCH_PARISC	(EM_PARISC)
> >  #define AUDIT_ARCH_PARISC64	(EM_PARISC|__AUDIT_ARCH_64BIT)
> >  #define AUDIT_ARCH_PPC		(EM_PPC)
> > 
> > +#define AUDIT_ARCH_PPCLE	(EM_PPC|__AUDIT_ARCH_LE)
> > 
> >  #define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
> > 
> > +#define AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> > 
> >  #define AUDIT_ARCH_S390		(EM_S390)
> >  #define AUDIT_ARCH_S390X	(EM_S390|__AUDIT_ARCH_64BIT)
> >  #define AUDIT_ARCH_SH		(EM_SH)
> 
> IBM would know for certain but I wasn't aware there was a PPCLE (32bit
> compat).

FWIW, I've heard the same thing from IBM folks off-list.

-- 
paul moore
security and virtualization @ redhat
