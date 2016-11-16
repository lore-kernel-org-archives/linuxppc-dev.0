Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJftz4rrRzDvkG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 21:02:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc: crypto/vmx: clean up generated files
In-Reply-To: <20161115170549.10538-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20161115170549.10538-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 16 Nov 2016 21:02:15 +1100
Message-ID: <87oa1fyc7s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> ..as stray .S files result in build errors, especially when using
> cross-compilers.

They should be cleaned on make clean, so adding them to clean-files
seems correct.

> More specifically, the generated .S files are endian-specific and will break
> subsequent builds targeting the other endian architecture.

But that indicates we're missing an if_changed somewhere, ie. switching
endian should cause them to be regenerated.

Also they should be generated into $(obj) not $(src) I think.

How about this?

diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
index de6e241..52f6ae9 100644
--- a/drivers/crypto/vmx/Makefile
+++ b/drivers/crypto/vmx/Makefile
@@ -10,10 +10,10 @@ endif
 quiet_cmd_perl = PERL $@
       cmd_perl = $(PERL) $(<) $(TARGET) > $(@)
 
-$(src)/aesp8-ppc.S: $(src)/aesp8-ppc.pl
-       $(call cmd,perl)
+$(obj)/aesp8-ppc.S: $(src)/aesp8-ppc.pl FORCE
+       $(call if_changed,perl)
   
-$(src)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl
-       $(call cmd,perl)
+$(obj)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl FORCE
+       $(call if_changed,perl)
 
 .PRECIOUS: $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S


cheers
