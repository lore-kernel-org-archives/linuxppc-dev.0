Message-ID: <19990429194817.B20300@cygnus.com>
Date: Thu, 29 Apr 1999 19:48:17 -0700
From: Richard Henderson <rth@cygnus.com>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        egcs-patches@egcs.cygnus.com
Cc: meissner@cygnus.com, David Edelsohn <dje@watson.ibm.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems
References: <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>; from Franz Sirl on Fri, Apr 30, 1999 at 02:09:09AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 30, 1999 at 02:09:09AM +0200, Franz Sirl wrote:
> 1. the varargs save area calculation bug, this is a hack and Richard ;-) 
> probably won't like it, but maybe it's good enough for egcs-1.2

You're right -- I hate it.  You'll have made it so I can't build a
ppc cross compiler on my Alphas, and you'll have killed the compiler
for a ppc64-linux.

Here's an implementation of what I'd suggested before.  It looks ok
to the eye, but I don't have a ppc-linux box handy to try it out on.


r~


	* va-ppc.h (__va_start_common): Let __builtin_saveregs do the work.
	* rs6000.c (expand_builtin_saveregs): For SYSV, initialize a private
	va_list struct, and return a pointer to it.

Index: ginclude/va-ppc.h
===================================================================
RCS file: /egcs/carton/cvsfiles/egcs/gcc/ginclude/va-ppc.h,v
retrieving revision 1.4
diff -c -p -d -r1.4 va-ppc.h
*** va-ppc.h	1998/12/16 21:19:40	1.4
--- va-ppc.h	1999/04/30 02:45:30
*************** typedef struct {
*** 59,92 ****
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
  			 (AP)->reg_save_area)->__gp_save[(int)(AP)->gpr])))
  
! /* Common code for va_start for both varargs and stdarg.  This depends
!    on the format of rs6000_args in rs6000.h.  The fields used are:
! 
!    #0	WORDS			# words used for GP regs/stack values
!    #1	FREGNO			next available FP register
!    #2	NARGS_PROTOTYPE		# args left in the current prototype
!    #3	ORIG_NARGS		original value of NARGS_PROTOTYPE
!    #4	VARARGS_OFFSET		offset from frame pointer of varargs area */
! 
! #define __va_words		__builtin_args_info (0)
! #define __va_fregno		__builtin_args_info (1)
! #define	__va_nargs		__builtin_args_info (2)
! #define __va_orig_nargs		__builtin_args_info (3)
! #define __va_varargs_offset	__builtin_args_info (4)
  
! #define __va_start_common(AP, FAKE)					\
! __extension__ ({							\
!    register int __words = __va_words - FAKE;				\
! 									\
!    (AP)->gpr = (__words < 8) ? __words : 8;				\
!    (AP)->fpr = __va_fregno - 33;					\
!    (AP)->reg_save_area = (((char *) __builtin_frame_address (0))	\
! 			  + __va_varargs_offset);			\
!    __va_overflow(AP) = ((char *)__builtin_saveregs ()			\
! 			+ (((__words >= 8) ? __words - 8 : 0)		\
! 			   * sizeof (long)));				\
!    (void)0;								\
! })
  
  #ifdef _STDARG_H /* stdarg.h support */
  
--- 59,71 ----
    ((TYPE *) (void *) (&(((__va_regsave_t *)				\
  			 (AP)->reg_save_area)->__gp_save[(int)(AP)->gpr])))
  
! /* Common code for va_start for both varargs and stdarg.  We allow all
!    the work to be done by __builtin_saveregs.  It returns a pointer to
!    a va_list that was constructed on the stack; we must simply copy it
!    to the user's variable.  */
  
! #define __va_start_common(AP, FAKE) \
!   __builtin_memcpy ((AP), __builtin_saveregs (), sizeof(__gnuc_va_list))
  
  #ifdef _STDARG_H /* stdarg.h support */
  
