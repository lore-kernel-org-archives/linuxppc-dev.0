Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BC6FADDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 01:17:01 +1000 (EST)
In-Reply-To: <20070928024052.GA18840@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-08.miltonm@bga.com>
	<20070924033612.GI8058@localhost.localdomain>
	<5e71423247aef068d82b84166102fd7d@bga.com>
	<20070925034616.GB2525@localhost.localdomain>
	<69f1ad37eec293a4c4616d04c8400ca4@bga.com>
	<20070927024535.GC14030@localhost.localdomain>
	<41180fced14196db80f261d2ac1909e0@bga.com>
	<20070928024052.GA18840@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <61d44782a59ff62300416fbed26236f0@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/15] bootwrapper: convert flatdevtree to version 16
Date: Fri, 28 Sep 2007 10:16:51 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 27, 2007, at 9:40 PM, David Gibson wrote:
> On Thu, Sep 27, 2007 at 10:44:27AM -0500, Milton Miller wrote:
>> On Sep 26, 2007, at 9:45 PM, David Gibson wrote:
>>>> The actual binary structure is compatable, just not the contents of
>>>> the
>>>> properties nor how any slave cpus wait (for some trees it doesn't
>>>> matter).
>>
>> Sorry, copy and paste error.  I was tring to point out this changelog
>> in 2.6.10:
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;
>> a=commitdiff;h=e1b47549d1588ccea1fa5726eb430aae4e80f8ed
>
> Hrm, I see, yes that seems conclusive enough.  Yuck.
>
> In which case, I think we should try to forget that v1 ever existed.
> I don't think anyone ever generated v1 trees other than kernels which
> also consumed them,

I believe this to be true, unless you count telling dtc to do so.

> and I doubt current kernels will correctly deal
> with v1 trees in this form.

I'm quite certain of that.

> In any case, this is all rather beside the point.  My basic point is
> that this bootwrapper stuff should not attempt to be a general
> backwards compatibility layer for every broken early dt format that
> ever existed.

The only broken format was v1; I was submitting v2 :-).  Version 16 was  
"... to support a more compact representation, for use by embedded  
systems mostly"  
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git; 
a=commitdiff;h=34153fa3af45d84f3221d9b67ba2ab7e8a220d28

> In general we should try to make sure nothing ever uses
> <v16 trees.  We want, here, to do the minimum we can get away with to
> support the specific v2 trees produced by kexec-tools, as an interim
> measure

As I stated, that by itself isn't sufficient for my usage, as I have  
other v2 trees I need to deal with, at least until that generator gets  
updated.

> while kexec-tools itself is fixed to produce v17 trees (say,
> by replacing fs2dt with dtc plus a libfdt based post-processing
> program).

If you thought there were complaints trying to require an external  
utility to build zImage, just wait until you try to make kexec-tools  
not be self-contained.  Currently kexec doesn't even use a data  
directory, instead it builds the purgatory and other trampoline  
binaries into the kexec program.  Incorporating the post-processing and  
generation using libfdt (with a copy of the library in the source)  
could fly, if people don't care about kexec into kernels from 2.6.10 to  
2.6.14 when v16 was merged (about 1 year).

Actually, there is another approach: put this converter in kexec's  
purgatory or even the kexec program.  It can then run conditionally  
under command line flags to keep compatibility with the old kernels.   
If and when its is decided to only support >=v16 in kexec-tools it can  
be removed and we don't have this interim support code in the kernel  
forever (I'll handle my other usage out of tree).

milton
