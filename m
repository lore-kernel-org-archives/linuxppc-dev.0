Return-Path: <dan@embeddedalley.com>
Received: from smtp109.biz.mail.mud.yahoo.com (smtp109.biz.mail.mud.yahoo.com
	[68.142.201.178]) by ozlabs.org (Postfix) with SMTP id 91FBDDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 05:27:37 +1000 (EST)
In-Reply-To: <F3D55679E1DCFF49A57570501B70475F070D83BC@CL5EXBE04.ad2.softcom.biz>
References: <F3D55679E1DCFF49A57570501B70475F070D83BC@CL5EXBE04.ad2.softcom.biz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/alternative; boundary=Apple-Mail-2-86657980
Message-Id: <2E051C72-669C-43A2-AB4D-8BBA4907B5BE@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Breakpoint is not hitting for Kernel Debugging
Date: Mon, 3 Sep 2007 12:20:55 -0700
To: dnl <ssaravanan@mail2web.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-2-86657980
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Sep 3, 2007, at 7:02 AM, dnl wrote:

> Hi all,
>
> I am using uboot and montavista kernel for our custom MPC8555CDS  
> board.

You should contact MontaVista first, since we really
don't know what your source code looks like.  I'm
assuming it's a ppc, not powerpc, although the patch
is similar for either choice.  I'd suggest this as a starting
point:

diff -Naru linux-2.6.21/arch/ppc/kernel/head_fsl_booke.S linux-2.6.21- 
dbg/arch/ppc/kernel/head_fsl_booke.S
--- linux-2.6.21/arch/ppc/kernel/head_fsl_booke.S       2007-07-05  
13:08:16.000000000 -0800
+++ linux-2.6.21-dbg/arch/ppc/kernel/head_fsl_booke.S   2007-07-10  
03:45:33.000000000 -0800
@@ -317,6 +322,16 @@
         /* clear any residual debug events */
         li      r2,-1
         mtspr   SPRN_DBSR,r2
+#else
+       /* Enable BDI200 debugging beyond this point for "normal"
+        * kernel debugging.  If you are debugging code prior to this
+        * point, it needs to be done with more specific set up
+        * of configuration files and boot rom.
+        */
+       mfmsr   r2
+       ori     r2, r2, MSR_DE
+       mtmsr   r2
+       isync
#endif

Your first breakpoint should be a hard breakpoint
at the label start_kernel.  You can then switch to
soft breakpoints and continue your debugging.

Ultimate Solutions have some useful white papers
on kernel debugging with the BDI2000 (that some
people have plagiarized).  Check out ultsol.com

Good Luck.

	-- Dan


--Apple-Mail-2-86657980
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><BR><DIV><DIV>On Sep 3, 2007, at =
7:02 AM, dnl wrote:</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite"><P><FONT =
size=3D"2">Hi all,<BR> <BR> I am using uboot and montavista kernel for =
our custom MPC8555CDS board.<BR></FONT></P></BLOCKQUOTE><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>You should contact MontaVista =
first, since we really</DIV><DIV>don't know what your source code looks =
like.=A0 I'm</DIV><DIV>assuming it's a ppc, not powerpc, although the =
patch</DIV><DIV>is similar for either choice.=A0 I'd=A0suggest this as a =
starting</DIV><DIV>point:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>diff -Naru =
linux-2.6.21/arch/ppc/kernel/head_fsl_booke.S =
linux-2.6.21-dbg/arch/ppc/kernel/head_fsl_booke.S</DIV><DIV>--- =
linux-2.6.21/arch/ppc/kernel/head_fsl_booke.S=A0 =A0 =A0=A0 2007-07-05 =
13:08:16.000000000 -0800</DIV><DIV>+++ =
linux-2.6.21-dbg/arch/ppc/kernel/head_fsl_booke.S=A0=A0 2007-07-10 =
03:45:33.000000000 -0800</DIV><DIV>@@ -317,6 +322,16 @@</DIV><DIV>=A0 =A0 =
=A0 =A0 /* clear any residual debug events */</DIV><DIV>=A0 =A0 =A0 =A0 =
li=A0 =A0 =A0 r2,-1</DIV><DIV>=A0 =A0 =A0 =A0 mtspr=A0=A0 =
SPRN_DBSR,r2</DIV><DIV>+#else=A0 </DIV><DIV>+=A0 =A0 =A0=A0 /* Enable =
BDI200 debugging beyond this point for "normal"</DIV><DIV>+=A0 =A0 =A0 =A0=
 * kernel debugging.=A0 If you are debugging code prior to =
this</DIV><DIV>+=A0 =A0 =A0 =A0 * point, it needs to be done with more =
specific set up</DIV><DIV>+=A0 =A0 =A0 =A0 * of configuration files and =
boot rom.</DIV><DIV>+=A0 =A0 =A0 =A0 */</DIV><DIV>+=A0 =A0 =A0=A0 =
mfmsr=A0=A0 r2</DIV><DIV>+=A0 =A0 =A0=A0 ori=A0 =A0=A0 r2, r2, =
MSR_DE</DIV><DIV>+=A0 =A0 =A0=A0 mtmsr=A0=A0 r2</DIV><DIV>+=A0 =A0 =A0=A0 =
isync</DIV><DIV> #endif</DIV><DIV><BR><BLOCKQUOTE =
type=3D"cite"></BLOCKQUOTE></DIV>Your first breakpoint should be a hard =
breakpoint<DIV>at the label start_kernel.=A0 You can then switch =
to</DIV><DIV>soft breakpoints and continue your debugging.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Ultimate Solutions have =
some useful white papers</DIV><DIV>on kernel debugging with the BDI2000 =
(that some</DIV><DIV>people have=A0plagiarized).=A0 Check out =
ultsol.com</DIV><DIV><BR><DIV>Good Luck.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><SPAN =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</SPAN>-- =
Dan</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV></DIV></BODY></HTML>=

--Apple-Mail-2-86657980--
