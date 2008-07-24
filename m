Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-masked.atl.sa.earthlink.net
	(elasmtp-masked.atl.sa.earthlink.net [209.86.89.68])
	by ozlabs.org (Postfix) with ESMTP id 95C7CDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:39:43 +1000 (EST)
Message-ID: <488912BC.6040706@mindspring.com>
Date: Thu, 24 Jul 2008 19:39:40 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix build bug with binutils < 2.18 and GCC < 4.2
References: <31a45a6b0f4087a6e54b05241eebc9f94202ffe5.1216681294.git.segher@kernel.crashing.org>
	<48872AB4.3010001@mindspring.com>
	<bd512e1b36a954819f09379908e342fb@kernel.crashing.org>
	<48882217.5010609@mindspring.com>
	<3c19f5225b292a011665f127c55e58f7@kernel.crashing.org>
In-Reply-To: <3c19f5225b292a011665f127c55e58f7@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> [putting linuxppc-dev on Cc:, hope you don't mind]
> 
> On 24 jul 2008, at 08:32, Chuck Meade wrote:
> 
>>>> I wanted to reply to your original message regarding this, but sadly I
>>>> had
>>>> already deleted it.  So I am sending directly to you.
>>>>
>>>> This patch broke my link.
>>>
>>> Sorry.  I didn't test with anything _that_ ancient.
>>>
>>>> Reverting it, I am again able to link the latest
>>>> git fetch of the kernel, but with your patch, my ld breaks.
>>>>
>>>> I am using binutils 2.15, successfully until this patch was applied
>>>> yesterday.
>>>
>>> What target / what config / what exact GCC version / what
>>> exact binutils version / why are you using such an ancient
>>> toolchain anyway?  :-)
> 
>> I have been using gcc 3.4.4 and binutils 2.15 up to this point without
>> problems.  Yes they are not cutting-edge by any means,
> 
> Updating to GCC 3.4.6 might be a good idea, it's the latest bug fix
> release in the 3.4 series.  I agree PowerPC Linux should still be
> buildable with GCC 3.4; I don't think we really care about 3.3 or
> older anymore though.
> 
>> but the concern
>> here is that this patch causes the linker to fail for the first time.
>> Up until now the link has worked fine, and if I revert this patch, the
>> link continues to work well.
> 
> Yeah, I understand.  I'm not saying you need to upgrade your toolchain
> (or, I'm not yet saying that anyway; will have to see what causes this
> problem first); I just said I neglected to test with anything that old.
> 
>> For one of my customers, we use a customized build system that can share
>> cross toolsets for builds of multiple platforms.  So the fact that
>> these tools have worked for us cross several 83xx platforms for a long
>> time is valuable.  It would be highly desirable to have the linker
>> continue to work.
> 
> Sure, I'll try my best to find out what is wrong, and fix it for you
> if possible.
> 
>> I am very willing to work with you and test the alternative patch ideas
>> you have for vmlinux.lds.S on my tools here.  This patch was in the
>> general interest of backwards-compatibility with pre-2.18 binutils
>> anyway.
> 
> Yes, exactly: 2.6.26 does not build with binutils 2.17.
> 
>> I can help you by testing on 2.15.  Send me alternate vmlinux.lds.S files
>> to try, and I will test and get back to you ASAP.
> 
> No, I will not send you randomly changed source files and hope they
> will do something useful for you.  Instead, why not provide me the
> information I asked for?  What target (arch/powerpc it sounds like?)
> What _exact_ binutils version (FSF 2.15?)  What _exact_ GCC version
> (FSF 3.4.4?)  What Linux config (either the full .config, or the
> name of a defconfig)?

No problem -- I thought it would be helpful to offer to test changes for you,
so we could work together toward a solution.

The gcc version is 3.4.4.  This is from source tarball gcc-3.4.4.tar.bz2,
downloaded from ftp.gnu.org, built myself using crosstool.
Here is the version output:

$ ./powerpc-8325-linux-gnu-gcc --version
powerpc-8325-linux-gnu-gcc (GCC) 3.4.4
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

The binutils are version 2.15, from source tarball binutils-2.15.tar.bz2.
Downloaded from ftp.gnu.org.  Built myself using crosstool.
Here is the version output:

$ ./powerpc-8325-linux-gnu-ld --version
GNU ld version 2.15
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.

The target arch/powerpc.  The Linux defconfig was mpc836x_rdk_defconfig.

>> The link error, in case you were wondering, was:
> 
> Yes, I forgot to ask for that :-)
> 
>> powerpc-8325-linux-gnu-ld: final link failed: File truncated
> 
> What was the command line here?  Was it the linking of vmlinux?

The command line was "make ARCH=powerpc uImage".  The step that failed
was the linking of vmlinux.
If you look at the email to the linuxppc-dev list from this evening at
7:07 pm (about 30 minutes ago), Jon Tollefson is encountering the same
error now.

At the risk of providing too much detail -- if you issue the same build
command with "V=1" appended, it shows the failing link command.  Entering
that failing link command at the command line, I can remove all of the files
from the link, one by one, until only kernel/built-in.o is left, and still get
the "File truncated" error.
Of course once you remove enough files from the link line there are other
errors --  "undefined reference" problems that show up -- but the "File truncated"
error is related to kernel/built-in.o.  Hope that helps a bit.

Let me know if you have any questions.

Thanks,
Chuck

> 
> 
> Segher
> 
> 
