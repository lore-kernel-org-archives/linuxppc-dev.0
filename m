Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 85EBBDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 14:11:55 +1100 (EST)
Date: Tue, 31 Mar 2009 23:11:53 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Problem with module_init?
Message-ID: <20090331231153.256d1bf4@lappy.seanm.ca>
In-Reply-To: <20090331143742.083c6cb0@lappy.seanm.ca>
References: <20090331143742.083c6cb0@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

8d1cf34e7ad5c7738ce20d20bd7f002f562cb8b5 is first bad commit
commit 8d1cf34e7ad5c7738ce20d20bd7f002f562cb8b5
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Thu Mar 19 19:34:08 2009 +0000

    powerpc/mm: Tweak PTE bit combination definitions
    
    This patch tweaks the way some PTE bit combinations are defined, in
    such a way that the 32 and 64-bit variant become almost identical
    and that will make it easier to bring in a new common pte-* file
    for the new variant of the Book3-E support.
    
    The combination of bits defining access to kernel pages are now
    clearly separated from the combination used by userspace and the
    core VM. The resulting generated code should remain identical
    unless I made a mistake. 
    Note: While at it, I removed a non-sensical statement related to
    CONFIG_KGDB in ppc_mmu_32.c which could cause kernel mappings to be
    user accessible when that option is enabled. Probably something
    that bitrot. 
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

:040000 040000 c105fb9641b078f1a8a60c2a7900ca2dd088b364
e90678246962d7a455aa27ba12814c11cd9b3c22 M      arch
