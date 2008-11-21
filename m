Return-Path: <mattjfleming@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 7645ADDED2
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 20:00:57 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so46153ugm.14
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 01:00:47 -0800 (PST)
Date: Fri, 21 Nov 2008 09:00:45 +0000
From: Matt Fleming <mjf@gentoo.org>
To: Paul Mundt <lethal@linux-sh.org>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org,
	Jim Radford <radford@galvanix.net>, Steven Rostedt <srostedt@redhat.com>
Subject: Re: [PATCH 1/3] sh: dynamic ftrace support.
Message-ID: <20081121090044.GA635@console-pimps.org>
References: <20081120203415.251344054@goodmis.org>
	<20081120203551.633484431@goodmis.org>
	<20081121074428.GC28447@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081121074428.GC28447@linux-sh.org>
Sender: Matt Fleming <mattjfleming@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 21, 2008 at 04:44:29PM +0900, Paul Mundt wrote:
> On Thu, Nov 20, 2008 at 03:34:16PM -0500, Steven Rostedt wrote:
> > +} elsif ($arch eq "sh") {
> > +    $section_regex = "Disassembly of section\\s+(\\S+):";
> > +    $function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
> > +    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\smcount\$";
> > +    $type = ".long";
> > +
> > +    # force flags for this arch
> > +    $ld .= " -m shlelf_linux";
> > +    $objcopy .= " -O elf32-sh-linux";
> > +    $cc .= " -m32";
> > +
> 
> Note that if the $alignment changes are in this version, you will also
> need to add an $alignment = 2; for sh. That was in Matt's original patch,
> but I stripped the alignment line out in the commit given that it was not
> yet present in the mainline version of the script.

I've sent a patch to steven for his tip/devel branch that adds this line.
