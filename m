Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 593A11A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 09:08:11 +1100 (AEDT)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CD6731402A9
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2015 09:08:10 +1100 (AEDT)
Date: Tue, 17 Nov 2015 09:07:46 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH 1/5] powerpc: Print MSR TM bits in oops message
Message-ID: <20151117090746.0e8bf4ee@kryten>
In-Reply-To: <1447666040.2191.3.camel@ellerman.id.au>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
 <1447666040.2191.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> > +{
> > +	if (val & (MSR_TM | MSR_TS_S | MSR_TS_T)) {
> > +		printk(",TM[");
> > +		printbits(val, msr_tm_bits, "");
> > +		printk("]");
> 
> I suspect all these individual printks are going to behave badly if
> we have multiple cpus crashing simultaneously. But I won't make you
> fix that here. We should look at it sometime though.

We really need to serialise the entire oops. I had a go at fixing this
but ran out of steam:

https://lkml.org/lkml/2015/2/23/735

Anton
