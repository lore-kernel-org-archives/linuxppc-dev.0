Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8D29679E7
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 14:59:41 +1000 (EST)
In-Reply-To: <17498.34041.993647.189930@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
	<17498.34041.993647.189930@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <900DA3FF-3DF2-43AA-A8EA-869E95B7431F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Thu, 4 May 2006 23:59:35 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2006, at 5:49 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Please pull from 'for_paulus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
>
>> --- a/arch/powerpc/kernel/setup_32.c
>> +++ b/arch/powerpc/kernel/setup_32.c
>> @@ -236,6 +236,7 @@ arch_initcall(ppc_init);
>>  void __init setup_arch(char **cmdline_p)
>>  {
>>  	extern void do_init_bootmem(void);
>> +	extern void setup_panic(void);
>
> Urk.

Yeah didn't care for it either.  Will move to "setup.h"

>
>> @@ -285,6 +286,9 @@ #endif
>>  	/* reboot on panic */
>>  	panic_timeout = 180;
>>
>> +	if (ppc_md.panic)
>> +		setup_panic();
>
> Since no 32-bit platform sets ppc_md.panic AFAICS, I guess this
> doesn't need to be pushed into 2.6.17.  Please redo with setup_panic
> declared in a header file.

Yeah, this was for 2.6.18. (will do on the header change)

- k
