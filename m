Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32100DDE0E
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 08:32:52 +1000 (EST)
Date: Sat, 5 Jul 2008 15:32:41 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: the printk problem
In-Reply-To: <alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
Message-ID: <alpine.LFD.1.10.0807051523180.2847@woody.linux-foundation.org>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<1215212420.8970.8.camel@pasglop>
	<alpine.LFD.1.10.0807041622270.2815@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 4 Jul 2008, Linus Torvalds wrote:
> 
> Still all happily untested, of course. And still with no actual users 
> converted.

Ok, it's tested, and here's an example usage conversion.

The diffstat pretty much says it all. It _does_ change the format of the 
stack trace entry a bit, but I don't think it's for the worse (unless it 
breaks things like the oops tracker - Arjan?)

It changes the symbol-in-module format from

	:ext3:add_dirent_to_buf+0x6c/0x26c

to

	add_dirent_to_buf+0x6c/0x26c [ext3]

but quite frankly, the latter was the standard format anyway (it's what 
"sprint_symbol()" gives you), and traps_64.c was the odd man out.

In fact, traps_32.c already uses the standard print_symbol() format, so it 
really was an issue of the 64-bit code being odd (and I assume that this 
also means that it cannot break the oops tracker, since it already had to 
be able to handle both formats).

I also removed the KALLSYMS dependency, so if KALLSYMS isn't enabled it 
will now give the same hex format twice, but I doubt we really care (such 
stack traces are unreadable whether it shows up once or twice, and the 
simplicity is worth it).

If people do just a few more conversions like this, then the 52 added 
lines in lib/vsnprintf.c are more than made up for by removed lines 
elsewhere (and more readable source code).

		Linus

---
 arch/x86/kernel/traps_64.c |   25 +------------------------
 1 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/traps_64.c b/arch/x86/kernel/traps_64.c
index adff76e..f1a95d1 100644
--- a/arch/x86/kernel/traps_64.c
+++ b/arch/x86/kernel/traps_64.c
@@ -104,30 +104,7 @@ int kstack_depth_to_print = 12;
 
 void printk_address(unsigned long address, int reliable)
 {
-#ifdef CONFIG_KALLSYMS
-	unsigned long offset = 0, symsize;
-	const char *symname;
-	char *modname;
-	char *delim = ":";
-	char namebuf[KSYM_NAME_LEN];
-	char reliab[4] = "";
-
-	symname = kallsyms_lookup(address, &symsize, &offset,
-					&modname, namebuf);
-	if (!symname) {
-		printk(" [<%016lx>]\n", address);
-		return;
-	}
-	if (!reliable)
-		strcpy(reliab, "? ");
-
-	if (!modname)
-		modname = delim = "";
-	printk(" [<%016lx>] %s%s%s%s%s+0x%lx/0x%lx\n",
-		address, reliab, delim, modname, delim, symname, offset, symsize);
-#else
-	printk(" [<%016lx>]\n", address);
-#endif
+	printk(" [<%016lx>] %s%pS\n", address, reliable ? "": "? ", (void *) address);
 }
 
 static unsigned long *in_exception_stack(unsigned cpu, unsigned long stack,
