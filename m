Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4340BB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 13:43:46 +1000 (EST)
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CCD4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 13:43:44 +1000 (EST)
Date: Thu, 6 Aug 2009 05:43:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace scripts and make V=1
Message-ID: <20090806034325.GA8861@elte.hu>
References: <21d7e9970908050023j2807ef3bi1321ac2a1fd9a743@mail.gmail.com>
	<20090805072952.GC19322@elte.hu>
	<alpine.DEB.2.00.0908052011590.5010@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.0908052011590.5010@gandalf.stny.rr.com>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Well we tracked it down and it is powerpc64 specific.
> 
> Seems that in drivers/hwmon/lm93.c there's a function called:
> 
>    LM93_IN_FROM_REG()
> 
> But PPC64 has function descriptors and the real function names (the ones 
> you see in objdump) start with a '.'. Thus this in objdump you have:
> 
>  Disassembly of section .text:
> 
>  0000000000000000 <.LM93_IN_FROM_REG>:
>        0:       7c 08 02 a6     mflr    r0
>        4:       fb 81 ff e0     std     r28,-32(r1)
> 
> 
> The function name used is .LM93_IN_FROM_REG. But gcc considers 
> symbols that start with ".L" as a special symbol that is used 
> inside the assembly stage.
> 
> The nm passed into recordmcount uses the --synthetic option which 
> shows the ".L" symbols (my runs outside of the build did not 
> include the --synthetic option, so my older patch worked). We see 
> the function as a local.
> 
> Now to capture all the locations that use "mcount" we need to have 
> a reference to link into the object file a list of mcount callers. 
> We need a reference that will not disappear. We try to use a 
> global function and if that does not work, we use a local function 
> as a reference. But to relink the section back into the object, we 
> need to make it global. In this case, we run objcopy using 
> --globalize-symbol and --localize-symbol to convert the symbol 
> into a global symbol, link the mcount list, then convert it back 
> to a local symbol.
> 
> This works great except for this case. .L* symbols can not be 
> converted into a global symbol, and the mcount section referencing 
> it will remain unresolved.
> 
> Try this patch and see if it fixes your issue.
> 
> Thanks!
> 
> -- Steve
> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index d29baa2..4889c44 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -414,7 +414,10 @@ while (<IN>) {
>  	    $offset = hex $1;
>  	} else {
>  	    # if we already have a function, and this is weak, skip it
> -	    if (!defined($ref_func) && !defined($weak{$text})) {
> +	    if (!defined($ref_func) && !defined($weak{$text}) &&
> +		 # PPC64 can have symbols that start with .L and
> +		 # gcc considers these special. Don't use them!
> +		 $text !~ /^\.L/) {
>  		$ref_func = $text;
>  		$offset = hex $1;
>  	    }

Ah, indeed. I'm wondering whether also emitting a build warning 
would be useful - just in the (admittedly unlikely) case of someone 
wondering about why LM93_IN_FROM_REG does not show up in function 
traces.

	Ingo
