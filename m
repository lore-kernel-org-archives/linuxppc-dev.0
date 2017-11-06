Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVpmp1rMxzDrLS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:33:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: William Kennington <wak@google.com>
Cc: linuxppc-dev@ozlabs.org, rlippert@google.com
Subject: Re: [PATCH] powerpc/opal: Fix EBUSY bug in acquiring tokens
In-Reply-To: <4D745AF9-BB04-49BB-B743-B66F680992F1@google.com>
References: <20170922235800.19348-1-wak@google.com>
 <87zi825rsu.fsf@concordia.ellerman.id.au>
 <4D745AF9-BB04-49BB-B743-B66F680992F1@google.com>
Date: Mon, 06 Nov 2017 21:33:13 +1100
Message-ID: <87d14vbst2.fsf@concordia.ellerman.id.au>
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

William Kennington <wak@google.com> writes:

>> On Nov 4, 2017, at 2:14 AM, Michael Ellerman <mpe@ellerman.id.au <mailto=
:mpe@ellerman.id.au>> wrote:
>>=20
>> "William A. Kennington III" <wak@google.com <mailto:wak@google.com>> wri=
tes:
>>=20
>>> The current code checks the completion map to look for the first token
>>> that is complete. In some cases, a completion can come in but the token
>>> can still be on lease to the caller processing the completion. If this
>>> completed but unreleased token is the first token found in the bitmap by
>>> another tasks trying to acquire a token, then the __test_and_set_bit
>>> call will fail since the token will still be on lease. The acquisition
>>> will then fail with an EBUSY.
>>>=20
>>> This patch reorganizes the acquisition code to look at the
>>> opal_async_token_map for an unleased token. If the token has no lease it
>>> must have no outstanding completions so we should never see an EBUSY,
>>> unless we have leased out too many tokens. Since
>>> opal_async_get_token_inrerruptible is protected by a semaphore, we will
>>> practically never see EBUSY anymore.
>>>=20
>>> Signed-off-by: William A. Kennington III <wak@google.com <mailto:wak@go=
ogle.com>>
>>> ---
>>> arch/powerpc/platforms/powernv/opal-async.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> I think this is superseeded by Cyrils rework (which he's finally
>> posted):
>>=20
>>  http://patchwork.ozlabs.org/patch/833630/ <http://patchwork.ozlabs.org/=
patch/833630/>
>>=20
>> If not please let us know.
>
> Yeah, I think Cyril=E2=80=99s rework fixes this. I wasn=E2=80=99t sure ho=
w long it
> would take for master to receive his changes so I figured we could use
> something in the interim to fix the locking failures. If his changes
> will be mailed into the next merge window then we should have the
> issue fixed in master. I understand that rework probably won=E2=80=99t ma=
ke it
> into stable kernels? If not then we should probably send this along to
> stable kernel maintainers.

OK. I didn't realise the bug was sufficiently bad to need a backport
to stable.

To make a backport easier I've merged this patch first, and then Cyril's
on top of it (which essentially deletes this patch).

I assume you've tested this patch at least somewhat? :)

cheers
