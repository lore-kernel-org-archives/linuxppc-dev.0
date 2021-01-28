Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C47C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 12:11:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B8064DCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 12:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B8064DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRK8R3tg2zDrZp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 23:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DRK1B2TM4zDrWX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 23:05:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DRK0r2MLjz9twps;
 Thu, 28 Jan 2021 13:05:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id BwZBJ3dTp9E0; Thu, 28 Jan 2021 13:05:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DRK0r1LFMz9twpr;
 Thu, 28 Jan 2021 13:05:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B67528B800;
 Thu, 28 Jan 2021 13:05:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GighYdz2HD0J; Thu, 28 Jan 2021 13:05:17 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EA208B7F3;
 Thu, 28 Jan 2021 13:05:17 +0100 (CET)
Subject: Re: [PATCH v4 02/10] powerpc/signal: Add unsafe_copy_{vsx,
 fpr}_from_user()
To: David Laight <David.Laight@ACULAB.COM>,
 "'Christopher M. Riedl'" <cmr@codefail.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20210128040424.12720-1-cmr@codefail.de>
 <20210128040424.12720-3-cmr@codefail.de>
 <6a6ce1a53fcf4669a9848114d3460fef@AcuMS.aculab.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2e0dedc0-fce6-5b80-354d-c0d5ff1258e0@csgroup.eu>
Date: Thu, 28 Jan 2021 13:05:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6a6ce1a53fcf4669a9848114d3460fef@AcuMS.aculab.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 28/01/2021 à 11:38, David Laight a écrit :
> From: Christopher M. Riedl
>> Sent: 28 January 2021 04:04
>>
>> Reuse the "safe" implementation from signal.c except for calling
>> unsafe_copy_from_user() to copy into a local buffer.
>>
>> Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
>> ---
>>   arch/powerpc/kernel/signal.h | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
>> index 2559a681536e..c18402d625f1 100644
>> --- a/arch/powerpc/kernel/signal.h
>> +++ b/arch/powerpc/kernel/signal.h
>> @@ -53,6 +53,33 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
>>   				&buf[i], label);\
>>   } while (0)
>>
>> +#define unsafe_copy_fpr_from_user(task, from, label)	do {		\
>> +	struct task_struct *__t = task;					\
>> +	u64 __user *__f = (u64 __user *)from;				\
>> +	u64 buf[ELF_NFPREG];						\
> 
> How big is that buffer?

#define ELF_NFPREG	33

So that's 264 bytes.

That's a bit big but still reasonable I think.

Christophe

> Isn't is likely to be reasonably large compared to a reasonable
> kernel stack frame.
> Especially since this isn't even a leaf function.
> 
>> +	int i;								\
>> +									\
>> +	unsafe_copy_from_user(buf, __f, ELF_NFPREG * sizeof(double),	\
> 
> That really ought to be sizeof(buf).
> 
> 	David
> 
> 
>> +				label);					\
>> +	for (i = 0; i < ELF_NFPREG - 1; i++)				\
>> +		__t->thread.TS_FPR(i) = buf[i];				\
>> +	__t->thread.fp_state.fpscr = buf[i];				\
>> +} while (0)
>> +
>> +#define unsafe_copy_vsx_from_user(task, from, label)	do {		\
>> +	struct task_struct *__t = task;					\
>> +	u64 __user *__f = (u64 __user *)from;				\
>> +	u64 buf[ELF_NVSRHALFREG];					\
>> +	int i;								\
>> +									\
>> +	unsafe_copy_from_user(buf, __f,					\
>> +				ELF_NVSRHALFREG * sizeof(double),	\
>> +				label);					\
>> +	for (i = 0; i < ELF_NVSRHALFREG ; i++)				\
>> +		__t->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];	\
>> +} while (0)
>> +
>> +
>>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>>   #define unsafe_copy_ckfpr_to_user(to, task, label)	do {		\
>>   	struct task_struct *__t = task;					\
>> @@ -80,6 +107,10 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
>>   	unsafe_copy_to_user(to, (task)->thread.fp_state.fpr,	\
>>   			    ELF_NFPREG * sizeof(double), label)
>>
>> +#define unsafe_copy_fpr_from_user(task, from, label)			\
>> +	unsafe_copy_from_user((task)->thread.fp_state.fpr, from,	\
>> +			    ELF_NFPREG * sizeof(double), label)
>> +
>>   static inline unsigned long
>>   copy_fpr_to_user(void __user *to, struct task_struct *task)
>>   {
>> @@ -115,6 +146,8 @@ copy_ckfpr_from_user(struct task_struct *task, void __user *from)
>>   #else
>>   #define unsafe_copy_fpr_to_user(to, task, label) do { } while (0)
>>
>> +#define unsafe_copy_fpr_from_user(task, from, label) do { } while (0)
>> +
>>   static inline unsigned long
>>   copy_fpr_to_user(void __user *to, struct task_struct *task)
>>   {
>> --
>> 2.26.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
