Return-Path: <mkravetz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8134467B84
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 09:18:02 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6INHx7E009394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 19:17:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6INHx66135108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 17:17:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6INHwjG020823
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 17:17:59 -0600
Date: Tue, 18 Jul 2006 16:18:15 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060718231815.GC3091@w-mikek2.ibm.com>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
	<20060718204946.GC6104@w-mikek2.ibm.com>
	<20060718223425.GB5238@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060718223425.GB5238@pb15.lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 05:34:25PM -0500, Olof Johansson wrote:
> As I said before, SPRN_PURR doesn't exist on all architecture versions
> that supports hypervisor mode.

Thanks!

I assume checking must be done at run time via something like,
if (cpu_has_feature(CPU_FTR_PURR))

Also assume that it would make sense to do this determination at
initialization/boot time and put the result in the statistic data
structure.  In this way we would know it is in the same cache line
we are updating with other stats.  Or, should cur_cpu_spec->cpu_features
be 'sufficiently hot' to make this a non-issue?

-- 
Mike
