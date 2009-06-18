Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 14856B7241
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 08:43:23 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04E14DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 08:43:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19002.44369.638997.584055@cargo.ozlabs.ibm.com>
Date: Fri, 19 Jun 2009 07:10:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] perf_counter: powerpc: Add processor back-end for
	MPC7450 family
In-Reply-To: <E57BFC08-F847-463A-9D0F-55979C4B0524@kernel.crashing.org>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<19000.55631.802122.696927@cargo.ozlabs.ibm.com>
	<34BD6A89-A05E-40CC-A495-017BFB08B796@kernel.crashing.org>
	<19001.31508.901222.288946@cargo.ozlabs.ibm.com>
	<E57BFC08-F847-463A-9D0F-55979C4B0524@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala writes:

> In looking at doing this what suggestions do you have in implementing  
> perf_instruction_pointer() if we don't have the equivalent of SIAR.   
> Just use regs->nip ?

Yes, exactly.  If you don't have SIAR/SDAR/MMCRA, the default
definitions for perf_instruction_pointer and perf_misc_flags in
include/linux/perf_counter.h are fine, and you get them if
perf_misc_flags is not defined.

Paul.
