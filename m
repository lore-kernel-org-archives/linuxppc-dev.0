Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B330DB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 12:00:18 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 076A9DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 12:00:17 +1000 (EST)
Date: Wed, 5 Aug 2009 22:00:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: ftrace scripts and make V=1
In-Reply-To: <20090805072952.GC19322@elte.hu>
Message-ID: <alpine.DEB.2.00.0908052011590.5010@gandalf.stny.rr.com>
References: <21d7e9970908050023j2807ef3bi1321ac2a1fd9a743@mail.gmail.com>
	<20090805072952.GC19322@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Wed, 5 Aug 2009, Ingo Molnar wrote:

> 
> * Dave Airlie <airlied@gmail.com> wrote:
> 
> > Hey,
> > 
> > So I spent 3-4 hrs today (I'm stupid yes) tracking down a .o 
> > breakage by blaming rawhide gcc/binutils as I was using make 
> > V=1and seeing only the compiler chain running,
> 
> Hm, is this that powerpc related build bug you just reported?

Well we tracked it down and it is powerpc64 specific.

Seems that in drivers/hwmon/lm93.c there's a function called:

   LM93_IN_FROM_REG()

But PPC64 has function descriptors and the real function names (the ones 
you see in objdump) start with a '.'. Thus this in objdump you have:

 Disassembly of section .text:

 0000000000000000 <.LM93_IN_FROM_REG>:
       0:       7c 08 02 a6     mflr    r0
       4:       fb 81 ff e0     std     r28,-32(r1)


The function name used is .LM93_IN_FROM_REG. But gcc considers symbols 
that start with ".L" as a special symbol that is used inside the assembly 
stage.

The nm passed into recordmcount uses the --synthetic option which shows 
the ".L" symbols (my runs outside of the build did not include the 
--synthetic option, so my older patch worked). We see the function as a 
local.

Now to capture all the locations that use "mcount" we need to have a 
reference to link into the object file a list of mcount callers. We need a 
reference that will not disappear. We try to use a global function and if 
that does not work, we use a local function as a reference. But to relink 
the section back into the object, we need to make it global. In this case, 
we run objcopy using --globalize-symbol and --localize-symbol to convert 
the symbol into a global symbol, link the mcount list, then convert it 
back to a local symbol.

This works great except for this case. .L* symbols can not be converted 
into a global symbol, and the mcount section referencing it will remain 
unresolved.

Try this patch and see if it fixes your issue.

Thanks!

-- Steve

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index d29baa2..4889c44 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -414,7 +414,10 @@ while (<IN>) {
 	    $offset = hex $1;
 	} else {
 	    # if we already have a function, and this is weak, skip it
-	    if (!defined($ref_func) && !defined($weak{$text})) {
+	    if (!defined($ref_func) && !defined($weak{$text}) &&
+		 # PPC64 can have symbols that start with .L and
+		 # gcc considers these special. Don't use them!
+		 $text !~ /^\.L/) {
 		$ref_func = $text;
 		$offset = hex $1;
 	    }
