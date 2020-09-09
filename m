Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C1CC43461
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:22:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFA6208FE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFA6208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmX4d6F8PzDqQX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 16:22:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmX2P4bCkzDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 16:20:43 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BmX2G04lVz9v0Yn;
 Wed,  9 Sep 2020 08:20:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id yEORPIhV6Rga; Wed,  9 Sep 2020 08:20:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BmX2F6N82z9v0Ym;
 Wed,  9 Sep 2020 08:20:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B2DFA8B7D5;
 Wed,  9 Sep 2020 08:20:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 9mJYFD7ibOLa; Wed,  9 Sep 2020 08:20:38 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7011A8B7D4;
 Wed,  9 Sep 2020 08:20:37 +0200 (CEST)
Subject: Re: [PATCH v1 4/5] powerpc/fault: Avoid heavy
 search_exception_tables() verification
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
 <b07bac7a882c69deb9e6c8f234a68b3022f29072.1596734105.git.christophe.leroy@csgroup.eu>
 <871rjb5vv4.fsf@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1ded5e11-a9e0-a98f-295c-c623e0a5ed36@csgroup.eu>
Date: Wed, 9 Sep 2020 08:20:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <871rjb5vv4.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 09/09/2020 à 08:04, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> search_exception_tables() is an heavy operation, we have to avoid it.
>> When KUAP is selected, we'll know the fault has been blocked by KUAP.
>> Otherwise, it behaves just as if the address was already in the TLBs
>> and no fault was generated.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/fault.c | 20 +++++---------------
>>   1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 525e0c2b5406..edde169ba3a6 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -214,24 +214,14 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
>>   	if (address >= TASK_SIZE)
>>   		return true;
>>   
>> -	if (!is_exec && (error_code & DSISR_PROTFAULT) &&
>> -	    !search_exception_tables(regs->nip)) {
>> +	// Read/write fault blocked by KUAP is bad, it can never succeed.
>> +	if (bad_kuap_fault(regs, address, is_write)) {
>>   		pr_crit_ratelimited("Kernel attempted to access user page (%lx) - exploit attempt? (uid: %d)\n",
>> -				    address,
>> -				    from_kuid(&init_user_ns, current_uid()));
>> -	}
>> -
>> -	// Fault on user outside of certain regions (eg. copy_tofrom_user()) is bad
>> -	if (!search_exception_tables(regs->nip))
>> -		return true;
> 
> We still need to keep this ? Without that we detect the lack of
> exception tables pretty late.

Is that a problem at all to detect the lack of exception tables late ?
That case is very unlikely and will lead to failure anyway. So, is it 
worth impacting performance of the likely case which will always have an 
exception table and where we expect the exception to run as fast as 
possible ?

The other architectures I have looked at (arm64 and x86) only have the 
exception table search together with the down_read_trylock(&mm->mmap_sem).

Christophe
