Message-ID: <3844BAAC.FBF7996B@eecs.lehigh.edu>
Date: Wed, 01 Dec 1999 01:05:32 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: update for ssh 2.0.13
Content-Type: multipart/mixed; boundary="------------D3501D02EF5C47891D22A142"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D3501D02EF5C47891D22A142
Content-Type: text/plain; charset=iso-2022-kr
Content-Transfer-Encoding: 7bit

Although with my suggested fixes for gcc, the fix for ssh-2.0.13
isn't strictly necessary, but might as well as give it out anyway.


its really *tiny*

Also included are my (CORRECTED) fixes to va-ppc.h for both the default gcc in
linuxppc (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release))
as well as gcc-2.95.2 which seems to work well with binutils-2.9.5.0.21
(successfully compiled with 2.95.2, installed and ran ssh-2.0.13)

Until the gcc folks get their heads out of the sand about fixing the vararg
stuff
in PPC (which may be never, seeing how these go ); here they are.

Short of it is, the apparent rationale for not fixing the strange varargs
was that the PowerPC SYSVR4 ABI docs has an example of a va_list which is
implemented as an array of 1 element. Curiously, this design also makes
following  the ANSI C draft on va_list difficult. the C standard says that one
can pass pointers to va_list to functions, but by following the ABI, this makes
correct coding of va_list ptr passing (and dereferencing) really annoying and
fragile.

check my previous post.

My next message will also be crossposted to gcc-patches, and will have the same
va-ppc.h patches as here.

I hope somebody finds all this useful.
otherwise, sorry for the wasted bandwidth (and for my previous buggy patches
too) ;/

-jason
--------------D3501D02EF5C47891D22A142
Content-Type: text/plain; charset=iso-2022-kr; name="patch.ssh-2.0.13"
Content-Disposition: inline; filename="patch.ssh-2.0.13"
Content-Transfer-Encoding: 7bit

