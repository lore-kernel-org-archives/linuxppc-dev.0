Return-Path: <BATV+ae7757fd818ec6e26725+2174+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7F5F3B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 16:42:03 +1000 (EST)
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 301DDDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 16:42:02 +1000 (EST)
Subject: Re: [PATCH] powerpc/perfctr: Check oprofile_cpu_type for NULL
	before using it
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1249531356.18245.73.camel@pasglop>
References: <1249531356.18245.73.camel@pasglop>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 07:41:50 +0100
Message-Id: <1249540910.23206.67.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 14:02 +1000, Benjamin Herrenschmidt wrote:
> If the current CPU doesn't support performance counters,
> cur_cpu_spec->oprofile_cpu_type can be NULL. The current
> perfctr modules don't test for that case and would thus
> crash.

It can't actually be NULL on a 64-bit CPU; all 64-bit CPUs in the table
have ->oprofile_cpu_type set.

Of course, adding the check probably makes sense anyway.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
