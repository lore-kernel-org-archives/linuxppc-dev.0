Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 945B2B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 16:48:45 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64042DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 16:48:43 +1000 (EST)
Subject: Re: [PATCH] powerpc/perfctr: Check oprofile_cpu_type for NULL
	before using it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1249540910.23206.67.camel@macbook.infradead.org>
References: <1249531356.18245.73.camel@pasglop>
	<1249540910.23206.67.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 16:48:19 +1000
Message-Id: <1249541299.18245.74.camel@pasglop>
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

On Thu, 2009-08-06 at 07:41 +0100, David Woodhouse wrote:
> On Thu, 2009-08-06 at 14:02 +1000, Benjamin Herrenschmidt wrote:
> > If the current CPU doesn't support performance counters,
> > cur_cpu_spec->oprofile_cpu_type can be NULL. The current
> > perfctr modules don't test for that case and would thus
> > crash.
> 
> It can't actually be NULL on a 64-bit CPU; all 64-bit CPUs in the table
> have ->oprofile_cpu_type set.

 .... today :-)

> Of course, adding the check probably makes sense anyway.

Yup, better safe.

Cheers,
Ben.
