Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71F91679E9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:02:36 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kBCNEitm154506
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:14:44 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBCN5m3j135630
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:05:48 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBCN2KGq007107
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:02:20 +1100
Date: Wed, 13 Dec 2006 10:02:11 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Edi Shmueli <edi@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] PPC32 : Huge-page support for ppc440 - 2.6.19-rc4 -
	revised
Message-ID: <20061212230211.GC12707@localhost.localdomain>
References: <45705FA3.4040904@linux.vnet.ibm.com>
	<20061204070100.GB32026@localhost.localdomain>
	<457ED2F7.9070406@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <457ED2F7.9070406@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2006 at 11:04:07AM -0500, Edi Shmueli wrote:
[snip]
> Thanks David,
> One step at a time, lets start with libhugetlbfs :-)
> I'm successfully able to run most of my tests using the library, backing my data,text and BSS with huge-pages.
> There is a major improvement in performance, similar to what I reported above.
> Good job with the library !!!

Ok.. how does the library's own testsuite go ("make check").  That
testsuite has tests for kernel bugs as well as library bugs.

> There is a problem though when a program calls "fopen".
> I see hugetlbfs does the unmapping/mapping , moves control to main(),
> and then a crash with the following error:
> "*** glibc detected *** free(): invalid pointer: 0x3002a008 ***"
> This happens inside fopen() (....which never returns).

Ok, do you get any similar problems with the minimal tests in the
testsuite?

`> Here is the detailed output.
> 
> /bgd-public/edi/IS # ./is.A.linux_ser_hugetlbfs
> libhugetlbfs: Hugepage segment 0 (phdr 2): 0x10000000-0x10001b70  (filesz=0x1b70) (prot = 0x5)
> libhugetlbfs: Hugepage segment 1 (phdr 3): 0x11000000-0x170006e8  (filesz=0x274) (prot = 0x7)
> libhugetlbfs: HUGETLB_SHARE=0, sharing disabled
> libhugetlbfs: Got unshared fd as expected -- Preparing
> libhugetlbfs: Mapped hugeseg at 0x31000000. Copying 0x1b70 bytes from 0x10000000...
> done
> libhugetlbfs: Minimal copy was not performed
> libhugetlbfs: Prepare succeeded
> libhugetlbfs: HUGETLB_SHARE=0, sharing disabled
> libhugetlbfs: Got unshared fd as expected -- Preparing
> libhugetlbfs: Mapped hugeseg at 0x31000000. Copying 0x274 bytes from 0x11000000...
> done
> libhugetlbfs: Minimal copy was not performed
> libhugetlbfs: Prepare succeeded
> *** glibc detected *** free(): invalid pointer: 0x3002a008 ***
> Aborted

If you can send me a non-whitespace-mangled version of your patch, I
can try to replicate this here.  If you made any hacks to libhugetlbfs
to get it working on ppc32, a patch for those would be handy too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
