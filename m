Message-Id: <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
Date: Fri, 30 Apr 1999 02:09:09 +0200
To: egcs-patches@egcs.cygnus.com
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: PATCH: Fix 2 PPC/SYSV varargs problems
Cc: rth@cygnus.com, meissner@cygnus.com, David Edelsohn <dje@watson.ibm.com>,
        linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_53744284==_"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=====================_53744284==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Hi,

this patch is supposed to fix the following problems on PPC/SYSV:

1. the varargs save area calculation bug, this is a hack and Richard ;-) 
probably won't like it, but maybe it's good enough for egcs-1.2

2. if you call a function that uses more then 8 float args before all 
integer argument passing registers are consumed, egcs will missetup the 
calling sequence. I introduced a new variable cum->sysv_fwords in the 
CUMULATIVE_ARGS struct, which counts the saved float words and adjusted 
cum->words where needed (I hope). There maybe better/nicer ways to 
implement that, so tell me if you want a different solution. A testcase is 
attached, the original problem happens with gnuplot.

Franz.



--=====================_53744284==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="varargs.testcase.c"
Content-Transfer-Encoding: quoted-printable

#include <stdarg.h>=0A=0Ainline void debug(const char *fp,const char=
 *msg,...)=0A{=0A       va_list ap;=0A       double df;=0A   =0A=0A       if=
 (*fp !=3D '1')=0A             abort();=0A       if (*msg !=3D '2')=0A      =
       abort();=0A   =0A       va_start( ap, msg );=0A   =0A       df =3D=
 va_arg(ap,double);=0A       if (df <1.09 || df >1.11)=0A            =
 abort();=0A       df =3D va_arg(ap,double);=0A       if (df <1.19 || df=
 >1.21)=0A             abort();=0A       df =3D va_arg(ap,double);=0A      =
 if (df <1.29 || df >1.31)=0A             abort();=0A       df =3D=
 va_arg(ap,double);=0A       if (df <1.39 || df >1.41)=0A            =
 abort();=0A       df =3D va_arg(ap,double);=0A       if (df <1.49 || df=
 >1.51)=0A             abort();=0A       if ( *va_arg(ap,char*) !=3D '3')=0A=
             abort();=0A       if ( *va_arg(ap,char*) !=3D '4')=0A          =
   abort();=0A       if ( *va_arg(ap,char*) !=3D '5')=0A            =
 abort();=0A       df =3D va_arg(ap,double);=0A       if (df <1.59 || df=
 >1.61)=0A             abort();=0A       df =3D va_arg(ap,double);=0A      =
 if (df <1.69 || df >1.71)=0A             abort();=0A       df =3D=
 va_arg(ap,double);=0A       if (df <1.79 || df >1.81)=0A            =
 abort();=0A       df =3D va_arg(ap,double);=0A       if (df <1.89 || df=
 >1.91)=0A             abort();=0A       if ( va_arg(ap,int) !=3D 101)=0A   =
          abort();=0A       if ( va_arg(ap,int) !=3D 102)=0A            =
 abort();=0A       if ( va_arg(ap,int) !=3D 103)=0A             abort();=0A =
      if ( va_arg(ap,int) !=3D 104)=0A             abort();=0A       if (=
 *va_arg(ap,char*) !=3D '6')=0A             abort();=0A       if (=
 va_arg(ap,int) !=3D 105)=0A             abort();=0A       if (=
 va_arg(ap,int) !=3D 106)=0A             abort();=0A       if (=
 va_arg(ap,int) !=3D 107)=0A             abort();=0A       if (=
 va_arg(ap,int) !=3D 108)=0A             abort();=0A       if (=
 va_arg(ap,int) !=3D 109)=0A             abort();=0A=0A   =0A       if (=
 va_arg(ap,int) !=3D 110)=0A             abort();=0A=0A       va_end( ap=
 );=0A}=0A=0Aint main(void)=0A{=0A     debug("1 filepointer", "2 format",=
 1.1,1.2,1.3,1.4,1.5, "3","4","5", 1.6,1.7,1.8,1.9, 101,102,103,104, "6",=
 105,106,107,108,109,110);=0A     exit(0);=0A}=0A=0A
