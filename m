Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17449.6575.927844.106127@cargo.ozlabs.ibm.com>
Date: Tue, 28 Mar 2006 22:10:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH] lock PTE before updating it in 440/BookE page fault
	handler
In-Reply-To: <20060328075525.GA20801@gate.ebshome.net>
References: <20060302202634.GA14387@gate.ebshome.net>
	<20060328075525.GA20801@gate.ebshome.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eugene Surovegin writes:

> Fix 44x and BookE page fault handler to correctly lock PTE before 
> trying to pte_update() it, otherwise this PTE might be swapped out 
> after pte_present() check but before pte_uptdate() call, resulting in 
> corrupted PTE. This can happen with enabled preemption and low memory 
> condition.

That gives me this for an ARCH=powerpc 32-bit pmac build:

/home/paulus/kernel/powerpc/arch/powerpc/mm/pgtable_32.c:376: error: conflicting types for 'get_pteptr'
/home/paulus/kernel/powerpc/include/asm-ppc/pgtable.h:841: error: previous declaration of 'get_pteptr' was here

Paul.
