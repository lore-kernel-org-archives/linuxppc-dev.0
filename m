Return-Path: <linuxppc-dev+bounces-23241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D07DC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 04:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqnmv4lNyz2yQL;
	Wed, 01 Jul 2026 14:57:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782881823;
	cv=none; b=nvb8vGRPH6w7Pn8XiUN8SK3Uayp1kFsvuBwTP/grPG3S9iukltyxF3tilR1Wl3m41vNlQihlfUgC8waEowUyguL7JAeeLr61jaXGRLICZdui/FexHoD4++N9ysSqWnDZuSpu5HRrXJqB/QkktI+1eNc67+iMpbXuyGlBfpse2+/znjw5VGWD/b8ZvJ5mcU7EsxIZbnu5ZP7HrsCipayviR6KCUKxEFV2tsLxfDIrdnc1wRXHMdHCSCs483rvIfKIBsgvmduarcElBaOvaQW2vVXUKcaJceY9mFZi4o6f61ZTVhR6uOcZIGMIhuKkEFD7DORZeHD++kcwALo8FNFrug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782881823; c=relaxed/relaxed;
	bh=B7d+10Uvi/UxpMSuQEdexlP9g+ODgKZCmk6Fy2a5ALc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDzTTjJfYaW7iErd8kbPd1m+TTu7/kTOJlNj4VsWFAlJVSszwPdB6GEJ1DLMth0PFCM8e/r89HyN1g+OswTviAeWpHQoYHoCE5R5lsOJ9hFHKzx9Eo6Ku4caL6GYUXhwc22y0lkToks5E30Y+BjpvhglngOt+y7pyrmiPeIyAZhtWpeZ8nshLe+tJUpGM8OvXyJJhv+/nyqL2NYXQInghNR4hG9W2nWlKaYfJhnsGiCVPav5CSaBUH3nWWyhsCZ6gH3Zsc1HF9gv5n1SQ33O2cTtJvRD9AJ5AVtR2t8DKf2roqqpmFTLTxijygA2iTqSzK7hFq5l39VQ2iuk3Ehsnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQW9WvBo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQW9WvBo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqnmt57XVz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 14:57:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF628435D5;
	Wed,  1 Jul 2026 04:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5106F1F000E9;
	Wed,  1 Jul 2026 04:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782881819;
	bh=B7d+10Uvi/UxpMSuQEdexlP9g+ODgKZCmk6Fy2a5ALc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HQW9WvBoU8dmai0QWeSa+GVUBASgf29CX6/85aKgcvemByvyyudqoZGBnEGLm+HNX
	 kntkeSVKyniPBOlosCqUj3eS+4BBK7IltPND8wQWTsFL8HRx6pV/7Rzfqj0QSmztKF
	 OjYmJ5KM67AKp5fcROJEOuLI2uUmwI+FCT664C6MLLje5i+TVNEnyjQJUgrz/2Xc6+
	 UIZt9/dm5301+Oh7p8mf5vl2pFNqjuRMzcfzcsmjKJBAPBqDJshgm3CbqY+bUfSsT5
	 gq4AqbduZZY1rVxZheMZJKJtummf3PLjTtdWiQbP8Vbz+LcDduD0l92lRvyCKTcqpp
	 pBdk8aj+Zmiog==
Message-ID: <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org>
Date: Wed, 1 Jul 2026 06:56:52 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, ritesh.list@gmail.com
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com>
 <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
 <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
 <ea6e629f-dac7-45dd-bb18-5cd6361fe6c4@linux.ibm.com>
 <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <9c53ae3f-ccfd-4e8f-ac4f-0038e9b97a7e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/07/2026 à 06:32, Venkat Rao Bagalkote a écrit :
> 
> On 01/07/26 7:44 am, Madhavan Srinivasan wrote:
>>
>> On 7/1/26 12:41 AM, Paul Moore wrote:
>>> On Wed, May 13, 2026 at 1:42 AM Madhavan Srinivasan 
>>> <maddy@linux.ibm.com> wrote:
>>>> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
>>>>> On 11/03/26 12:49 am, Paul Moore wrote:
>>>>>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>>>>>> <chleroy@kernel.org> wrote:
>>>>>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>
>>>>>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>>>>>>> targets") added generic support for AUDIT but that didn't include
>>>>>>> support for bi-arch like powerpc.
>>>>>>>
>>>>>>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>>>>>>> added generic support for bi-arch.
>>>>>>>
>>>>>>> Convert powerpc to that bi-arch generic audit support.
>>>>>>>
>>>>>>> With this change generated text is similar.
>>>>>>>
>>>>>>> Thomas has confirmed that the previously failing filter_exclude/test
>>>>>>> is now successful both without and with this patch, see [1]
>>>>>>>
>>>>>>> [1]
>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260306115350- 
>>>>>>> ef265661-6d6b-4043-9bd0-8e6b437d0d67%40linutronix.de%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771399964577%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FtCHXFR5np67gntCnXqv7Eemo5WuwaIEcywxZQzDADA%3D&reserved=0
>>>>>>>
>>>>>>> Link: https://eur01.safelinks.protection.outlook.com/? 
>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinuxppc%2Fissues%2Fissues%2F412&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400190794%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4fPEX7HuGBcxOcXlcJVQvDdP7Y9InhDpbz3z%2BS9lkCQ%3D&reserved=0
>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>>> ---
>>>>>>> Venkat, a test result with
>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinux-audit%2Faudit- 
>>>>>>> testsuite&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400214912%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=yHp3p5zNx%2BqQg2cKBsKJADWcUcKVtZstzNScBfWzF%2FQ%3D&reserved=0 would be appreciated.
>>>>>> Yes, I'd like to see confirmation that the audit test suite runs 
>>>>>> clean
>>>>>> on ppc systems with this patch applied, and unfortunately without a
>>>>>> ppc system I have no way to test this myself.
>>>> My bad, this is a miss from my end.
>>>> Venkat is already on this and will update the results here.
>>> Do we have an update on this?  Maybe I missed it, but I don't recall
>>> seeing any test results.
>> Venkat, did run the test but I guess he missed to respond here,
>> Details of his test run that he shared me in the internal chat from 
>> May 13.
> 
> 
> Sorry, My bad. I missed updating here. Yes, this was tested in May. 
> Please let me know, if a re-run is required?

It looks like netcat (https://linux.die.net/man/1/nc) is not installed 
in you setup. Are you able to install it and rerun the test ?

Thanks
Christophe

> 
> Regards,
> 
> Venkat.
> 
>>
>> backlog_wait_time_actual_reset/test .. ok
>> bpf/test ............................. ok
>> exec_execve/test ..................... ok
>> exec_name/test ....................... ok
>> fanotify/test ........................ ok
>> field_compare/test ................... ok
>> file_create/test ..................... ok
>> file_delete/test ..................... ok
>> file_permission/test ................. ok
>> file_rename/test ..................... ok
>> filter_exclude/test .................. ok
>> filter_exit/test ..................... ok
>> filter_saddr_fam/test ................ ok
>> filter_sessionid/test ................ ok
>> io_uring/test ........................ ok
>> login_tty/test ....................... ok
>> lost_reset/test ...................... ok
>> netfilter_pkt/test ................... Can't exec "nc": No such file 
>> or directory at netfilter_pkt/test line 83.
>>
>> Venkat, can you please re-run if possible and paste the log here.
>>
>> Thanks
>> Maddy
>>
>>


