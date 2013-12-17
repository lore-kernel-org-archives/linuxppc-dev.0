Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id CA58A2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 16:54:38 +1100 (EST)
Message-ID: <52AFE70D.70407@c-s.fr>
Date: Tue, 17 Dec 2013 06:54:21 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc 8xx: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
References: <20131210112945.E4E311A2BF3@localhost.localdomain>	
 <1386714253.10013.123.camel@snotra.buserror.net> <52A79E31.9070304@c-s.fr>	
 <1386717537.10013.150.camel@snotra.buserror.net> <52A7A58F.8090705@c-s.fr>
 <1387234621.10013.408.camel@snotra.buserror.net>
In-Reply-To: <1387234621.10013.408.camel@snotra.buserror.net>
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

Le 16/12/2013 23:57, Scott Wood a écrit :
> On Wed, 2013-12-11 at 00:36 +0100, leroy christophe wrote:
>> Le 11/12/2013 00:18, Scott Wood a écrit :
>>> There wasn't previously an ifdef specifically around the setting of
>>> SPRN_MD_CTR.  That's new.  There was an ifdef around the entire block,
>>> which has gone away because you are now trying to map more than 8M
>>> regardless of CONFIG_PIN_TLB, but that has nothing to do with whether
>>> there should be an ifdef around SPRN_MD_CTR.
>>>
>>>
>> Euh, ok, but then we have to fix it in the whole function, not only in
>> this block. Do you think it is worth doing it ?
> Fix what in the whole function?  I was asking what harm there would be
> if you just remove all the CONFIG_PIN_TLB ifdefs except around the
> actual RSV4I setting -- do we really care what value goes in MD_CTR for
> the non-pinned case, as long as it's different for each entry?
>
>
MD_CTR is decremented after each entry added.
However, the function populates entry 28, then 29, then 30, then 31. At 
the end MD_CTR has then value 30, ready to overide entry 30 then 29 then 
28 then 27 .....

So I will remove all the CONFIG_PIN_TLB, but I'll also have to fix the 
value set in MD_CTR to start from 31, won't I ?

Do you have any comment/recommendation on my tentative v3 patch where I 
have tried to implement based on the use of r7 as you recommended ?

Christophe
