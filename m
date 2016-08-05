Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Jsl5S0czDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:51:39 +1000 (AEST)
Subject: Re: Suspected regression?
To: Scott Wood <oss@buserror.net>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
 <1468965129.25630.15.camel@buserror.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <601d732a-a137-3ba9-550d-19c7eb10337a@c-s.fr>
Date: Fri, 5 Aug 2016 09:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <1468965129.25630.15.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/07/2016 à 23:52, Scott Wood a écrit :
> On Tue, 2016-07-19 at 12:00 +0200, Alessio Igor Bogani wrote:
>> Hi all,
>>
>> I have got two boards MVME5100 (MPC7410 cpu) and MVME7100 (MPC8641D
>> cpu) for which I use the same cross-compiler (ppc7400).
>>
>> I tested these against kernel HEAD to found that these don't boot
>> anymore (PID 1 crash).
>>
>> Bisecting results in first offending commit:
>> 7aef4136566b0539a1a98391181e188905e33401
>>
>> Removing it from HEAD make boards boot properly again.
>>
>> A third system based on P2010 isn't affected at all.
>>
>> Is it a regression or I have made something wrong?
>
> I booted both my next branch, and Linus's master on MPC8641HPCN and didn't see
> this -- though possibly your RFS is doing something different.  Maybe that's
> the difference with P2010 as well.
>
> Is there any way you can debug the cause of the crash?  Or send me a minimal
> RFS that demonstrates the problem (ideally with debug symbols on the userspace
> binaries)?
>

I got from Alessio the below information:

systemd[1]: Caught <BUS>, core dump failed (child 137, code=killed,
status=7/BUS).
systemd[1]: Freezing execution.


What can generate SIGBUS ?
And shouldn't we also get some KERN_ERR trace, something like "unhandled 
signal 7 at ....." ?

Christophe
