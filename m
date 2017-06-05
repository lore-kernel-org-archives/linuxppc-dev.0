Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whBQg5V7JzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:49:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts in
 do_page_fault()
In-Reply-To: <f7290b3e-0f74-cf29-52fb-5644894e9702@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
 <871sr23flh.fsf@concordia.ellerman.id.au>
 <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
 <1496405473.2842.9.camel@kernel.crashing.org>
 <f7290b3e-0f74-cf29-52fb-5644894e9702@c-s.fr>
Date: Mon, 05 Jun 2017 20:49:30 +1000
Message-ID: <87poeir9ol.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 02/06/2017 =C3=A0 14:11, Benjamin Herrenschmidt a =C3=A9crit :
>> On Fri, 2017-06-02 at 11:39 +0200, Christophe LEROY wrote:
>>> The difference between get_user() and __get_user() is that get_user()
>>> performs an access_ok() in addition.
>>>
>>> Doesn't access_ok() only checks whether addr is below TASK_SIZE to
>>> ensure it is a valid user address ?
>>=20
>> Do you have a measurable improvement by skipping that check ? I agree
>> with your reasoning but I'm also paranoid and so I wouldn't change it
>> unless it's really worth it.
>>=20
>
> No I don't have. Taking into account the patch following this serie=20
> which limits even more the calls to get_user(), it is probably not worth=
=20
> it anymore (see https://patchwork.ozlabs.org/patch/757564/)
>
> I will then have to resubmit the entire serie (including that additional=
=20
> one), but there is no get_user_inatomic() so will have to either:
> - do the access_ok() verification inside the function

I think open coding the access_ok() check is probably the best option.

cheers
