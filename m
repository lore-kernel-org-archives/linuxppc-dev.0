Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F29A67C3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 23:53:37 +1000 (EST)
Date: Wed, 23 Aug 2006 09:05:33 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: ioremap() fails for >64 MB
Message-ID: <20060823140533.GA10331@gate.crashing.org>
References: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
	<44EAC56D.5020508@cambridgebroadband.com>
	<44EB717D.3080800@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44EB717D.3080800@dlasys.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 22, 2006 at 05:05:01PM -0400, David H. Lynch Jr. wrote:
>     is ioremap() failing or is vmalloc failing ?
> 
>     ioremap should just assign a virtual address to a physical address -
> does it actually allocate anything ?
>     I beleive I am ioremap()ing a greater than 64MB Flash ROM and I do
> not think it is failing.

ioremap() allocates virtual address space in order to be able to
do the assignment.  The ability to allocate this vmalloc space
(which is used by ioremap() and vmalloc() calls) varies based
on amount of memory, etc. in a system.  It also depends on how
good of a quality of a board port is done. It's possible to do
some very stupid things that constrict availability of vmalloc
space. So YMMV versus others.

-Matt
