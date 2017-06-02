Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfNrY0MzhzDqMS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 22:32:13 +1000 (AEST)
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts in
 do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
 <871sr23flh.fsf@concordia.ellerman.id.au>
 <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
 <1496405473.2842.9.camel@kernel.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f7290b3e-0f74-cf29-52fb-5644894e9702@c-s.fr>
Date: Fri, 2 Jun 2017 14:31:47 +0200
MIME-Version: 1.0
In-Reply-To: <1496405473.2842.9.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 02/06/2017 à 14:11, Benjamin Herrenschmidt a écrit :
> On Fri, 2017-06-02 at 11:39 +0200, Christophe LEROY wrote:
>> The difference between get_user() and __get_user() is that get_user()
>> performs an access_ok() in addition.
>>
>> Doesn't access_ok() only checks whether addr is below TASK_SIZE to
>> ensure it is a valid user address ?
> 
> Do you have a measurable improvement by skipping that check ? I agree
> with your reasoning but I'm also paranoid and so I wouldn't change it
> unless it's really worth it.
> 

No I don't have. Taking into account the patch following this serie 
which limits even more the calls to get_user(), it is probably not worth 
it anymore (see https://patchwork.ozlabs.org/patch/757564/)

I will then have to resubmit the entire serie (including that additional 
one), but there is no get_user_inatomic() so will have to either:
- do the access_ok() verification inside the function
- get back to v2 (https://patchwork.ozlabs.org/patch/756234/)
- implement an get_user_inatomic() function

What would be the best ?

Christophe
