Message-ID: <3842EA0B.35AA0D6A@eecs.lehigh.edu>
Date: Mon, 29 Nov 1999 16:03:07 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: gcc-patches@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
Content-Type: multipart/mixed; boundary="------------54B17649AD0E7B60CE761D5F"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------54B17649AD0E7B60CE761D5F
Content-Type: text/plain; charset=iso-2022-kr
Content-Transfer-Encoding: 7bit

There is no ChangeLog here. The original files in GCC (2.95.2) had no
changelog (!)

jason kim.
jwk2@eecs.lehigh.edu
--------------54B17649AD0E7B60CE761D5F
Content-Type: text/plain; charset=iso-2022-kr; name="letter1"
Content-Disposition: inline; filename="letter1"
Content-Transfer-Encoding: 7bit



There is a problem with va-ppc.h distributed with recent versions of
gcc (2.95 and onwards) as well as the older egcs 1.1 releases.

va-ppc.h typedefs va_list as an array of 1 element of struct
_va_list_tag but this causes problems when va_lists (or pointers to
them!) are passed as arguments to functions:

e.g.

void foo(va_list va1)
{
  va_list va2;
  va1 = va2;
}

will cause the compilation to fail with incompatible pointer types under
PowerPC linux systems (including LinuxPPC 1999 Q3)

Included with this message are two patches, one for
/usr/lib/gcc-lib/ppc-redhat-linux/egcs-2.91.66/include/va-ppc.h

and a similar patch for gcc/ginclude/va-ppc.h in gcc-2.95.2 (generic)

This patch is needed to compile and run programs that use vararg stuff
extensively such as ssh-2.0.13 on PowerPC based linux systems.

I have tested my patch in a 1999 Q3 version of LinuxPPC and seems to work
fine. (i.e. ssh2 compiled, and ran, and works with no probs)

p.s. gcc-2.95.2 and the latest binutils seems to disagree on what the proper
target name is for linking... more on this as it develops..


--------------54B17649AD0E7B60CE761D5F
Content-Type: text/plain; charset=iso-2022-kr; name="va-ppc.h.patch.linuxppc1999.q3"
Content-Disposition: inline; filename="va-ppc.h.patch.linuxppc1999.q3"
Content-Transfer-Encoding: 7bit

*** va-ppc.h	1999/11/29 13:33:07	1.1
--- va-ppc.h	1999/11/29 13:39:12
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

--------------54B17649AD0E7B60CE761D5F
Content-Type: text/plain; charset=iso-2022-kr; name="va-ppc.h.patch.gcc-2.95.2"
Content-Disposition: inline; filename="va-ppc.h.patch.gcc-2.95.2"
Content-Transfer-Encoding: 7bit

*** va-ppc.h	Mon Aug  9 01:55:16 1999
--- va-ppc.fixed.h	Mon Nov 29 15:43:17 1999
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

--------------54B17649AD0E7B60CE761D5F--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
