Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7PNV2qGRzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:22:50 +1000 (AEST)
Subject: Re: [PATCH 3/3] powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <cover.1492596044.git.christophe.leroy@c-s.fr>
 <eabf767c896a023e5670adfa07398f1008756c13.1492596044.git.christophe.leroy@c-s.fr>
 <87inm05we4.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d3713d6a-28b6-fb8f-ce32-c0d37958b59f@c-s.fr>
Date: Wed, 19 Apr 2017 16:22:46 +0200
MIME-Version: 1.0
In-Reply-To: <87inm05we4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/04/2017 à 16:01, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
>> index 32509de6ce4c..4af81fb23653 100644
>> --- a/arch/powerpc/kernel/ftrace.c
>> +++ b/arch/powerpc/kernel/ftrace.c
>> @@ -526,7 +526,9 @@ void ftrace_replace_code(int enable)
>>   */
>>  void arch_ftrace_update_code(int command)
>>  {
>> +	set_kernel_text_rw();
>>  	ftrace_modify_all_code(command);
>> +	set_kernel_text_ro();
>>  }
>
> I'm not sure that's the right place for that.


I took arch/arm/ as model. It does the following. Is that wrong ?


static int __ftrace_modify_code(void *data)
{
	int *command = data;

	set_kernel_text_rw();
	ftrace_modify_all_code(*command);
	set_kernel_text_ro();

	return 0;
}

void arch_ftrace_update_code(int command)
{
	stop_machine(__ftrace_modify_code, &command, NULL);
}



> If you look at other arches they hook into ftrace_modify_code(), where
> you have the address that's being modified.
>

Ok, I will look at other arches.

Christophe
