Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id BC805DE1FE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 00:39:24 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so328845wra.1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 07:39:22 -0700 (PDT)
Date: Thu, 28 Aug 2008 10:38:45 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Smith <paul@mad-scientist.us>
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
Message-ID: <20080828143845.GB18238@yoda.jdub.homelinux.org>
References: <1219928864.16802.69.camel@homebase.localnet>
	<200808281553.18167.arnd@arndb.de>
	<1219933848.16802.96.camel@homebase.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1219933848.16802.96.camel@homebase.localnet>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 28, 2008 at 10:30:48AM -0400, Paul Smith wrote:
>On Thu, 2008-08-28 at 15:53 +0200, Arnd Bergmann wrote:
>> The easiest solution should be to just include all your modules in
>> the kernel source as patches, rather than building them externally.
>> 
>> That will give you access to all the headers you need.
>
>It doesn't matter whether I build my code in the kernel as patches, or
>not.  The problem is not that I don't have the headers handy, it's that
>they simply don't exist in asm-ppc anymore, not even in the linux source
>tree.

Then you need to adapt your code to where ever that information moved
to?  Maybe if you post your driver code and makefile we can help you
out.

>There is no asm-ppc/ppc_asm.h in the kernel anymore.  In my code that
>includes it, where ARCH=ppc and include/asm is linked to asm-ppc, how do
>I get ahold of that file?  I can't use #include <asm/ppc_asm.h> like I
>used to.  Do I have to use #include <asm-powerpc/ppc_asm.h> explicitly?
>At least this will work... but read on:
>
>Even more troublesome are headers like <linux/posix_types.h>, which
>includes <asm/posix_types.h>, but there IS NO asm-ppc/posix_types.h file
>in the kernel tree!  There is only an asm-powerpc/posix_types.h... but
>if asm is a link to asm-ppc, this fails and I have no way to fix it!
>
>On the other hand, if I cheat and set the asm symlink pointing to
>asm-powerpc instead, then when I include files like <linux/interrupt.h>.
>which includes <linux/hardirq.h>, which includes <asm/hardirq.h>, which
>(because I have CONFIG_40X defined) includes <asm/ibm44x.h>, I get the
>opposite problem: there is no asm-powerpc/ibm4xx.h; that header exists
>only in the asm-ppc directory.  So now THAT include fails.

This is all confusing to me.  Things obviously work in-kernel, or it
wouldn't build at all.  There used to be a hack in the ppc makefiles to
add a -Iasm-powerpc (or a symlink or something) so that files _would_ find
the right headers.  Look harder at the makefiles and try to duplicate that
for your external modules.

Or move to the latest git kernel, where this problem doesn't exist at all
since arch/ppc is removed entirely :).

josh
