Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32555C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 07:04:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13A261407
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 07:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13A261407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3znm3wbFz3byv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 17:04:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3znP2d8fz2xYx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 17:03:53 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G3znK60xpzB9VY;
 Tue, 15 Jun 2021 09:03:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ze_ieGXUkLHD; Tue, 15 Jun 2021 09:03:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G3znK54jQzB9VX;
 Tue, 15 Jun 2021 09:03:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7825B8B7A3;
 Tue, 15 Jun 2021 09:03:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Jz0W7ONV4vN7; Tue, 15 Jun 2021 09:03:49 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A4CE8B7A0;
 Tue, 15 Jun 2021 09:03:48 +0200 (CEST)
Subject: Re: [PATCH 5/7] signal: Add unsafe_copy_siginfo_to_user()
To: Christoph Hellwig <hch@infradead.org>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <684939dcfef612fac573d1b983a977215b71f64d.1623739212.git.christophe.leroy@csgroup.eu>
 <YMhOMoKKvew0YYCt@infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7061fbee-cc82-2699-cf12-e5a4ae46940f@csgroup.eu>
Date: Tue, 15 Jun 2021 09:03:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMhOMoKKvew0YYCt@infradead.org>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/06/2021 à 08:52, Christoph Hellwig a écrit :
> On Tue, Jun 15, 2021 at 06:41:01AM +0000, Christophe Leroy wrote:
>> +	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
>> +			    sizeof(struct kernel_siginfo), label);	\
>> +	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
>> +} while (0)
> 
> unsafe_clear_user does not exist at this point, and even your later
> patch only adds it for powerpc.
> 

You missed below chunck I guess:

 > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
 > index c05e903cef02..37073caac474 100644
 > --- a/include/linux/uaccess.h
 > +++ b/include/linux/uaccess.h
 > @@ -398,6 +398,7 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 >   #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
 >   #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
 >   #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
 > +#define unsafe_clear_user(d, l, e) unsafe_op_wrap(__clear_user(d, l), e)
 >   static inline unsigned long user_access_save(void) { return 0UL; }
 >   static inline void user_access_restore(unsigned long flags) { }
 >   #endif