--=====================_53744284==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename="varargsfix2.patch"
Content-Transfer-Encoding: quoted-printable

Index:=
 expr.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0ARCS file:=
 /egcs/carton/cvsfiles/egcs/gcc/expr.c,v=0Aretrieving revision 1.141=0Adiff=
 -u -p -r1.141 expr.c=0A--- expr.c	1999/04/27 05:34:43	1.141=0A+++=
 gcc/expr.c	1999/04/28 22:23:47=0A@@ -8951,7 +8951,13 @@ expand_builtin=
 (exp, target, subtarget, =0A 		if (wordnum < 0 || wordnum >=3D nwords ||=
 TREE_INT_CST_HIGH (arg))=0A 		  error ("argument of `__builtin_args_info'=
 out of range");=0A 		else=0A-		  return GEN_INT (word_ptr[wordnum]);=0A+		 =
 {=0A+#ifdef CUMULATIVE_ARG_INFO_IS_RTX=0A+		    if=
 (CUMULATIVE_ARG_INFO_IS_RTX(wordnum))=0A+		      return=
 word_ptr[wordnum];=0A+#endif=0A+		    return GEN_INT=
 (word_ptr[wordnum]);=0A+	          }=0A 	      }=0A 	  }=0A 	else=0AIndex:=
 va-ppc.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0ARCS file:=
 /egcs/carton/cvsfiles/egcs/gcc/ginclude/va-ppc.h,v=0Aretrieving revision=
 1.4=0Adiff -u -p -r1.4 va-ppc.h=0A--- va-ppc.h	1998/12/16 21:19:40	1.4=0A++=
