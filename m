Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18695.36029.801856.699780@cargo.ozlabs.ibm.com>
Date: Wed, 29 Oct 2008 09:05:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: Add new CPU feature: CPU_FTR_UNALIGNED_LD_STD
In-Reply-To: <A112398F-5B9B-4E05-976D-8B7FC932FC8B@kernel.crashing.org>
References: <200810272143.02144.markn@au1.ibm.com>
	<349712B7-EA3A-4BAA-9DB8-8A5FDD0AA060@kernel.crashing.org>
	<18694.33816.996886.431170@cargo.ozlabs.ibm.com>
	<A112398F-5B9B-4E05-976D-8B7FC932FC8B@kernel.crashing.org>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> I'm asking if we can come up with a better solution than using  
> CPU_FTR_ bits for extremely specific uses like this.

I haven't been able to think of an alternative that doesn't amount to
an ad-hoc reimplementation of the CPU feature mechanism.  Do you have
a suggestion?

We have code here that needs to know about the characteristics of the
processor we're running, and is somewhat performance-critical (and
__copy_tofrom_user, which Mark is working on next, will also use these
bits and is definitely performance-critical).  So it is natural to use
the CPU feature mechanism, which is there precisely to provide this
kind of information.

I assume you're worried about running out of feature bits.  The bit
Mark is adding is in the 64-bit section of the kernel feature mask,
so it doesn't affect 32-bit processors at all.  Anyway, we still have
8 free bits there after Mark's patch.  It's the user feature mask
where we're getting tight, since it's limited to 32 bits and we only
have 4 bits free.

Paul.
