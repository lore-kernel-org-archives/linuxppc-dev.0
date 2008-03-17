Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 222E1DE231
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:39:18 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1233349ana.81
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 15:39:17 -0700 (PDT)
Message-ID: <fa686aa40803171539m65d58a1aqc09c0bd717a04cf8@mail.gmail.com>
Date: Mon, 17 Mar 2008 16:39:13 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Adrian Bunk" <bunk@kernel.org>
Subject: Re: powerpc: cuImage.* creation error
In-Reply-To: <20080317193652.GA9550@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 1:36 PM, Adrian Bunk <bunk@kernel.org> wrote:
> When building all powerpc defconfigs in 2.6.25-rc6 exactly three of
>  them fail to build, and all with similar problems:
>

Looks like I added a bogus target (no dts file for the board yet) and
didn't match correctly the init code for the other two.  Please try
this:

--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -253,7 +253,6 @@ image-$(CONFIG_TQM8540)                     += cuImage.tqm85
 image-$(CONFIG_TQM8541)                        += cuImage.tqm8541
 image-$(CONFIG_TQM8555)                        += cuImage.tqm8555
 image-$(CONFIG_TQM8560)                        += cuImage.tqm8560
-image-$(CONFIG_SBC8548)                        += cuImage.tqm8548
 image-$(CONFIG_SBC8560)                        += cuImage.tqm8560

 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d50e498..511e09e 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -174,7 +174,7 @@ cuboot*)
     *-mpc83*)
         platformo=$object/cuboot-83xx.o
         ;;
-    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555*)
+    *-tqm854?|*-mpc8560*|*-tqm8560|*-tqm8555*)
         platformo=$object/cuboot-85xx-cpm2.o
         ;;
     *-mpc85*)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
