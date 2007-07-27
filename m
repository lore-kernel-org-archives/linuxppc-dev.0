Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	by ozlabs.org (Postfix) with ESMTP id 5C1ADDDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 04:56:04 +1000 (EST)
Message-ID: <46AA3FB8.8030301@nortel.com>
Date: Fri, 27 Jul 2007 12:55:52 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: help with ppc sections?
References: <46A8F22E.6010701@nortel.com>
	<fa686aa40707261255x23b06ff4y5fe1527f72c09c5b@mail.gmail.com>
In-Reply-To: <fa686aa40707261255x23b06ff4y5fe1527f72c09c5b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Mild question; What the *@*#^$! are you doing trying to backport to a
> 2 year old kernel?!?  :-)

That's what happens in the embedded space.  It's the current version 
from our distro vendor.  It's also the version that all our different 
board suppliers could agree to provide support for.

Of course, it's also a royal pain.

>> Unfortunately for me, ppc doesn't have a ".section" line in that macro,
>> so I'm at a bit of a loss.

> Just add the section.  Should be trivial to do.  You might have to add
> it to the linker script as well.

I've done the linker script part already.  As for the processor.h bit, 
does this seem reasonable?  It seems to do the trick based on the 
function addresses, but I may be missing something and I haven't 
actually booted it yet.

The ppc64 version appends ',"a"' to the kprobes.text section line.  Is 
this needed here as well?  Could someone elaborate on exactly what its 
purpose is?

Thanks,

Chris


Index: linux-ias/include/asm-ppc/processor.h
===================================================================
--- linux-ias.orig/include/asm-ppc/processor.h
+++ linux-ias/include/asm-ppc/processor.h
@@ -38,6 +38,13 @@

  #define _GLOBAL(n)\
  	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
+	.section ".text"; \
+	.globl n;\
+n:
+
+#define _KPROBE(n)\
+	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
+	.section ".kprobes.text","a"; \
  	.globl n;\
  n:
