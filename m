Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78327B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 10:14:19 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6A386DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 10:14:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19081.62033.410217.303895@cargo.ozlabs.ibm.com>
Date: Tue, 18 Aug 2009 10:14:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3 v3] powerpc/32: Always order writes to halves of
	64-bit PTEs
In-Reply-To: <6FE668DD-C870-4FBB-A6AE-03CC0882E8EC@kernel.crashing.org>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<6FE668DD-C870-4FBB-A6AE-03CC0882E8EC@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala writes:

> On Aug 17, 2009, at 6:00 PM, Paul Mackerras wrote:
> 
> > On 32-bit systems with 64-bit PTEs, the PTEs have to be written in two
> > 32-bit halves.  On SMP we write the higher-order half and then the
> > lower-order half, with a write barrier between the two halves, but on
> > UP there was no particular ordering of the writes to the two halves.
> >
> > This extends the ordering that we already do on SMP to the UP case as
> > well.  The reason is that with the perf_counter subsystem potentially
> > accessing user memory at interrupt time to get stack traces, we have
> > to be careful not to create an incorrect but apparently valid PTE even
> > on UP.
> >
> > Signed-off-by: Paul Mackerras <paulus@samba.org>
> > ---
> > arch/powerpc/include/asm/pgtable.h |    6 +++---
> > 1 files changed, 3 insertions(+), 3 deletions(-)
> 
> Just out of interest did you end up hitting this in testing?

No.  Ben told me he wanted this change, so I did what I was told. :)

Paul.
