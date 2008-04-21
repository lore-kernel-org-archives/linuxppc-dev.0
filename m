Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F1CCDDF83
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 08:04:34 +1000 (EST)
Message-Id: <059AA568-4729-4060-A876-C8460E0A7794@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1208812957.9640.47.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] ppc32: Fix errata for 603 CPUs
Date: Mon, 21 Apr 2008 17:04:27 -0500
References: <Pine.LNX.4.64.0804211457010.8003@blarg.am.freescale.net>
	<1208812957.9640.47.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 21, 2008, at 4:22 PM, Benjamin Herrenschmidt wrote:
>
>>
>> _GLOBAL(__setup_cpu_603)
>> -	b	setup_common_caches
>> +	mflr	r4
>> +BEGIN_FTR_SECTION
>> +	bl	__init_fpu_registers
>> +END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
>> +	bl	__init_fpu_registers
>> +	bl	setup_common_caches
>> +	mtlr	r4
>> +	blr
>> _GLOBAL(__setup_cpu_604)
>> 	mflr	r4
>> 	bl	setup_common_cache
>
> Has the feature fixup been perform yet when __setup_* is called ?

Yes.  We call do_feature_fixups() in early_init and call  
call_setup_cpu() after than on 6xx (in head_32.S).

- k
