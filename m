Message-Id: <l03130300b4ab42c57934@[213.6.57.225]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 19 Jan 2000 11:38:57 +0100
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
From: Moritz Thomas <motho@gmx.net>
Subject: Re: still no accelerated X ($#!$*)
Cc: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Finally I got it!

The problem was in the Xpmac code. If I remember correctly, this error
was some time ago in the kernel's "atyfb.c" as well. Probably this is also
fixed in current release of Xpmac

The following functions in "regmach.h":
#if defined (__powerpc__)
extern pointer mach64MemReg;

static inline void regw(volatile unsigned long regindex, unsigned long regdata)
{
  register unsigned long base_addr = (unsigned long)mach64MemReg;

  asm("stwbrx %0,%1,%2": : "r"(regdata), "r"(regindex), "r"(base_addr));
}

static inline unsigned long regr(volatile unsigned long regindex)
{
  register unsigned long base_addr = (unsigned long)mach64MemReg, val;

  asm("lwbrx %0,%1,%2": "=r"(val):"r"(regindex), "r"(base_addr));
  return(val);
}
#endif

need to be replaced by:
#if defined (__powerpc__)
extern pointer mach64MemReg;

static inline void regw(volatile unsigned long regindex, unsigned long regdata)
{
  register unsigned long base_addr = (unsigned long)mach64MemReg;

  asm("stwbrx %0,%1,%2": : "r"(regdata), "b"(regindex), "r"(base_addr));
}

static inline unsigned long regr(volatile unsigned long regindex)
{
  register unsigned long base_addr = (unsigned long)mach64MemReg, val;

  asm("lwbrx %0,%1,%2": "=r"(val):"b"(regindex), "r"(base_addr));
  return(val);
}
#endif

Don't know if this is correct (no clue about ppc assembly), but it works...

mo


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
