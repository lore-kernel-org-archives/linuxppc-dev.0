Return-Path: <amodra@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70D57B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 21:44:03 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so2393296pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 04:44:01 -0700 (PDT)
Date: Thu, 21 Jun 2012 21:13:54 +0930
From: Alan Modra <amodra@gmail.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the final tree (powerpc
 related)
Message-ID: <20120621114354.GG20973@bubble.grove.modra.org>
References: <20120620175014.a822a766e0f91f7b44f48fa0@canb.auug.org.au>
 <1340256961.1998.11.camel@concordia>
 <1340259896.3942.2.camel@pasglop>
 <1340262473.1998.19.camel@concordia>
 <1340264307.1998.20.camel@concordia>
 <20120621104839.GE20973@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120621104839.GE20973@bubble.grove.modra.org>
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2012 at 08:18:39PM +0930, Alan Modra wrote:
> Linker bug.  That's not a sibling call, but a normal function return
> via an out-of-line register restore function.

I couldn't see how this might be occurring, then I remembered the
kernel has this horrible practise of using ld -r to package object
files.  So linker generated functions might be munged together with
other functions.  Does this help?  (It won't if the kernel is
providing its own save/restore functions.)

Index: bfd/elf64-ppc.c
===================================================================
RCS file: /cvs/src/src/bfd/elf64-ppc.c,v
retrieving revision 1.387
diff -u -p -r1.387 elf64-ppc.c
@@ -6494,9 +6494,10 @@ ppc64_elf_func_desc_adjust (bfd *obfd AT
 
   /* Provide any missing _save* and _rest* functions.  */
   htab->sfpr->size = 0;
-  for (i = 0; i < sizeof (funcs) / sizeof (funcs[0]); i++)
-    if (!sfpr_define (info, &funcs[i]))
-      return FALSE;
+  if (!info->relocatable)
+    for (i = 0; i < sizeof (funcs) / sizeof (funcs[0]); i++)
+      if (!sfpr_define (info, &funcs[i]))
+	return FALSE;
 
   elf_link_hash_traverse (&htab->elf, func_desc_adjust, info);
 


-- 
Alan Modra
Australia Development Lab, IBM
