Date: Mon, 23 Aug 2004 01:04:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: port from 2.4.21 to 2.6.8 for mpc5200 - part 1
Message-ID: <20040822230436.GD8639@mars.ravnborg.org>
References: <679770249.20040822223108@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <679770249.20040822223108@varma-el.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Aug 22, 2004 at 10:31:08PM +0400, Andrey Volkov wrote:
> Hi all,
>
> Below path of kernel-2.6.8.1 for Motorola MPC5200.
> This patch was based on MontaVista 2.4.21 kernel, and
> included:
>
> * Motorola BestComm API support
> * little correction in Kconfig/Makefile to support it

A few random comments.

	Sam

1) Please remove the following comment from the Makefiles:
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definition is now in the main makefile...

It is no longer relevant for 2.6

2) -objs -> -y
Preferred style is:
+bestcomm-y		:=	bestcomm_api.o \

Same functionality though.

3) Comment style does not look like kernel-doc??

4) Coding style not followed
- Mixed casing
- if ( xx ) => if (xx)
- if( => if (
- int
  mpc52xx_sdma_fec =>
  int mpc52xx_sdma_fec


5) This code should be deleted:
+#ifndef NULL
+# define NULL ((void *)0)
+#endif	/* NULL */

6) Linux style is to avoid typedefs
+typedef sint8 TaskId;
+typedef sint8 BDIdx;
Kill those

7) if MPC52xx_SDMA_DEDUG
Hide this check in a function - not at all file

8) In general lot of preprocessor conditionals that should be minimized


	Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
