Return-Path: <anton@ozlabs.org>
Date: Mon, 29 Oct 2007 09:57:10 -0500
From: Anton Blanchard <anton@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: boot/wrap assumes a biarch toolchain?
Message-ID: <20071029145710.GB17120@kryten>
References: <20071029140719.GA17120@kryten> <jesl3udm0e.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <jesl3udm0e.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org, jdittmer@ppp0.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi,

> If you configure your toolchain for powerpc64-linux you get a biarch
> toolchain by default.

I was wondering about people using pre biarch gcc toolchains. But I take
your point - I'm guessing binutils has been biarch for a long time.
Since we are only calling binutils functions in boot/wrap, maybe we can
just do:

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 18e3271..8961afd 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -121,13 +121,9 @@ wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
 #############
 # Bits for building various flavours of zImage
 
-ifneq ($(CROSS32_COMPILE),)
-CROSSWRAP := -C "$(CROSS32_COMPILE)"
-else
 ifneq ($(CROSS_COMPILE),)
 CROSSWRAP := -C "$(CROSS_COMPILE)"
 endif
-endif
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
