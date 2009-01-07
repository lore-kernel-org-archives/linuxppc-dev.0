Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AC54474D1
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 16:12:10 +1100 (EST)
Subject: Re: [PATCH 7/7] powerpc/64/kdump: Use ppc_save_regs() in
	crash_setup_regs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090107040420.GA19317@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
	<20081217200935.GG4624@oksana.dev.rtsoft.ru>
	<1231298165.14860.56.camel@pasglop>
	<20090107040420.GA19317@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 16:11:08 +1100
Message-Id: <1231305068.14860.74.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 07:04 +0300, Anton Vorontsov wrote:
> AFAICS it saves r1:
> 
>        PPC_STL r0,0*SZL(r3)
>        PPC_STL r2,2*SZL(r3)
>        PPC_STL r3,3*SZL(r3)
>        ...
>        /* go up one stack frame for SP */
>        PPC_LL  r4,0(r1)
>        PPC_STL r4,1*SZL(r3)
> 
> This fact is mentioned in the patch description:
> 
>  NOTE: The old regs dump implementation was capturing SP (r1) directly
>  as is, so you could see crash_kexec() function on top of the
> back-trace.
>  But ppc_save_regs() goes up one stack frame, so you'll not see it
>  anymore, at the top-level you'll see who actually triggered the crash
>  dump instead.
> 
> Do you see anything wrong in such behaviour?

No, just me being a bit blind looking at too many patches today :-)

Cheers,
Ben.
