Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [128.224.252.2])
	by ozlabs.org (Postfix) with ESMTP id 78A81DDF88
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:46:10 +1100 (EST)
Date: Mon, 17 Mar 2008 18:46:08 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: powerpc: cuImage.* creation error
Message-ID: <20080317224607.GA10732@windriver.com>
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
	<20080317200754.GA7383@windriver.com>
	<fa686aa40803171541t6357d304i2e7e5292f084d09d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40803171541t6357d304i2e7e5292f084d09d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: powerpc: cuImage.* creation error
on 17/03/2008 Grant Likely wrote:

> On Mon, Mar 17, 2008 at 2:07 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > In message: powerpc: cuImage.* creation error
> >
> >  @@ -253,8 +253,8 @@ image-$(CONFIG_TQM8540)                     += cuImage.tqm8540
> >   image-$(CONFIG_TQM8541)                        += cuImage.tqm8541
> >   image-$(CONFIG_TQM8555)                        += cuImage.tqm8555
> >   image-$(CONFIG_TQM8560)                        += cuImage.tqm8560
> >  -image-$(CONFIG_SBC8548)                        += cuImage.tqm8548
> >  -image-$(CONFIG_SBC8560)                        += cuImage.tqm8560
> >  +image-$(CONFIG_SBC8548)                        += cuImage.sbc8548
> >  +image-$(CONFIG_SBC8560)                        += cuImage.sbc8560
> 
> No, the suffix in the cuImage targets has a 1:1 relationship with dts
> files in arch/powerpc/boot/dts/.  If a file doesn't exist there, then
> the target cannot be built.

You should have both the sbc8548.dts and the sbc8560.dts in your tree.
They have been in there for several weeks now.

I just tested with the above here, and I was just about to hit send on
this extra chunk to fix the second half of the problem.

Note that I didn't lump the tqm8540 in with the other tqm, because the
defconfig tends to indicate it doesn't need 85xx-cpm2;  just 85xx.

Thanks,
Paul.

--

Author: Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Mon Mar 17 18:33:52 2008 -0400

    wrapper: Add entries for tqm8540 and sbc85xx
    
    The wrapper script didn't have entries for the TQM8540 board and the
    SBC8548 or SBC8560 boards.  I've assumed that the TQM8540 console is
    8250 based and not CPM based by looking at its defconfig.  There was
    also a trailing * on the TQM8555 entry that I removed too.
    
    Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d50e498..8ec8ea8 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -174,7 +174,10 @@ cuboot*)
     *-mpc83*)
         platformo=$object/cuboot-83xx.o
         ;;
-    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555*)
+    *-tqm8540|*-sbc85*)
+        platformo=$object/cuboot-85xx.o
+        ;;
+    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555)
         platformo=$object/cuboot-85xx-cpm2.o
         ;;
     *-mpc85*)
