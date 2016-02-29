Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 322251A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 10:08:35 +1100 (AEDT)
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5F23140B9E
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 10:08:34 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id l6so2889320pfl.3
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 15:08:34 -0800 (PST)
Date: Tue, 1 Mar 2016 10:08:25 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: selftests/powerpc: Remove -flto from common CFLAGS
Message-ID: <20160301100825.67747147@camb691>
In-Reply-To: <20160229111013.71B58140779@ozlabs.org>
References: <1456727395-27386-1-git-send-email-sjitindarsingh@gmail.com>
 <20160229111013.71B58140779@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 29 Feb 2016 22:10:13 +1100 (AEDT)
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hi Suraj,
> 
> On Mon, 2016-29-02 at 06:29:55 UTC, Suraj Jitindar Singh wrote:
> > LTO can cause GCC to inline some functions which have attributes set. The  
> 
> You should define what LTO is the first time you use it.
> 
> > act of inlining the functions can lead to GCC forgetting about the
> > attributes which leads to incorrect tests.
> > Notable example being: __attribute__((__target__("no-vsx")))  
> 
> That is probably a GCC bug, but we still need to work around it for now.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70010

> 
> > LTO can also interact strangely with custom assembly functions and cause
> > tests to intermittently fail.  
> 
> That's probably Cyril writing bad asm :)

No doubt.

> 
> > Both these cases are hard to detect and require manual inspection of
> > binaries which is unlikely to happen for all tests. Furthermore, LTO
> > optimisations are not necessary for selftests and correctness is paramount
> > and as such it is best to disable LTO.
> > 
> > LTO can be enabled on a per test basis.
> > 
> > A pseries_le_defconfig kernel on a POWER8 was used to determine that the
> > same subset of selftests pass and fail with and without -flto in the
> > common Makefile.
> > 
> > These tests always fail:
> > selftests: per_event_excludes [FAIL]
> > selftests: event_attributes_test [FAIL]
> > selftests: ebb_vs_cpu_event_test [FAIL]
> > selftests: cpu_event_vs_ebb_test [FAIL]
> > selftests: cpu_event_pinned_vs_ebb_test [FAIL]  
> 
> They shouldn't :)
> 
> Are you running as root? Bare metal or guest?
> 

Interesting. I believe this was run baremetal as root. I'm going to test the
patch in qemu at root. Is there a list of expected failures in certain
situations?

> > selftests: ipc_unmuxed [FAIL]  
> 
> That one is expected.
> 
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