Index: config/rs6000/rs6000.c
===================================================================
RCS file: /egcs/carton/cvsfiles/egcs/gcc/config/rs6000/rs6000.c,v
retrieving revision 1.66
diff -c -p -d -r1.66 rs6000.c
*** rs6000.c	1999/04/27 12:39:58	1.66
--- rs6000.c	1999/04/30 02:45:30
*************** setup_incoming_varargs (cum, mode, type,
*** 1704,1716 ****
     
     On the Power/PowerPC return the address of the area on the stack
     used to hold arguments.  Under AIX, this includes the 8 word register
!    save area.  Under V.4 this does not.  */
  
  struct rtx_def *
  expand_builtin_saveregs (args)
       tree args ATTRIBUTE_UNUSED;
  {
!   return virtual_incoming_args_rtx;
  }
  
  
--- 1704,1786 ----
     
     On the Power/PowerPC return the address of the area on the stack
     used to hold arguments.  Under AIX, this includes the 8 word register
!    save area. 
! 
!    Under V.4, things are more complicated.  We do not have access to
!    all of the virtual registers required for va_start to do its job,
!    so we construct the va_list in its entirity here, and reduce va_start
!    to a block copy.  This is similar to the way we do things on Alpha.  */
  
  struct rtx_def *
  expand_builtin_saveregs (args)
       tree args ATTRIBUTE_UNUSED;
  {
!   rtx block, mem_gpr_fpr, mem_reg_save_area, mem_overflow, tmp;
!   tree fntype;
!   int stdarg_p;
!   HOST_WIDE_INT words, gpr, fpr;
! 
!   if (DEFAULT_ABI != ABI_V4 && DEFAULT_ABI != ABI_SOLARIS)
!     return virtual_incoming_args_rtx;
! 
!   fntype = TREE_TYPE (current_function_decl);
!   stdarg_p = (TYPE_ARG_TYPES (fntype) != 0
! 	      && (TREE_VALUE (tree_last (TYPE_ARG_TYPES (fntype)))
! 		  != void_type_node));
! 
!   /* Allocate the va_list constructor.  */
!   block = assign_stack_local (BLKmode, 3 * UNITS_PER_WORD, BITS_PER_WORD);
!   RTX_UNCHANGING_P (block) = 1;
!   RTX_UNCHANGING_P (XEXP (block, 0)) = 1;
! 
!   mem_gpr_fpr = change_address (block, word_mode, XEXP (block, 0));
!   mem_overflow = change_address (block, ptr_mode, 
! 			         plus_constant (XEXP (block, 0),
! 						UNITS_PER_WORD));
!   mem_reg_save_area = change_address (block, ptr_mode, 
! 				      plus_constant (XEXP (block, 0),
! 						     2 * UNITS_PER_WORD));
! 
!   /* Construct the two characters of `gpr' and `fpr' as a unit.  */
!   words = current_function_args_info.words - !stdarg_p;
!   gpr = (words > 8 ? 8 : words);
!   fpr = current_function_args_info.fregno - 33;
! 
!   if (BYTES_BIG_ENDIAN)
!     {
!       HOST_WIDE_INT bits = gpr << 8 | fpr;
!       if (HOST_BITS_PER_WIDE_INT >= BITS_PER_WORD)
!         tmp = GEN_INT (bits << (BITS_PER_WORD - 16));
!       else
! 	{
! 	  bits <<= BITS_PER_WORD - HOST_BITS_PER_WIDE_INT - 16;
! 	  tmp = immed_double_const (0, bits, word_mode);
! 	}
!     }
!   else
!     tmp = GEN_INT (fpr << 8 | gpr);
! 
!   emit_move_insn (mem_gpr_fpr, tmp);
! 
!   /* Find the overflow area.  */
!   if (words <= 8)
!     tmp = virtual_incoming_args_rtx;
!   else
!     tmp = expand_binop (Pmode, add_optab, virtual_incoming_args_rtx,
! 		        GEN_INT ((words - 8) * UNITS_PER_WORD),
! 		        mem_overflow, 0, OPTAB_WIDEN);
!   if (tmp != mem_overflow)
!     emit_move_insn (mem_overflow, tmp);
! 
!   /* Find the register save area.  */
!   tmp = expand_binop (Pmode, add_optab, virtual_stack_vars_rtx,
! 		      GEN_INT (-RS6000_VARARGS_SIZE),
! 		      mem_reg_save_area, 0, OPTAB_WIDEN);
!   if (tmp != mem_reg_save_area)
!     emit_move_insn (mem_reg_save_area, tmp);
! 
!   /* Return the address of the va_list constructor.  */
!   return XEXP (block, 0);
  }
  
  

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
