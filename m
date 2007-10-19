Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 72274DDE32
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 15:56:45 +1000 (EST)
In-Reply-To: <20071019014510.GD30283@localhost.localdomain>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
	<20071018195926.GA22887@uranus.ravnborg.org>
	<20071019014510.GD30283@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1b5c57d93e45d94d007b543ea5e2de02@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Merge dtc
Date: Fri, 19 Oct 2007 00:56:41 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Sam Ravnborg <sam@ravnborg.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Oct 18, 2007, at 8:45 PM, David Gibson wrote:
> On Thu, Oct 18, 2007 at 09:59:26PM +0200, Sam Ravnborg wrote:
>> On Thu, Oct 18, 2007 at 12:49:54PM -0500, Milton Miller wrote:
>>> On Tue Oct 16 15:02:17 EST 2007, David Gibson wrote:
>>>
>>>> This very large patch incorporates a copy of dtc into the kernel
>>>> source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
>>>> longer an external dependency to build kernels with configurations
>>>> which need a dtb file.
>
>> As Milton already pointed out you should build dtc in the
>> dtc directory (why the -src prefix??).
>
> The -src suffix is only there because I'm not building in the
> directory - we can't have both a dtc binary and a dtc directory in
> arch/powerpc/boot.

So run the dtc binary stored in the sub directory.  Thats what we do 
elsewhere.

> Ok, so how do I build in the subdirectory?  I was going to do that,
> but couldn't for the life of me figure out how.

Documentation/kbuild/makefiles.txt  6.4 boot images:

         "$(Q)$(MAKE) $(build)=<dir>" is the recommended way to invoke
         make in a subdirectory.

Section 4 Host Program Support is also relavent, and mentions $(always).


>> And the dtc specific Makefile looks like something from
>> the late 80'. Please drop all these ALLUPPERCASE variables
>> and accept a little bit of redundancy.
>
> Hrm... I'm pretty dubious about this.  Practically every Makefile in
> the universe, *except* Kbuild uses uppercase for most variables.
> Makefile.dtc is imported verbatim from the standalone dtc package, and
> is supposed to have the minimal information about what needs to be
> built to import into Makefiles that actually know how to build things.
>
>> Then mere humans may be able to read the Makefile.
>
> Says a maintainer of Kbuild, about my tiny and not-very-complex
> Makefile fragment... um, ok...

overley complex calls to override source, conditional rules based on 
shipped files?  Its not a trivial fragment.

milton