+ gcc/ginclude/va-ppc.h	1999/04/28 23:23:10=0A@@ -80,8 +80,7 @@=
 __extension__ ({							\=0A 									\=0A    (AP)->gpr =3D (__words < 8) ?=
 __words : 8;				\=0A    (AP)->fpr =3D __va_fregno - 33;					\=0A-  =
 (AP)->reg_save_area =3D (((char *) __builtin_frame_address (0))	\=0A-			  +=
 __va_varargs_offset);			\=0A+   (AP)->reg_save_area =3D ((char *)=
 __builtin_args_info (8));		\=0A    __va_overflow(AP) =3D ((char=
 *)__builtin_saveregs ()			\=0A 			+ (((__words >=3D 8) ? __words - 8 :=
 0)		\=0A 			   * sizeof (long)));				\=0AIndex:=
 rs6000.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0ARCS file:=
 /egcs/carton/cvsfiles/egcs/gcc/config/rs6000/rs6000.h,v=0Aretrieving=
 revision 1.45=0Adiff -u -p -r1.45 rs6000.h=0A--- rs6000.h	1999/04/27=
 12:39:56	1.45=0A+++ gcc/config/rs6000/rs6000.h	1999/04/29 23:16:17=0A@@=
 -1445,15 +1445,19 @@ extern int rs6000_sysv_varargs_p;=0A =0A typedef=
 struct rs6000_args=0A {=0A-  int words;			/* # words uses for passing GP=
 registers */=0A+  int words;			/* # words uses for passing GP+FP registers=
 */=0A   int fregno;			/* next available FP register */=0A   int=
 nargs_prototype;		/* # args left in the current prototype */=0A   int=
 orig_nargs;		/* Original value of nargs_prototype */=0A   int=
 varargs_offset;		/* offset of the varargs save area */=0A   int=
 prototype;		/* Whether a prototype was defined */=0A   int call_cookie;		/*=
 Do special things for this call */=0A+  int sysv_fwords;		/* # words uses=
 for passing FP registers */=0A+  void *save_area;		/* setup with rtx=
 pointing to varargs_save_area */=0A } CUMULATIVE_ARGS;=0A =0A+#define=
 CUMULATIVE_ARG_INFO_IS_RTX(idx) ((idx) =3D=3D 8)=0A+=0A /* Define=
 intermediate macro to compute the size (in registers) of an argument=0A   =
 for the RS/6000.  */=0A =0AIndex:=
 rs6000.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0ARCS file:=
 /egcs/carton/cvsfiles/egcs/gcc/config/rs6000/rs6000.c,v=0Aretrieving=
 revision 1.66=0Adiff -u -p -r1.66 rs6000.c=0A--- rs6000.c	1999/04/27=
 12:39:58	1.66=0A+++ gcc/config/rs6000/rs6000.c	1999/04/29 23:16:29=0A@@=
 -1256,6 +1261,7 @@ init_cumulative_args (cum, fntype, libna=0A  =
 cum->fregno =3D FP_ARG_MIN_REG;=0A   cum->prototype =3D (fntype &&=
 TYPE_ARG_TYPES (fntype));=0A   cum->call_cookie =3D CALL_NORMAL;=0A+ =
 cum->sysv_fwords =3D 0;=0A =0A   if (incoming)=0A     {=0A@@ -1381,10=
 +1387,10 @@ function_arg_advance (cum, mode, type, n=0A       /* Long longs=
 must not be split between registers and stack */=0A       if=
 ((GET_MODE_CLASS (mode) !=3D MODE_FLOAT || TARGET_SOFT_FLOAT)=0A 	  && type=
 && !AGGREGATE_TYPE_P (type)=0A-	  && cum->words < GP_ARG_NUM_REG=0A-	  &&=
 cum->words + RS6000_ARG_SIZE (mode, type, named) > GP_ARG_NUM_REG)=0A+	  &&=
 cum->words - cum->sysv_fwords < GP_ARG_NUM_REG=0A+	  && cum->words -=
 cum->sysv_fwords + RS6000_ARG_SIZE (mode, type, named) > GP_ARG_NUM_REG)=0A=
 	{=0A-	  cum->words =3D GP_ARG_NUM_REG;=0A+	  cum->words =3D GP_ARG_NUM_REG=
 + cum->sysv_fwords;=0A 	}=0A =0A       /* Aggregates get passed as pointers=
 */=0A@@ -1399,7 +1405,11 @@ function_arg_advance (cum, mode, type, n=0A=
 	cum->fregno++;=0A =0A       else=0A-	cum->words +=3D RS6000_ARG_SIZE=
 (mode, type, 1);=0A+	{ =0A+	  cum->words +=3D RS6000_ARG_SIZE (mode, type,=
 1);=0A+	  if (GET_MODE_CLASS (mode) =3D=3D MODE_FLOAT)=0A+	   =
 cum->sysv_fwords +=3D RS6000_ARG_SIZE (mode, type, 1);=0A+	}=0A     }=0A  =
 else=0A     if (named)=0A@@ -1411,8 +1421,8 @@ function_arg_advance (cum,=
 mode, type, n=0A =0A   if (TARGET_DEBUG_ARG)=0A     fprintf (stderr,=0A-	  =
   "function_adv: words =3D %2d, fregno =3D %2d, nargs =3D %4d, proto =3D=
 %d, mode =3D %4s, named =3D %d, align =3D %d\n",=0A-	     cum->words,=
 cum->fregno, cum->nargs_prototype, cum->prototype, GET_MODE_NAME (mode),=
 named, align);=0A+	     "function_adv: words =3D %2d, sysv_fwords =3D %2d,=
 fregno =3D %2d, nargs =3D %4d, proto =3D %d, mode =3D %4s, named =3D %d,=
 align =3D %d\n",=0A+	     cum->words, cum->sysv_fwords, cum->fregno,=
 cum->nargs_prototype, cum->prototype, GET_MODE_NAME (mode), named, align);=
=0A }=0A =0C=0A /* Determine where to put an argument to a function.=0A@@=
 -1451,8 +1461,8 @@ function_arg (cum, mode, type, named)=0A =0A   if=
 (TARGET_DEBUG_ARG)=0A     fprintf (stderr,=0A-	     "function_arg: words =
=3D %2d, fregno =3D %2d, nargs =3D %4d, proto =3D %d, mode =3D %4s, named =
=3D %d, align =3D %d\n",=0A-	     cum->words, cum->fregno,=
 cum->nargs_prototype, cum->prototype, GET_MODE_NAME (mode), named,=
 align);=0A+	     "function_arg: words =3D %2d, sysv_fwords =3D %2d, fregno=
 =3D %2d, nargs =3D %4d, proto =3D %d, mode =3D %4s, named =3D %d, align =3D=
 %d\n",=0A+	     cum->words, cum->sysv_fwords, cum->fregno,=
 cum->nargs_prototype, cum->prototype, GET_MODE_NAME (mode), named, align);=
=0A =0A   /* Return a marker to indicate whether CR1 needs to set or clear=
 the bit that V.4=0A      uses to say fp args were passed in registers. =
 Assume that we don't need the=0A@@ -1522,14 +1532,14 @@ function_arg (cum,=
 mode, type, named)=0A   /* Long longs won't be split between register and=
 stack;=0A      FP arguments get passed on the stack if they didn't get a=
 register.  */=0A   else if ((DEFAULT_ABI =3D=3D ABI_V4 || DEFAULT_ABI =3D=
=3D ABI_SOLARIS) &&=0A-	   (align_words + RS6000_ARG_SIZE (mode, type,=
 named) > GP_ARG_NUM_REG=0A+	   (align_words - cum->sysv_fwords +=
 RS6000_ARG_SIZE (mode, type, named) > GP_ARG_NUM_REG=0A 	    ||=
 (GET_MODE_CLASS (mode) =3D=3D MODE_FLOAT && TARGET_HARD_FLOAT)))=0A     {=
=0A       return NULL_RTX;=0A     }=0A =0A-  else if (align_words <=
 GP_ARG_NUM_REG)=0A-    return gen_rtx_REG (mode, GP_ARG_MIN_REG +=
 align_words);=0A+  else if (align_words - cum->sysv_fwords <=
 GP_ARG_NUM_REG)=0A+    return gen_rtx_REG (mode, GP_ARG_MIN_REG +=
 align_words - cum->sysv_fwords);=0A =0A   return NULL_RTX;=0A }=0A@@=
 -1626,21 +1636,24 @@ setup_incoming_varargs (cum, mode, type,=0A =0A   if=
 (TARGET_DEBUG_ARG)=0A     fprintf (stderr,=0A-	     "setup_vararg: words =
=3D %2d, fregno =3D %2d, nargs =3D %4d, proto =3D %d, mode =3D %4s, no_rtl=
=3D %d\n",=0A-	     cum->words, cum->fregno, cum->nargs_prototype,=
 cum->prototype, GET_MODE_NAME (mode), no_rtl);=0A+	     "setup_vararg:=
 words =3D %2d, sysv_fwords =3D %2d, fregno =3D %2d, nargs =3D %4d, proto =
=3D %d, mode =3D %4s, no_rtl=3D %d\n",=0A+	     cum->words,=
 cum->sysv_fwords, cum->fregno, cum->nargs_prototype, cum->prototype,=
 GET_MODE_NAME (mode), no_rtl);=0A =0A   if (DEFAULT_ABI =3D=3D ABI_V4 ||=
 DEFAULT_ABI =3D=3D ABI_SOLARIS)=0A     {=0A       rs6000_sysv_varargs_p =3D=
 1;=0A       if (! no_rtl)=0A-	save_area =3D plus_constant=
 (frame_pointer_rtx, RS6000_VARARGS_OFFSET);=0A+	{=0A+	  save_area =3D=
 plus_constant (virtual_stack_vars_rtx, -RS6000_VARARGS_SIZE);=0A+	  (rtx)=
 cum->save_area =3D save_area;=0A+	}=0A     }=0A   else=0A    =
 rs6000_sysv_varargs_p =3D 0;=0A =0A-  if (cum->words < 8)=0A+  if=
 (cum->words - cum->sysv_fwords < 8)=0A     {=0A-      int first_reg_offset=
 =3D cum->words;=0A+      int first_reg_offset =3D cum->words -=
 cum->sysv_fwords;=0A =0A       if (MUST_PASS_IN_STACK (mode, type))=0A=
 	first_reg_offset +=3D RS6000_ARG_SIZE (TYPE_MODE (type), type, 1);=0A
--=====================_53744284==_--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
