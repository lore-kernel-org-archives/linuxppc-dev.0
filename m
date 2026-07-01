Return-Path: <linuxppc-dev+bounces-23295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B6C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:54:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqv2H1fXmz2yN8;
	Wed, 01 Jul 2026 18:53:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782896039;
	cv=none; b=NrSi+gl4qZy6yQwVjcgafWTB1TJvYVCySz7biaNeyc1v5BaQGuCEgdDKswh5O2MLlZ+R2ts+40QoPe+iD4i/7A8QuWCK5iTDahC8ua8hwbRVbJ3qhamIjOY0VcwFdTlxYXAeuRdGXCvVuOZGw4NFV7EyCmz4M5hNsWYv5QP3J/s2pUf7PbtEh8Dfzgq1ybvfJ7jl56PmdhpRmbNs3nx56PnVS8uiRSPGGFSaS5memFJbVuH2VQErUgrbIHu4+lCUtRjUB5rrF8p42/s71Bizkht0KuXODo5bCYY86hw/NuGnYNHErJzK3YVM0dVaosB80IgqKGVcN6KW9CnHFsz7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782896039; c=relaxed/relaxed;
	bh=f9jOYegPwslwL2Ey/z44d8SyEF7LBm16Uq80eeOBC3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXG30CErHgmseNTEEpVx0fYB67DO0pjMK6FM1dVi+vFcjBPc/W+seyD9pL6Zj7sGs22clfTY0mAT9EI6Yu4ndC15sZHXr13Y9CgudH6M+kM+mUQeCySBWu81eK1wvaTW2UazJ3xi18n+fyNOHz0ZgOJQ8PhKmke1IMMU7mTUjVJ0NI5Dcly+BD7s9Rm190C0wqwW5DvDFrov5eFocr3deab1eF+khO4zFBa6rkxIUZkan3+BtmexUkTHCcQBpHzPTudVFDprkz0rMV5x4e26I3uVG4pUPznAZT0HNgEcqWWGO2zuJTDK97ROh0wYX8O8Q8h93S9l5EHbNg7mplcGuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUPFMWiA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUPFMWiA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqv2F4XMgz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:53:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 101AC6001D;
	Wed,  1 Jul 2026 08:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4E71F000E9;
	Wed,  1 Jul 2026 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896034;
	bh=f9jOYegPwslwL2Ey/z44d8SyEF7LBm16Uq80eeOBC3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aUPFMWiAmeCqlwyghILR5V2Xi2R/0J6HC8UOrWNzINOiSUIqtn5RptDAFLTzjoVwR
	 0Voww1Mn74eCZP0+TtFXCCbyCu88Svz85MRQToW52TKkFBnGn8u2ApXnPRtHT2dj7g
	 agcXG33i38gnZg0tmFez/V5vs+PQNBTwzpiq13p9G2QjM/ttNK7p9fK9CUbcQPLKLe
	 5acavaPdSmCXHifnDCkUK3QzR5DAHuvFIbNcLu+qwydgNVh8rRzNxUJFDFprjpieqg
	 SvUhHiZRP7l1f4g9AO5zp8m8WJ9x7o0ZaqT9awmPmwBUjm34/qREYOPAJ+JcxITULH
	 XLFamcXSOO0WA==
Message-ID: <ba00c7a8-b4d5-4d80-859b-d75e9c91ebdb@kernel.org>
Date: Wed, 1 Jul 2026 10:53:49 +0200
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
 <b1d6e9a5-34ce-42ca-906a-d4237e18be25@kernel.org>
 <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <50507bb3-4229-4815-90e8-c01eaad058fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/07/2026 à 10:09, Venkat Rao Bagalkote a écrit :
