Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33F89DDF4C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 09:15:43 +1000 (EST)
Date: Wed, 3 Sep 2008 16:15:08 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] Correct printk %pF to work on all architectures
In-Reply-To: <1220482853.3254.47.camel@localhost.localdomain>
Message-ID: <alpine.LFD.1.10.0809031602270.3515@nehalem.linux-foundation.org>
References: <1220473137.3254.29.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031419560.3515@nehalem.linux-foundation.org>
	<1220481754.3254.42.camel@localhost.localdomain>
	<alpine.LFD.1.10.0809031546310.3515@nehalem.linux-foundation.org>
	<1220482853.3254.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-ia64@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 3 Sep 2008, James Bottomley wrote:
> 
> You want me to pull the elf header files into lib/vsprintf.c and have
> something like

No.

I want you to stop polluting <linux/module.h> with total and utter crap.

Please tell my WHY the hell you have

	diff --git a/include/linux/module.h b/include/linux/module.h
	index 68e0955..a549f89 100644
	--- a/include/linux/module.h
	+++ b/include/linux/module.h
	@@ -76,6 +76,11 @@ void sort_extable(struct exception_table_entry *start,
	                  struct exception_table_entry *finish);
	 void sort_main_extable(void);
	 
	+/* function descriptor handling (if any) */
	+#ifndef dereference_function_descriptor
	+#define dereference_function_descriptor(p) (p)
	+#endif
	+
	 #ifdef MODULE
	 #define MODULE_GENERIC_TABLE(gtype,name)                       \
	 extern const struct gtype##_id __mod_##gtype##_table           \

in your patch? What the _hell_ does that have to do with "module.h"?

Why the heck don't you just have that in the ONLY place that cares, namely 
lib/vfprintf.c?

In other words, WHY did you do something as stupid and totally 
unexplainable as

	diff --git a/lib/vsprintf.c b/lib/vsprintf.c
	index d8d1d11..0c47629 100644
	--- a/lib/vsprintf.c
	+++ b/lib/vsprintf.c
	@@ -513,16 +513,6 @@ static char *string(char *buf, char *end, char *s, int field_width, int precisio
	        return buf;
	 }
	 
	-static inline void *dereference_function_descriptor(void *ptr)
	-{
	-#if defined(CONFIG_IA64) || defined(CONFIG_PPC64)
	-       void *p;
	-       if (!probe_kernel_address(ptr, p))
	-               ptr = p;
	-#endif
	-       return ptr;
	-}
	-

when that thing _used_ to be in a place where it made sense? Why didn't 
you just change that already existing code to use a #ifdef instead?

Why do you move that to <linux/module.h>? It makes no sense.

And why do you put the arch-specific defines in <asm/module.h>? That makes 
no sense either. WHY?

As far as I can tell, the _only_ reason you happened to pick 
<linux/module.h> was literally that it is the first of our header files 
that lib/vsprintf.c includes. And quite frankly, that makes no sense. 

That's about as sensible as putting it into <linux/string.h>. 

Put those things in some _sane_ place. That means:

 - default non-implementation in lib/vsprintf.c, since there is no point 
   in putting it anywhere else, when it's not used anywhere else.

 - arch-specific implementations can go into some more sensible asm header 
   file that is more relevant. Maybe <asm/processor.h>?

IOW, I'm complaining about your totally senseless and apparently random 
choice of location.

			Linus