*** ssh-2.0.13/lib/sshutil/sshencode.c	1999/11/30 20:26:38	1.1
--- ssh-2.0.13/lib/sshutil/sshencode.c	1999/11/30 20:38:31
*************** size_t ssh_decode_array_va(const unsigne
*** 512,518 ****
            decoder = va_arg(ap, SshDecoder);
  
            /* Try decoding. */
!           start_of_ap = ap;
            size = (*decoder)(buf + offset, len - offset, &ap);
            if (size == 0)
              goto fail;
--- 512,518 ----
            decoder = va_arg(ap, SshDecoder);
  
            /* Try decoding. */
!           __va_copy(start_of_ap, ap);
            size = (*decoder)(buf + offset, len - offset, &ap);
            if (size == 0)
              goto fail;
*************** size_t ssh_decode_array_va(const unsigne
*** 524,530 ****
              decoders = ssh_xrealloc(decoders,
                                      (num_decoders + 1) * sizeof(*decoders));
            decoders[num_decoders].decoder = decoder;
!           decoders[num_decoders].ap = start_of_ap;
            num_decoders++;
  
            /* Move over parsed data. */
--- 524,530 ----
              decoders = ssh_xrealloc(decoders,
                                      (num_decoders + 1) * sizeof(*decoders));
            decoders[num_decoders].decoder = decoder;
!           __va_copy(decoders[num_decoders].ap, start_of_ap);
            num_decoders++;
  
            /* Move over parsed data. */

--------------D3501D02EF5C47891D22A142
Content-Type: text/plain; charset=iso-2022-kr; name="va-ppc.h.patch.gcc-2.95.2"
Content-Disposition: inline; filename="va-ppc.h.patch.gcc-2.95.2"
Content-Transfer-Encoding: 7bit

*** /apps/src/gcc-2.95.2/gcc/ginclude/va-ppc.h	Tue Nov 30 23:50:01 1999
--- va-ppc.h	Wed Dec  1 00:32:51 1999
***************
*** 12,18 ****
  
  /* Solaris decided to rename overflow_arg_area to input_arg_area,
     so handle it via a macro.  */
! #define __va_overflow(AP) (AP)->overflow_arg_area
  
  /* Note that the names in this structure are in the user's namespace, but
     that the V.4 abi explicitly states that these names should be used.  */
--- 12,18 ----
  
  /* Solaris decided to rename overflow_arg_area to input_arg_area,
     so handle it via a macro.  */
! #define __va_overflow(AP) (AP).overflow_arg_area
  
  /* Note that the names in this structure are in the user's namespace, but
     that the V.4 abi explicitly states that these names should be used.  */
*************** typedef struct __va_list_tag {
*** 26,37 ****
    char *overflow_arg_area;	/* location on stack that holds the next
  				   overflow argument */
    char *reg_save_area;		/* where r3:r10 and f1:f8, if saved are stored */
! } __va_list[1], __gnuc_va_list[1];
  
  #else /* _SYS_VA_LIST */
  
  typedef __va_list __gnuc_va_list;
! #define __va_overflow(AP) (AP)->input_arg_area
  
  #endif /* not _SYS_VA_LIST */
  #endif /* not __GNUC_VA_LIST */
--- 26,37 ----
    char *overflow_arg_area;	/* location on stack that holds the next
  				   overflow argument */
    char *reg_save_area;		/* where r3:r10 and f1:f8, if saved are stored */
! } __va_list, __gnuc_va_list;
  
  #else /* _SYS_VA_LIST */
  
  typedef __va_list __gnuc_va_list;
! #define __va_overflow(AP) (AP).input_arg_area
  
  #endif /* not _SYS_VA_LIST */
  #endif /* not __GNUC_VA_LIST */
*************** typedef struct {
*** 53,63 ****
     a warning about increasing the alignment requirement.  */
  #define __VA_FP_REGSAVE(AP,OFS,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP)->reg_save_area)->__fp_save[OFS])))
  
  #define __VA_GP_REGSAVE(AP,OFS,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP)->reg_save_area)->__gp_save[OFS])))
  
  /* Common code for va_start for both varargs and stdarg.  We allow all
     the work to be done by __builtin_saveregs.  It returns a pointer to
--- 53,63 ----
     a warning about increasing the alignment requirement.  */
  #define __VA_FP_REGSAVE(AP,OFS,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP).reg_save_area)->__fp_save[OFS])))
  
  #define __VA_GP_REGSAVE(AP,OFS,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP).reg_save_area)->__gp_save[OFS])))
  
  /* Common code for va_start for both varargs and stdarg.  We allow all
     the work to be done by __builtin_saveregs.  It returns a pointer to
*************** typedef struct {
*** 65,71 ****
     to the user's variable.  */
  
  #define __va_start_common(AP, FAKE) \
!   __builtin_memcpy ((AP), __builtin_saveregs (), sizeof(__gnuc_va_list))
  
  #ifdef _STDARG_H /* stdarg.h support */
  
--- 65,71 ----
     to the user's variable.  */
  
  #define __va_start_common(AP, FAKE) \
!   __builtin_memcpy (&(AP), __builtin_saveregs (), sizeof(__gnuc_va_list))
  
  #ifdef _STDARG_H /* stdarg.h support */
  
*************** __extension__ (*({							   \
*** 110,120 ****
  									   \
    if (__va_float_p (TYPE) && sizeof (TYPE) < 16)			   \
      {									   \
!       unsigned char __fpr = (AP)->fpr;					   \
        if (__fpr < 8)							   \
  	{								   \
  	  __ptr = __VA_FP_REGSAVE (AP, __fpr, TYPE);			   \
! 	  (AP)->fpr = __fpr + 1;					   \
  	}								   \
        else if (sizeof (TYPE) == 8)					   \
  	{								   \
--- 110,120 ----
  									   \
    if (__va_float_p (TYPE) && sizeof (TYPE) < 16)			   \
      {									   \
!       unsigned char __fpr = (AP).fpr;					   \
        if (__fpr < 8)							   \
  	{								   \
  	  __ptr = __VA_FP_REGSAVE (AP, __fpr, TYPE);			   \
! 	  (AP).fpr = __fpr + 1;					   \
  	}								   \
        else if (sizeof (TYPE) == 8)					   \
  	{								   \
*************** __extension__ (*({							   \
*** 132,142 ****
    /* Aggregates and long doubles are passed by reference.  */		   \
    else if (__va_aggregate_p (TYPE) || __va_float_p (TYPE))		   \
      {									   \
!       unsigned char __gpr = (AP)->gpr;					   \
        if (__gpr < 8)							   \
  	{								   \
  	  __ptr = * __VA_GP_REGSAVE (AP, __gpr, TYPE *);		   \
! 	  (AP)->gpr = __gpr + 1;					   \
  	}								   \
        else								   \
  	{								   \
--- 132,142 ----
    /* Aggregates and long doubles are passed by reference.  */		   \
    else if (__va_aggregate_p (TYPE) || __va_float_p (TYPE))		   \
      {									   \
!       unsigned char __gpr = (AP).gpr;					   \
        if (__gpr < 8)							   \
  	{								   \
  	  __ptr = * __VA_GP_REGSAVE (AP, __gpr, TYPE *);		   \
! 	  (AP).gpr = __gpr + 1;					   \
  	}								   \
        else								   \
  	{								   \
*************** __extension__ (*({							   \
*** 152,179 ****
        /* longlong is aligned.  */					   \
        if (sizeof (TYPE) == 8)						   \
  	{								   \
! 	  unsigned char __gpr = (AP)->gpr;				   \
  	  if (__gpr < 7)						   \
  	    {								   \
  	      __gpr += __gpr & 1;					   \
  	      __ptr = __VA_GP_REGSAVE (AP, __gpr, TYPE);		   \
! 	      (AP)->gpr = __gpr + 2;					   \
  	    }								   \
  	  else								   \
  	    {								   \
  	      unsigned long __addr = (unsigned long) (__va_overflow (AP)); \
  	      __ptr = (TYPE *)((__addr + 7) & -8);			   \
! 	      (AP)->gpr = 8;						   \
  	      __va_overflow (AP) = (char *)(__ptr + 1);			   \
  	    }								   \
  	}								   \
        else if (sizeof (TYPE) == 4)					   \
  	{								   \
! 	  unsigned char __gpr = (AP)->gpr;				   \
  	  if (__gpr < 8)						   \
  	    {								   \
  	      __ptr = __VA_GP_REGSAVE (AP, __gpr, TYPE);		   \
! 	      (AP)->gpr = __gpr + 1;					   \
  	    }								   \
  	  else								   \
  	    {								   \
--- 152,179 ----
        /* longlong is aligned.  */					   \
        if (sizeof (TYPE) == 8)						   \
  	{								   \
! 	  unsigned char __gpr = (AP).gpr;				   \
  	  if (__gpr < 7)						   \
  	    {								   \
  	      __gpr += __gpr & 1;					   \
  	      __ptr = __VA_GP_REGSAVE (AP, __gpr, TYPE);		   \
! 	      (AP).gpr = __gpr + 2;					   \
  	    }								   \
  	  else								   \
  	    {								   \
  	      unsigned long __addr = (unsigned long) (__va_overflow (AP)); \
  	      __ptr = (TYPE *)((__addr + 7) & -8);			   \
! 	      (AP).gpr = 8;						   \
  	      __va_overflow (AP) = (char *)(__ptr + 1);			   \
  	    }								   \
  	}								   \
        else if (sizeof (TYPE) == 4)					   \
  	{								   \
! 	  unsigned char __gpr = (AP).gpr;				   \
  	  if (__gpr < 8)						   \
  	    {								   \
  	      __ptr = __VA_GP_REGSAVE (AP, __gpr, TYPE);		   \
! 	      (AP).gpr = __gpr + 1;					   \
  	    }								   \
  	  else								   \
  	    {								   \
*************** __extension__ (*({							   \
*** 193,199 ****
  #define va_end(AP)	((void)0)
  
  /* Copy __gnuc_va_list into another variable of this type.  */
! #define __va_copy(dest, src) *(dest) = *(src)
  
  #endif /* __VA_PPC_H__ */
  #endif /* defined (_STDARG_H) || defined (_VARARGS_H) */
--- 193,199 ----
  #define va_end(AP)	((void)0)
  
  /* Copy __gnuc_va_list into another variable of this type.  */
! #define __va_copy(dest, src) (dest) = (src)
  
  #endif /* __VA_PPC_H__ */
  #endif /* defined (_STDARG_H) || defined (_VARARGS_H) */

--------------D3501D02EF5C47891D22A142
Content-Type: text/plain; charset=iso-2022-kr; name="va-ppc.h.patch.linuxppc1999.q3"
Content-Disposition: inline; filename="va-ppc.h.patch.linuxppc1999.q3"
Content-Transfer-Encoding: 7bit

*** va-ppc.h	1999/11/29 13:33:07	1.1
--- va-ppc.h	1999/11/30 19:44:47	1.2
***************
*** 12,18 ****
  
  /* Solaris decided to rename overflow_arg_area to input_arg_area,
     so handle it via a macro.  */
! #define __va_overflow(AP) (AP)->overflow_arg_area
  
  /* Note that the names in this structure are in the user's namespace, but
     that the V.4 abi explicitly states that these names should be used.  */
--- 12,18 ----
  
  /* Solaris decided to rename overflow_arg_area to input_arg_area,
     so handle it via a macro.  */
! #define __va_overflow(AP) (AP).overflow_arg_area
  
  /* Note that the names in this structure are in the user's namespace, but
     that the V.4 abi explicitly states that these names should be used.  */
*************** typedef struct __va_list_tag {
*** 26,37 ****
    char *overflow_arg_area;	/* location on stack that holds the next
  				   overflow argument */
    char *reg_save_area;		/* where r3:r10 and f1:f8, if saved are stored */
! } __va_list[1], __gnuc_va_list[1];
  
  #else /* _SYS_VA_LIST */
  
  typedef __va_list __gnuc_va_list;
! #define __va_overflow(AP) (AP)->input_arg_area
  
  #endif /* not _SYS_VA_LIST */
  #endif /* not __GNUC_VA_LIST */
--- 26,37 ----
    char *overflow_arg_area;	/* location on stack that holds the next
  				   overflow argument */
    char *reg_save_area;		/* where r3:r10 and f1:f8, if saved are stored */
! } __va_list, __gnuc_va_list;
  
  #else /* _SYS_VA_LIST */
  
  typedef __va_list __gnuc_va_list;
! #define __va_overflow(AP) (AP).input_arg_area
  
  #endif /* not _SYS_VA_LIST */
  #endif /* not __GNUC_VA_LIST */
*************** typedef struct {
*** 53,63 ****
     a warning about increasing the alignment requirement.  */
  #define __VA_FP_REGSAVE(AP,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP)->reg_save_area)->__fp_save[(int)(AP)->fpr])))
  
  #define __VA_GP_REGSAVE(AP,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP)->reg_save_area)->__gp_save[(int)(AP)->gpr])))
  
  /* Common code for va_start for both varargs and stdarg.  This depends
     on the format of rs6000_args in rs6000.h.  The fields used are:
--- 53,63 ----
     a warning about increasing the alignment requirement.  */
  #define __VA_FP_REGSAVE(AP,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP).reg_save_area)->__fp_save[(int)(AP).fpr])))
  
  #define __VA_GP_REGSAVE(AP,TYPE)					\
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
! 			 (AP).reg_save_area)->__gp_save[(int)(AP).gpr])))
  
  /* Common code for va_start for both varargs and stdarg.  This depends
     on the format of rs6000_args in rs6000.h.  The fields used are:
*************** typedef struct {
*** 78,86 ****
  __extension__ ({							\
     register int __words = __va_words - FAKE;				\
  									\
!    (AP)->gpr = (__words < 8) ? __words : 8;				\
!    (AP)->fpr = __va_fregno - 33;					\
!    (AP)->reg_save_area = ((char *) __builtin_args_info (8));		\
     __va_overflow(AP) = ((char *)__builtin_saveregs ()			\
  			+ (((__words >= 8) ? __words - 8 : 0)		\
  			   * sizeof (long)));				\
--- 78,86 ----
  __extension__ ({							\
     register int __words = __va_words - FAKE;				\
  									\
!    (AP).gpr = (__words < 8) ? __words : 8;				\
!    (AP).fpr = __va_fregno - 33;					\
!    (AP).reg_save_area = ((char *) __builtin_args_info (8));		\
     __va_overflow(AP) = ((char *)__builtin_saveregs ()			\
  			+ (((__words >= 8) ? __words - 8 : 0)		\
  			   * sizeof (long)));				\
*************** __extension__ ({							\
*** 118,151 ****
  __extension__ (*({							\
    register TYPE *__ptr;							\
  									\
!   if (__va_float_p (TYPE) && (AP)->fpr < 8)				\
      {									\
        __ptr = __VA_FP_REGSAVE (AP, TYPE);				\
!       (AP)->fpr++;							\
      }									\
  									\
!   else if (__va_aggregate_p (TYPE) && (AP)->gpr < 8)			\
      {									\
        __ptr = * __VA_GP_REGSAVE (AP, TYPE *);				\
!       (AP)->gpr++;							\
      }									\
  									\
    else if (!__va_float_p (TYPE) && !__va_aggregate_p (TYPE)		\
! 	   && (AP)->gpr + __va_size(TYPE) <= 8				\
  	   && (!__va_longlong_p(TYPE)					\
! 	       || (AP)->gpr + __va_size(TYPE) <= 8))			\
      {									\
!       if (__va_longlong_p(TYPE) && ((AP)->gpr & 1) != 0)		\
! 	(AP)->gpr++;							\
  									\
        __ptr = __VA_GP_REGSAVE (AP, TYPE);				\
!       (AP)->gpr += __va_size (TYPE);					\
      }									\
  									\
    else if (!__va_float_p (TYPE) && !__va_aggregate_p (TYPE)		\
! 	   && (AP)->gpr < 8)						\
      {									\
!       (AP)->gpr = 8;							\
        __ptr = (TYPE *) (void *) (__va_overflow(AP));			\
        __va_overflow(AP) += __va_size (TYPE) * sizeof (long);		\
      }									\
--- 118,151 ----
  __extension__ (*({							\
    register TYPE *__ptr;							\
  									\
!   if (__va_float_p (TYPE) && (AP).fpr < 8)				\
      {									\
        __ptr = __VA_FP_REGSAVE (AP, TYPE);				\
!       (AP).fpr++;							\
      }									\
  									\
!   else if (__va_aggregate_p (TYPE) && (AP).gpr < 8)			\
      {									\
        __ptr = * __VA_GP_REGSAVE (AP, TYPE *);				\
!       (AP).gpr++;							\
      }									\
  									\
    else if (!__va_float_p (TYPE) && !__va_aggregate_p (TYPE)		\
! 	   && (AP).gpr + __va_size(TYPE) <= 8				\
  	   && (!__va_longlong_p(TYPE)					\
! 	       || (AP).gpr + __va_size(TYPE) <= 8))			\
      {									\
!       if (__va_longlong_p(TYPE) && ((AP).gpr & 1) != 0)		\
! 	(AP).gpr++;							\
  									\
        __ptr = __VA_GP_REGSAVE (AP, TYPE);				\
!       (AP).gpr += __va_size (TYPE);					\
      }									\
  									\
    else if (!__va_float_p (TYPE) && !__va_aggregate_p (TYPE)		\
! 	   && (AP).gpr < 8)						\
      {									\
!       (AP).gpr = 8;							\
        __ptr = (TYPE *) (void *) (__va_overflow(AP));			\
        __va_overflow(AP) += __va_size (TYPE) * sizeof (long);		\
      }									\
*************** __extension__ (*({							\
*** 167,173 ****
  #define va_end(AP)	((void)0)
  
  /* Copy __gnuc_va_list into another variable of this type.  */
! #define __va_copy(dest, src) *(dest) = *(src)
  
  #endif /* __VA_PPC_H__ */
  #endif /* defined (_STDARG_H) || defined (_VARARGS_H) */
--- 167,173 ----
  #define va_end(AP)	((void)0)
  
  /* Copy __gnuc_va_list into another variable of this type.  */
! #define __va_copy(dest, src) (dest) = (src)
  
  #endif /* __VA_PPC_H__ */
  #endif /* defined (_STDARG_H) || defined (_VARARGS_H) */

--------------D3501D02EF5C47891D22A142--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
