Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 6A2FF2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 18:00:07 +1000 (EST)
Message-ID: <52414682.3010608@c-s.fr>
Date: Tue, 24 Sep 2013 10:00:02 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
References: <201309121825.r8CIPrkI005690@localhost.localdomain>
 <1379011469.2536.45.camel@snotra.buserror.net> <52329CDF.9020103@c-s.fr>
 <1379365336.2536.166.camel@snotra.buserror.net> <5238860F.4030405@c-s.fr>
 <1379712141.16231.36.camel@aoeu.buserror.net>
In-Reply-To: <1379712141.16231.36.camel@aoeu.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 20/09/2013 23:22, Scott Wood a écrit :
>>> The hardware wants to decrement; why fight it?
>> >I see your point.
>> >However it is not clear in the documentation if the decrement is done
>> >really after the update, or at xTLB interrupt. So I propose to still set
>> >the CTR ourself as described in the reference Manual and not assume that
>> >the HW decrements it.
> It says "every update" -- do you have any reason to believe that's
> wrong?  It could be tested...
>
>
Ok. I just test it,  and I observe the following: As we have set the 
RSV4x bit, the CPU sets Mx_CTR to a value below 0x1c after each update:
* After writing entry 0x1c, Mx_CTR has value 0x1b
* After writing entry 0x1d, Mx_CTR has value 0x18
* After writing entry 0x1e, Mx_CTR has value 0x19
* After writing entry 0x1f, Mx_CTR has value 0x1a

Indeed the first version of my patch was complete, only the description 
was not fully correct.
So, in order to minimise code churn, I will re-submit my initial patch 
with a modified description.

Christophe
