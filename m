Message-ID: <3C0CFC3C.6060906@acm.org>
Date: Tue, 04 Dec 2001 10:39:24 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to PPC Linux required for GCC 3.1
References: <200112041616.LAA25074@makai.watson.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000802060407010405020806"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000802060407010405020806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Edelsohn wrote:

>	What GCC patches do you need to build PowerPC Linux?
>
>David
>
I believe the following patch is all that is left, I've gotten
everything else into the 3.1 stream.  I'm working with the GCC
maintainers to get this one in.

-Corey


--------------000802060407010405020806
Content-Type: text/plain;
 name="gcc-ppc-3.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-ppc-3.1.diff"

Index: recog.c
===================================================================
RCS file: /cvs/gcc/gcc/gcc/recog.c,v
retrieving revision 1.133
diff -u -r1.133 recog.c
--- recog.c	2001/11/02 10:52:08	1.133
+++ recog.c	2001/12/04 16:33:26
@@ -512,7 +512,8 @@
          separated from this function.  */
       if (GET_CODE (XEXP (x, 1)) == CONST_INT)
 	validate_change (object, loc,
-			 plus_constant (XEXP (x, 0), INTVAL (XEXP (x, 1))), 1);
+			 simplify_gen_binary
+			 (PLUS, GET_MODE (x), XEXP (x, 0), XEXP (x, 1)), 1);
       break;
     case MINUS:
       if (GET_CODE (XEXP (x, 1)) == CONST_INT
Index: simplify-rtx.c
===================================================================
RCS file: /cvs/gcc/gcc/gcc/simplify-rtx.c,v
retrieving revision 1.86
diff -u -r1.86 simplify-rtx.c
--- simplify-rtx.c	2001/11/14 13:51:10	1.86
+++ simplify-rtx.c	2001/12/04 16:33:27
@@ -95,6 +95,7 @@
 #define HWI_SIGN_EXTEND(low) \
  ((((HOST_WIDE_INT) low) < 0) ? ((HOST_WIDE_INT) -1) : ((HOST_WIDE_INT) 0))

+rtx neg_const_int PARAMS ((enum machine_mode, rtx));
 static int simplify_plus_minus_op_data_cmp PARAMS ((const void *,
 						    const void *));
 static rtx simplify_plus_minus		PARAMS ((enum rtx_code,
@@ -107,6 +108,17 @@
 static void simplify_binary_is2orm1	PARAMS ((PTR));

 
+/* Negate a CONST_INT rtx, truncating (because a conversion from a
+   maximally negative number can overflow). */
+rtx
+neg_const_int (mode, i)
+     enum machine_mode mode;
+     rtx i;
+{
+  return GEN_INT (trunc_int_for_mode (- INTVAL (i), mode));
+}
+
+
 /* Make a binary operation by properly ordering the operands and
    seeing if the expression folds.  */

@@ -136,10 +148,9 @@
       && GET_MODE (op0) != VOIDmode
       && (code == PLUS || code == MINUS))
     {
-      HOST_WIDE_INT value = INTVAL (op1);
       if (code == MINUS)
-	value = -value;
-      return plus_constant (op0, value);
+	op1 = neg_const_int (mode, op1);
+      return plus_constant (op0, INTVAL (op1));
     }
   else
     return gen_rtx_fmt_ee (code, mode, op0, op1);
@@ -1276,7 +1287,9 @@

 	  /* Don't let a relocatable value get a negative coeff.  */
 	  if (GET_CODE (op1) == CONST_INT && GET_MODE (op0) != VOIDmode)
-	    return plus_constant (op0, - INTVAL (op1));
+	    return simplify_gen_binary (PLUS, mode,
+					op0,
+					neg_const_int (mode, op1));

 	  /* (x - (x & y)) -> (x & ~y) */
 	  if (GET_CODE (op1) == AND)
@@ -1787,7 +1800,7 @@
 	    case CONST_INT:
 	      if (this_neg)
 		{
-		  ops[i].op = GEN_INT (- INTVAL (this_op));
+		  ops[i].op = neg_const_int (mode, this_op);
 		  ops[i].neg = 0;
 		  changed = 1;
 		}
@@ -1848,7 +1861,7 @@
 		    if (GET_CODE (tem) == NEG)
 		      tem = XEXP (tem, 0), lneg = !lneg;
 		    if (GET_CODE (tem) == CONST_INT && lneg)
-		      tem = GEN_INT (- INTVAL (tem)), lneg = 0;
+		      tem = neg_const_int (mode, tem), lneg = 0;

 		    ops[i].op = tem;
 		    ops[i].neg = lneg;
@@ -1881,10 +1894,10 @@
       && GET_CODE (ops[n_ops - 1].op) == CONST_INT
       && CONSTANT_P (ops[n_ops - 2].op))
     {
-      HOST_WIDE_INT value = INTVAL (ops[n_ops - 1].op);
+      rtx value = ops[n_ops - 1].op;
       if (ops[n_ops - 1].neg ^ ops[n_ops - 2].neg)
-	value = -value;
-      ops[n_ops - 2].op = plus_constant (ops[n_ops - 2].op, value);
+	value = neg_const_int (mode, value);
+      ops[n_ops - 2].op = plus_constant (ops[n_ops - 2].op, INTVAL (value));
       n_ops--;
     }


--------------000802060407010405020806--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
