Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 743EA1A0009
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 11:06:43 +1000 (EST)
Date: Tue, 8 Jul 2014 11:06:42 +1000
From: Anton Blanchard <anton@samba.org>
To: Tony Breeds <tony@bakeyournoodle.com>, grant.likely@secretlab.ca
Subject: Re: Kernel build issues after yesterdays merge by Linus
Message-ID: <20140708110642.1193b53e@kryten>
In-Reply-To: <20140613051559.GC19628@thor.bakeyournoodle.com>
References: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
 <20140612220912.3447677f@kryten>
 <20140613051559.GC19628@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@gentwo.org>, Brian Hart <hartb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Tony,

> > Shows how much we use make install :) Below is a quick hack to get
> > you going but we should look at either fixing the Ubuntu
> > installkernel to handle extra optional args, or stop passing them
> > from the ppc64 kernel install.sh script.
> 
> It seems like passign the zImage files is probably wrong.  How about:

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ccc25ed..146d898 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -390,7 +390,7 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
 
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
-	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
+	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
 
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \


Looks reasonable to me. Grant added this back in commit 29f1aff2 (powerpc:
Copy bootable images in the default install script) but the other archs have
gone in a different direction and created make zinstall targets.

Anton
