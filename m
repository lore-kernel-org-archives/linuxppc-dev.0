Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPphP2Rg2zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 21:11:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: Re: [PATCH v2] powerpc: Add POWER9 architected mode to cputable
In-Reply-To: <878tp58co3.fsf@possimpible.ozlabs.ibm.com>
References: <20170217020135.6361-1-ruscur@russell.cc>
 <878tp58co3.fsf@possimpible.ozlabs.ibm.com>
Date: Fri, 17 Feb 2017 21:11:16 +1100
Message-ID: <871suxjfej.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> writes:

> Hi Russell,
>
> This seems to go Power8, Power9, Power7 - is that intentional?
>
> Regards,
> Daniel
>
>>  		.platform		= "power8",
> ...
>> +		.platform		= "power9",
> ...
>>  	{	/* Power7 */

It's because we have the architected PVRs and the raw ones, and the
ordering is a bit odd:

$ grep -n -e '(architected)' -e '(raw)' arch/powerpc/kernel/cputable.c
323:		.cpu_name		= "POWER6 (raw)",
343:		.cpu_name		= "POWER6 (architected)",
356:		.cpu_name		= "POWER7 (architected)",
374:		.cpu_name		= "POWER8 (architected)",
392:		.cpu_name		= "POWER9 (architected)",
411:		.cpu_name		= "POWER7 (raw)",
431:		.cpu_name		= "POWER7+ (raw)",
451:		.cpu_name		= "POWER8E (raw)",
471:		.cpu_name		= "POWER8NVL (raw)",
491:		.cpu_name		= "POWER8 (raw)",
511:		.cpu_name		= "POWER8 (raw)",
531:		.cpu_name		= "POWER9 (raw)",
550:		.cpu_name		= "POWER9 (raw)",

But I don't think it matters in practice. The architected entries use a
pvr_mask of 0xffffffff so it has to be an exact match.

cheers
