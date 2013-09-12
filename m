Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id B6C502C039E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 15:57:29 +1000 (EST)
Message-ID: <523157C6.4010404@c-s.fr>
Date: Thu, 12 Sep 2013 07:57:26 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
References: <201309111644.r8BGiuDZ016325@localhost.localdomain>
 <1378939017.12204.409.camel@snotra.buserror.net>
 <1378944911.4066.12.camel@pasglop>
In-Reply-To: <1378944911.4066.12.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 12/09/2013 02:15, Benjamin Herrenschmidt a écrit :
> On Wed, 2013-09-11 at 17:36 -0500, Scott Wood wrote:
>> I wonder why we don't start from entry 31 so we can actually make use of
>> that autodecrement.  What will happen when we load the first normal TLB
>> entry later on?  I don't see any setting of SPRN_MD_CTR after this code,
>> so won't it overwrite entry 30 (the middle 8M) in the CONFIG_PIN_TLB
>> case?
>>
>> Ben, would patches like this be considered bugfixes as far as merging
>> goes, or would they be for next given that it's something that's never
>> really worked right and hasn't been touched in years?
> Since they don't affect anything outside of 8xx, I'm happy to take them
> until around -rc2 or 3. But it's your call really.
>
>
Scott, you're right, I didn't see that other consequence.
I'll come with a more complete patch this afternoon.
Thanks