> 
> On 01/07/26 10:26 am, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 01/07/2026 à 06:32, Venkat Rao Bagalkote a écrit :
>>>
>>> On 01/07/26 7:44 am, Madhavan Srinivasan wrote:
>>>>
>>>> On 7/1/26 12:41 AM, Paul Moore wrote:
>>>>> On Wed, May 13, 2026 at 1:42 AM Madhavan Srinivasan 
>>>>> <maddy@linux.ibm.com> wrote:
>>>>>> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
>>>>>>> On 11/03/26 12:49 am, Paul Moore wrote:
>>>>>>>> On Tue, Mar 10, 2026 at 11:08 AM Christophe Leroy (CS GROUP)
>>>>>>>> <chleroy@kernel.org> wrote:
>>>>>>>>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>>>
>>>>>>>>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>>>>>>>>> targets") added generic support for AUDIT but that didn't include
>>>>>>>>> support for bi-arch like powerpc.
>>>>>>>>>
>>>>>>>>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>>>>>>>>> added generic support for bi-arch.
>>>>>>>>>
>>>>>>>>> Convert powerpc to that bi-arch generic audit support.
>>>>>>>>>
>>>>>>>>> With this change generated text is similar.
>>>>>>>>>
>>>>>>>>> Thomas has confirmed that the previously failing 
>>>>>>>>> filter_exclude/test
>>>>>>>>> is now successful both without and with this patch, see [1]
>>>>>>>>>
>>>>>>>>> [1]
>>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260306115350- 
>>>>>>>>> ef265661-6d6b-4043-9bd0-8e6b437d0d67%40linutronix.de%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771399964577%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FtCHXFR5np67gntCnXqv7Eemo5WuwaIEcywxZQzDADA%3D&reserved=0
>>>>>>>>>
>>>>>>>>> Link: https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinuxppc%2Fissues%2Fissues%2F412&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400190794%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4fPEX7HuGBcxOcXlcJVQvDdP7Y9InhDpbz3z%2BS9lkCQ%3D&reserved=0
>>>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>>> ---
>>>>>>>>> Venkat, a test result with
>>>>>>>>> https://eur01.safelinks.protection.outlook.com/? 
>>>>>>>>> url=https%3A%2F%2Fgithub.com%2Flinux-audit%2Faudit- 
>>>>>>>>> testsuite&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C81e1e4e3bae245103d3308ded729bb47%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184771400214912%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=yHp3p5zNx%2BqQg2cKBsKJADWcUcKVtZstzNScBfWzF%2FQ%3D&reserved=0 would be appreciated.
>>>>>>>> Yes, I'd like to see confirmation that the audit test suite runs 
>>>>>>>> clean
>>>>>>>> on ppc systems with this patch applied, and unfortunately without a
>>>>>>>> ppc system I have no way to test this myself.
>>>>>> My bad, this is a miss from my end.
>>>>>> Venkat is already on this and will update the results here.
>>>>> Do we have an update on this?  Maybe I missed it, but I don't recall
>>>>> seeing any test results.
>>>> Venkat, did run the test but I guess he missed to respond here,
>>>> Details of his test run that he shared me in the internal chat from 
>>>> May 13.
>>>
>>>
>>> Sorry, My bad. I missed updating here. Yes, this was tested in May. 
>>> Please let me know, if a re-run is required?
>>
>> It looks like netcat (https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flinux.die.net%2Fman%2F1%2Fnc&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C97ac234e82884f729d1508ded7480f62%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639184901648983046%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=18PJTLp9ozMqSkWWvBZmtjzjTI355Oq%2F5aqmU6zCiZE%3D&reserved=0) is not installed in you setup. Are you able to install it and rerun the test ?
> 
> 
> I investigated the failure on the RHEL 10 ppc64le test system.
> 
> 
> The netfilter_pkt failure is due to missing userspace dependencies:
> 
> Can't exec "nc": No such file or directory
> Can't exec "iptables": No such file or directory
> Can't exec "ip6tables": No such file or directory
> 
> I checked the system and confirmed that nc, ncat, iptables, and 
> ip6tables are not installed:
> 
> 
> which nc
> which ncat
> which iptables
> which ip6tables
> 
> 
> all return "not found".
> 
> The system has nftables installed (/usr/sbin/nft), but I was unable to 
> locate packages providing nc/ncat or iptables/ip6tables in the currently 
> enabled repositories (epel, rh10_base, rh10_app, rh10_crb).

Found:
- 
https://dl.fedoraproject.org/pub/epel/10/Everything/ppc64le/Packages/n/netcat-1.238-1.el10_3.ppc64le.rpm
- 
https://rpmfind.net/linux/RPM/almalinux-kitten/10/baseos/ppc64le/iptables-nft-1.8.11-6.el10.ppc64le.html
- 
https://www.rpmfind.net/linux/RPM/centos-stream/10/appstream/ppc64le/iptables-devel-1.8.11-14.el10.ppc64le.html

Does it help ?

Christophe

> 
> 
> At this point, the remaining failure appears to be an environmental 
> dependency issue rather than a test failure. Please let me know if there 
> is a recommended package/repository for EL10 ppc64le that provides 
> netcat and iptables compatibility tools, and I can re-run the test.
> 
> 
> Regards,
> 
> Venkat.
> 
>>
>> Thanks
>> Christophe
>>
>>>
>>> Regards,
>>>
>>> Venkat.
>>>
>>>>
>>>> backlog_wait_time_actual_reset/test .. ok
>>>> bpf/test ............................. ok
>>>> exec_execve/test ..................... ok
>>>> exec_name/test ....................... ok
>>>> fanotify/test ........................ ok
>>>> field_compare/test ................... ok
>>>> file_create/test ..................... ok
>>>> file_delete/test ..................... ok
>>>> file_permission/test ................. ok
>>>> file_rename/test ..................... ok
>>>> filter_exclude/test .................. ok
>>>> filter_exit/test ..................... ok
>>>> filter_saddr_fam/test ................ ok
>>>> filter_sessionid/test ................ ok
>>>> io_uring/test ........................ ok
>>>> login_tty/test ....................... ok
>>>> lost_reset/test ...................... ok
>>>> netfilter_pkt/test ................... Can't exec "nc": No such file 
>>>> or directory at netfilter_pkt/test line 83.
>>>>
>>>> Venkat, can you please re-run if possible and paste the log here.
>>>>
>>>> Thanks
>>>> Maddy
>>>>
>>>>
>>


