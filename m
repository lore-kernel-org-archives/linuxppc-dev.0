Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxlxq0cWbzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 07:44:46 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id o123so32452448pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 14:44:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Matt Brown <matthew.brown.dev@gmail.com>, linux-raid@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] raid6/altivec: adding vpermxor implementation for raid6 Q
 syndrome
In-Reply-To: <877f31n2mn.fsf@possimpible.ozlabs.ibm.com>
References: <20170330051313.31358-1-matthew.brown.dev@gmail.com>
 <877f31n2mn.fsf@possimpible.ozlabs.ibm.com>
Date: Tue, 04 Apr 2017 07:44:32 +1000
Message-ID: <87wpb1kvy7.fsf@possimpible.ozlabs.ibm.com>
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

> In that function, the flow is:
>  pagefault_disable();
>  enable_kernel_altivec();
>  <vectorised function>
>  pagefault_enable();
>
> There are a few things that it would be nice (but by no means essential)
> to find out:
>  - what is the difference between pagefault and prempt enable/disable
>  - is it required to disable altivec after the end of the function or
>    can we leave that enabled?

Answering my own question here, dc4fbba11e46 ("powerpc: Create
disable_kernel_{fp,altivec,vsx,spe}()") adds the disable_ function, and
it's a no-op except under debug conditions. So it should stay.

Regards,
Daniel


>
>> +
>> +int raid6_have_altivec_vpermxor(void);
>> +#if $# == 1
>> +int raid6_have_altivec_vpermxor(void)
>> +{
>> +	/* Check if CPU has both altivec and the vpermxor instruction*/
> Please add a space: s|ion*/|ion */|
>> +# ifdef __KERNEL__
>> +	return (cpu_has_feature(CONFIG_ALTIVEC) &&
>> +		cpu_has_feature(CPU_FTR_ARCH_207S));
> I assume this is future-proof - an ISA 3.00 cpu will advertise 2.07S
> compat?
>
>> +# else
>> +	return 1;
>> +#endif
>> +
>> +}
>> +#endif
>> +
>> +const struct raid6_calls raid6_vpermxor$# = {
>> +	raid6_vpermxor$#_gen_syndrome,
>> +	NULL,
>> +	raid6_have_altivec_vpermxor,
>> +	"vpermxor$#",
>> +	0
>> +};
>> +#endif
>> -- 
>> 2.9.3
>
> Apart from that this patch looks good and I expect I will be able to
> formally Review v2.
>
> Regards,
> Daniel
