Return-Path: <jangiels@speakeasy.net>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CD9D067B1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 03:48:05 +1100 (EST)
Subject: Re: Interpreting /proc/meminfo. How much free memory do I have?
From: Jeff Angielski <jangiels@speakeasy.net>
To: "antonio.dibacco" <antonio.dibacco@aruba.it>
In-Reply-To: <20060327093822.480.qmail@mx1.aruba.it>
References: <20060327064907.23992.qmail@mx1.aruba.it>
	<200603270953.11079.roger.larsson@norran.net>
	<4427A9C1.3060000@berghof.com> <20060327093822.480.qmail@mx1.aruba.it>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 11:49:23 -0500
Message-Id: <1143478163.7082.23.camel@sumo-jaa.nrl.navy.mil>
Mime-Version: 1.0
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

On Mon, 2006-03-27 at 09:38 +0000, antonio.dibacco wrote:
> I don't understand the meaning of "Inactive". They are not used but the 
> kernel cannot give this memory to a requesting process because we tipically 
> don't have a swap device on a linux embedded board. Where we can store the 
> Inactive page? Am I wrong?
> If I run a process that continuosly allocates memory and print out the total 
> allocated memory when it receives SIGINT or SIGTERM, I think I get the real 
> "free memory"! 

The "big picture" is that the kernel assumes that any physical memory
that is not used is being wasted.  The kernel tries to anticipate what
data you will need and loads it into memory before you actually require
it.  This way there is no time delay when you want to access it.  So the
numbers are reflecting what the system/kernel is currentl using.  

Even if you are on a system with no swap parition like your embedded
board, pages in memory that are read-only can still be swapped out since
they can always be read back in when needed.  Sections like a
processes .text fit this category.

If you are trying to look at a specific process, perhaps looking at
the /proc/<pid>/status might help you analyze your memory needs.


Jeff Angielski
The PTR Group
