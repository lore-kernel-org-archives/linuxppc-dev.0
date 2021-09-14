Return-Path: <SRS0=BtxG=OE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CAC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 14:01:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1816108B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 14:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A1816108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H84lD57hZz3069
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 00:01:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H84kk5rXkz2xWr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2021 00:01:00 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H84kf3qLwz9sSh;
 Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LUdiTfEngcWB; Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H84kf2vLqz9sSS;
 Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 51B8F8B773;
 Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Sfnj682Q6TWA; Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.207])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A23B8B763;
 Tue, 14 Sep 2021 16:00:57 +0200 (CEST)
Subject: Re: [PATCH RESEND v3 6/6] powerpc/signal: Use
 unsafe_copy_siginfo_to_user()
To: "Eric W. Biederman" <ebiederm@xmission.com>
References: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
 <2b179deba4fd4ec0868cdc48a0230dfa3aa5a22f.1631537060.git.christophe.leroy@csgroup.eu>
 <87h7eopixa.fsf@disp2133> <87y280o38q.fsf@disp2133>
 <96d06ad9-5a9b-b8c3-3c1d-ed8837091a60@csgroup.eu> <87ilz4mgts.fsf@disp2133>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <00226633-0a5a-bcca-0a2a-9bfd754e61a5@csgroup.eu>
Date: Tue, 14 Sep 2021 16:00:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87ilz4mgts.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org, hch@infradead.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/09/2021 à 21:11, Eric W. Biederman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> Le 13/09/2021 à 18:21, Eric W. Biederman a écrit :
>>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>>
>>>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>>>
>>>>> Use unsafe_copy_siginfo_to_user() in order to do the copy
>>>>> within the user access block.
>>>>>
>>>>> On an mpc 8321 (book3s/32) the improvment is about 5% on a process
>>>>> sending a signal to itself.
>>>
>>> If you can't make function calls from an unsafe macro there is another
>>> way to handle this that doesn't require everything to be inline.
>>>
>>>   From a safety perspective it is probably even a better approach.
>>
>> Yes but that's exactly what I wanted to avoid for the native ppc32 case: this
>> double hop means useless pressure on the cache. The siginfo_t structure is 128
>> bytes large, that means 8 lines of cache on powerpc 8xx.
>>
>> But maybe it is acceptable to do that only for the compat case. Let me think
>> about it, it might be quite easy.
> 
> The places get_signal is called tend to be well known.  So I think we
> are safe from a capacity standpoint.
> 
> I am not certain it makes a difference in capacity as there is a high
> probability that the stack was deeper recently than it is now which
> suggests the cache blocks might already be in the cache.
> 
> My sense it is worth benchmarking before optimizing out the extra copy
> like that.
> 
> On the extreme side there is simply building the entire sigframe on the
> stack and then just calling it copy_to_user.  As the stack cache lines
> are likely to be hot, and copy_to_user is quite well optimized
> there is a real possibility that it is faster to build everything
> on the kernel stack, and then copy it to the user space stack.
> 
> It is also possible that I am wrong and we may want to figure out how
> far up we can push the conversion to the 32bit siginfo format.
> 
> If could move the work into collect_signal we could guarantee there
> would be no extra work.  That would require adjusting the sigframe
> generation code on all of the architectures.
> 
> There is a lot we can do but we need benchmarking to tell if it is
> worth it.
> 


Sure, I'm benchmarking all the work I have been doing on signal code 
with the following simple app that I run with 'perf stat':

#include <stdlib.h>
#include <signal.h>

void sigusr1(int sig) { }

int main(int argc, char **argv)
{
	int i = 100000;

	signal(SIGUSR1, sigusr1);
	for (;i--;)
	raise(SIGUSR1);
	exit(0);
}


On an mpc8321 a 32 bits powerpc with KUAP enabled (KUAP is equivalent of 
x86 SMAP)

Before changing copy_siginfo_to_user() to unsafe_copy_siginfo_to_user(), 
'perf stat' reports 1983 msec (task-clock)

After my change I get 1900 msec.

With your approach I get 1930 msec, so we are loosing 36% of the benefit 
of converting to the 'unsafe_' alternative.

So I think it is worth it.

Christophe
