Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4HJR3lc5zDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 01:37:43 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y134so14855840pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 08:37:43 -0700 (PDT)
Date: Thu, 4 Aug 2016 01:37:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Fengguang Wu
 <fengguang.wu@intel.com>, linuxppc-dev@lists.ozlabs.org, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160804013729.7fffa45a@roar.ozlabs.ibm.com>
In-Reply-To: <5216072.9VpDc0iy8Q@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <1944325.MtNrGQyQle@wuerfel>
 <20160803221911.2f76ccad@canb.auug.org.au>
 <5216072.9VpDc0iy8Q@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 03 Aug 2016 14:29:13 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, August 3, 2016 10:19:11 PM CEST Stephen Rothwell wrote:
> > Hi Arnd,
> > 
> > On Wed, 03 Aug 2016 09:52:23 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> > >
> > > Using a different way to link the kernel would also help us with
> > > the remaining allyesconfig problem on ARM, as the problem is only in
> > > 'ld -r' not producing trampolines for symbols that later cannot get
> > > them any more. It would probably also help building with ld.gold,
> > > which is currently not working.
> > > 
> > > What is your suggested alternative?  
> > 
> > I have a patch that make the built-in.o files into thin archives (same
> > as archives, but the actual objects are replaced with the name of the
> > original object file).  That way the final link has all the original
> > objects.  I haven't checked to see what the overheads of doing it this
> > way is.
> > 
> > Nick Piggin has just today taken my old patch (it was last rebased to
> > v4.4-rc1) and tried it on a recent kernel and it still seems to mostly
> > work.  It probably needs some tidying up, but you are welcome to test
> > it if you want to.  
> 
> Sure, I'll certainly give it a try on ARM when you send me a copy.

I've attached what I'm using, which builds and runs for me without
any work. Your arch obviously has to select the option to use it.

    text      data     bss      dec       hex     filename
    11196784  1185024  1923820  14305628  da495c  vmlinuxppc64.before
    11187536  1181848  1923176  14292560  da1650  vmlinuxppc64.after
    
~9K text saving, ~3K data saving. I assume this comes from fewer
branch trampolines and toc entries, but haven't verified exactly.



commit 8bc3ca4798c215e9a9107b6d44408f0af259f84f
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Oct 30 12:14:18 2012 +1100

    kbuild: allow architectures to use thin archives instead of ld -r
    
    Alan Modra has been trying to convince the kernel developers that ld -r
    is "evil" for many years.  This is an alternative and means that the
    linker has much more information available to it when it links the
    kernel.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/arch/Kconfig b/arch/Kconfig
index d794384..1330bf4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -424,6 +424,12 @@ config CC_STACKPROTECTOR_STRONG
 
 endchoice
 
+config THIN_ARCHIVES
+	bool
+	help
+	  Select this if the architecture wants to use thin archives
+	  instead of ld -r to create the built-in.o files.
+
 config HAVE_CONTEXT_TRACKING
 	bool
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0d1ca5b..bbf60b3 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -358,10 +358,15 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
 # Rule to compile a set of .o files into one .o file
 #
 ifdef builtin-target
+ifdef CONFIG_THIN_ARCHIVES
+  cmd_make_builtin = rm -f $@; $(AR) rcsT$(KBUILD_ARFLAGS)
+else
+  cmd_make_builtin = $(LD) $(ld_flags) -r -o
+endif
 quiet_cmd_link_o_target = LD      $@
 # If the list of objects to link is empty, just create an empty built-in.o
 cmd_link_o_target = $(if $(strip $(obj-y)),\
-		      $(LD) $(ld_flags) -r -o $@ $(filter $(obj-y), $^) \
+		      $(cmd_make_builtin) $@ $(filter $(obj-y), $^) \
 		      $(cmd_secanalysis),\
 		      rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@)
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f0f6d9d..ef4658f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -41,8 +41,14 @@ info()
 # ${1} output file
 modpost_link()
 {
-	${LD} ${LDFLAGS} -r -o ${1} ${KBUILD_VMLINUX_INIT}                   \
-		--start-group ${KBUILD_VMLINUX_MAIN} --end-group
+	local objects
+
+	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+		objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
+	else
+		objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
+	fi
+	${LD} ${LDFLAGS} -r -o ${1} ${objects}
 }
 
 # Link of vmlinux
@@ -51,11 +57,16 @@ modpost_link()
 vmlinux_link()
 {
 	local lds="${objtree}/${KBUILD_LDS}"
+	local objects
 
 	if [ "${SRCARCH}" != "um" ]; then
+		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
+			objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
+		else
+			objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
+		fi
 		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}                  \
-			-T ${lds} ${KBUILD_VMLINUX_INIT}                     \
-			--start-group ${KBUILD_VMLINUX_MAIN} --end-group ${1}
+			-T ${lds} ${objects} ${1}
 	else
 		${CC} ${CFLAGS_vmlinux} -o ${2}                              \
 			-Wl,-T,${lds} ${KBUILD_VMLINUX_INIT}                 \
