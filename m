Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA10C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 18:18:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31CD6113D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 18:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D31CD6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H4Vkr6XJYz2ysq
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Sep 2021 04:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.231;
 helo=out01.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H4VkJ0lMTz2xgN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2021 04:18:14 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52]:36066)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mO299-00646x-0B; Wed, 08 Sep 2021 12:18:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:51806
 helo=email.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mO297-006PT4-LO; Wed, 08 Sep 2021 12:18:06 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
References: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
 <a94be61f008ab29c231b805e1a97e9dab35cb0cc.1629732940.git.christophe.leroy@csgroup.eu>
 <87mtoux1hi.fsf@disp2133>
 <2715792c-eb10-eeb8-3d49-24486abe953b@csgroup.eu>
Date: Wed, 08 Sep 2021 13:17:39 -0500
In-Reply-To: <2715792c-eb10-eeb8-3d49-24486abe953b@csgroup.eu> (Christophe
 Leroy's message of "Fri, 3 Sep 2021 10:56:14 +0200")
Message-ID: <877dfrrkxo.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1mO297-006PT4-LO; ; ; mid=<877dfrrkxo.fsf@disp2133>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX19yL/kIwex/zyiK501Jr7g1bR/ayZ/xJWY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 3/5] signal: Add unsafe_copy_siginfo_to_user()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 02/09/2021 =C3=A0 20:43, Eric W. Biederman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>
>>> In the same spirit as commit fb05121fd6a2 ("signal: Add
>>> unsafe_get_compat_sigset()"), implement an 'unsafe' version of
>>> copy_siginfo_to_user() in order to use it within user access blocks.
>>>
>>> For that, also add an 'unsafe' version of clear_user().
>>
>> Looking at your use cases you need the 32bit compat version of this
>> as well.
>>
>> The 32bit compat version is too complicated to become a macro, so I
>> don't think you can make this work correctly for the 32bit compat case.
>
> When looking into patch 5/5 that you nacked, I think you missed the fact =
that we
> keep using copy_siginfo_to_user32() as it for the 32 bit compat case.

I did.  My mistake.

However that mistake was so easy I think it mirrors the comments others
have made that this looks like a maintenance hazard.

Is improving the performance of 32bit kernels interesting?
Is improving the performance of 32bit compat support interesting?

If performance one or either of those cases is interesting it looks like
we already have copy_siginfo_to_external32 the factor you would need
to build unsafe_copy_siginfo_to_user32.

So I am not going to say impossible but please make something
maintainable.  I unified all of the compat 32bit siginfo logic because
it simply did not get enough love and attention when it was implemented
per architecture.

In general I think that concern applies to this case as well.  We really
need an implementation that shares as much burden as possible with other
architectures.

Eric


>> Probably-Not-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> Eric
>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   include/linux/signal.h  | 15 +++++++++++++++
>>>   include/linux/uaccess.h |  1 +
>>>   kernel/signal.c         |  5 -----
>>>   3 files changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/signal.h b/include/linux/signal.h
>>> index 3454c7ff0778..659bd43daf10 100644
>>> --- a/include/linux/signal.h
>>> +++ b/include/linux/signal.h
>>> @@ -35,6 +35,21 @@ static inline void copy_siginfo_to_external(siginfo_=
t *to,
>>>   int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t=
 *from);
>>>   int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __us=
er *from);
>>>   +static __always_inline char __user *si_expansion(const siginfo_t __u=
ser
>>> *info)
>>> +{
>>> +	return ((char __user *)info) + sizeof(struct kernel_siginfo);
>>> +}
>>> +
>>> +#define unsafe_copy_siginfo_to_user(to, from, label) do {		\
>>> +	siginfo_t __user *__ucs_to =3D to;				\
>>> +	const kernel_siginfo_t *__ucs_from =3D from;			\
>>> +	char __user *__ucs_expansion =3D si_expansion(__ucs_to);		\
>>> +									\
>>> +	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
>>> +			    sizeof(struct kernel_siginfo), label);	\
>>> +	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
>>> +} while (0)
>>> +
>>>   enum siginfo_layout {
>>>   	SIL_KILL,
>>>   	SIL_TIMER,
>>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>>> index c05e903cef02..37073caac474 100644
>>> --- a/include/linux/uaccess.h
>>> +++ b/include/linux/uaccess.h
>>> @@ -398,6 +398,7 @@ long strnlen_user_nofault(const void __user *unsafe=
_addr, long count);
>>>   #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
>>>   #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,=
s,l),e)
>>>   #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_use=
r(d,s,l),e)
>>> +#define unsafe_clear_user(d, l, e) unsafe_op_wrap(__clear_user(d, l), =
e)
>>>   static inline unsigned long user_access_save(void) { return 0UL; }
>>>   static inline void user_access_restore(unsigned long flags) { }
>>>   #endif
>>> diff --git a/kernel/signal.c b/kernel/signal.c
>>> index a3229add4455..83b5971e4304 100644
>>> --- a/kernel/signal.c
>>> +++ b/kernel/signal.c
>>> @@ -3261,11 +3261,6 @@ enum siginfo_layout siginfo_layout(unsigned sig,=
 int si_code)
>>>   	return layout;
>>>   }
>>>   -static inline char __user *si_expansion(const siginfo_t __user *info)
>>> -{
>>> -	return ((char __user *)info) + sizeof(struct kernel_siginfo);
>>> -}
>>> -
>>>   int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t=
 *from)
>>>   {
>>>   	char __user *expansion =3D si_expansion(to);
