Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTWs13VwszDrpx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 15:16:05 +1000 (AEST)
Subject: Re: [PATCH] powerpc/8xx: add system_reset_exception
To: Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20160905064232.2CEB11A245A@localhost.localdomain>
 <1473201626.30217.1.camel@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3306dd07-d00a-a61b-4974-696de19ab51d@c-s.fr>
Date: Wed, 7 Sep 2016 07:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <1473201626.30217.1.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/09/2016 à 00:40, Scott Wood a écrit :
> On Mon, 2016-09-05 at 08:42 +0200, Christophe Leroy wrote:
>> When the watchdog is in NMI mode, the system reset interrupt is
>> generated when the watchdog counter expires.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/kernel/head_8xx.S | 2 +-
>>  arch/powerpc/kernel/traps.c    | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
>> index 43ddaae..f7b8007 100644
>> --- a/arch/powerpc/kernel/head_8xx.S
>> +++ b/arch/powerpc/kernel/head_8xx.S
>> @@ -227,7 +227,7 @@ i##n:							
>> 	\
>>  			  ret_from_except)
>>
>>  /* System reset */
>> -	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
>> +	EXCEPTION(0x100, Reset, system_reset_exception, EXC_XFER_STD)
>
> Does this do anything useful beyond what unknown_exception does?  Do you plan
> to have a ppc_md.system_reset_exception callback?
>

Yes that's the plan, having a platform specific callback to take 
emergency actions in order to speed up systemwise recovery, then restart 
the board.

In addition, unknown_exception doesn't show you that the exception comes 
from the NMI watchdog.

Christophe
