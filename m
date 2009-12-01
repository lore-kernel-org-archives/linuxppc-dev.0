Return-Path: <jkenisto@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90EC51007D2
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Dec 2009 06:14:16 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB1JCs7Z025746
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Dec 2009 12:12:54 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB1JDr9C074450
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Dec 2009 12:13:54 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB1C4IXg031886
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Dec 2009 05:04:18 -0700
Subject: Re: [PATCH 0/8 userland!] systemtap: Add initial support for ppc32
From: Jim Keniston <jkenisto@us.ibm.com>
To: avorontsov@ru.mvista.com, ananth@in.ibm.com
In-Reply-To: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 01 Dec 2009 11:13:48 -0800
Message-Id: <1259694828.5184.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, systemtap@sourceware.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-11-28 at 01:32 +0300, Anton Vorontsov wrote:
> Hi all,
> 
> Here are some patches that add systemtap support for ppc32 machines.
> 
> This is all pretty straightforward, though I didn't test it much,
> only run few 'hello world' taps and decided that it's good enough. ;-)
> 
> I plan to test it more thoughtfully sometime next week, and fix missing
> things (if any). But so far I'm interested in the feedback on this
> initial support.
> 
> Thanks!
> 
> p.s. I though it would be a good idea to cc linuxppc-dev. At least
> kexec-tools guys tend to do it as well.

I think one thing that got missed was completing the support for ppc32
in tapset/powerpc/registers.stp (functions *_arg and [u_]register).  A
lot of the 32-bit code is already in place, having been copied over from
the x86_64 version, but the _reg_offsets[] array and
_stp_get_register_by_offset() work only for 64-bit contexts.  A comment
at the end of _stp_register_regs() suggests that you can get the correct
32-bit offsets by dividing the 64-bit offsets by 2; compare pt_regs
structs to verify.

I'm cc-ing Ananth, who did the original ppc64 work on this file.

The *_arg and [u_]register functions are described in the stapfuncs man
page (but not in the Language Reference doc).
testsuite/systemtap.context/num_args.tcl tests some of these functions
(or used to, at least).

Jim Keniston
