Return-Path: <SRS0=LYYN=BU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4726C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 10:25:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC946206C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 10:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="O6PuOW5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC946206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQBt80yxjzDqGP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 20:25:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.218;
 helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=O6PuOW5n; 
 dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQBqz4x0lzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 20:23:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597054983;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=XJie8QPwzzKp5ht4+C0eHQBwTXCtYCcoSWtF0pbXkWk=;
 b=O6PuOW5nmxZir7+/6Zu2o1xUVzbuWSeQjY/n0vQcDVPpNBOJap7oJc7/4/FBftTw+1
 r8faEW/g7+4wetO9Hn/swyvnlCf9Gyqx0QyFrI9CiOM96wr7ScgaeCXtFK/rdlWNRT5d
 BtnEVWZtEm9zUCbMaSOSQG8+lhV/LNuIFK4zKFkEFuuZRhRBh6CXn9GLcxKqkcL4lFnr
 s+goSQLYMkCiasjMSmEgemo/yAwySTK/D1HfMLV9fY0N8m7vRqIh6sceXmtJw2a+SggH
 pguNMSno0c9OOAMBtbnz1ftUgfxKEZp5nNCVI/FcoKO5KPID7AvKSRK8D9Eua751ZaAR
 XUow==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhScjcMpGbpwMjg24lToKxMjG8j"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:1d6a:acb3:bd15:555]
 by smtp.strato.de (RZmta 46.10.5 AUTH)
 with ESMTPSA id 60686ew7AAMqUG0
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 10 Aug 2020 12:22:52 +0200 (CEST)
Subject: Re: [PASEMI] Nemo board doesn't boot anymore after the commit
 "powerpc/book3s64/pkeys: Simplify pkey disable branch"
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <87h7tb4zwp.fsf@linux.ibm.com>
 <E1C071A5-19D1-4493-B04A-4507A70D7848@xenosoft.de>
 <bc1975fb-23df-09c2-540a-c13b39ad56c5@xenosoft.de>
 <51482c70-1007-1202-9ed1-2d174c1e923f@xenosoft.de>
 <9688335c-d7d0-9eaa-22c6-511e708e0d2a@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <44a5b0f4-0ec8-8608-4342-f93c1c581e02@xenosoft.de>
Date: Mon, 10 Aug 2020 12:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9688335c-d7d0-9eaa-22c6-511e708e0d2a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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
Cc: Olof Johansson <olof@lixom.net>, Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Am 10.08.20 um 10:58 schrieb Aneesh Kumar K.V:
> On 8/10/20 2:15 PM, Christian Zigotzky wrote:
>> Hello Aneesh,
>>
>> I tested the new kernel today and unfortunately it doesn't run very 
>> well.
>>
>> I have only one core (1 physical processor; 1 core; 2 threads) 
>> instead of two cores (1 physical processor; 2 cores; 2 threads) so 
>> the system is slower.
>>
>> Boot log: http://www.xenosoft.de/dmesg_nemo_board_kernel_5.9.txt
>>
>> Could you please check the updates?
>
>
> modified   arch/powerpc/mm/book3s64/hash_utils.c
> @@ -1116,7 +1116,8 @@ void hash__early_init_mmu_secondary(void)
>          tlbiel_all();
>
>  #ifdef CONFIG_PPC_MEM_KEYS
> -    mtspr(SPRN_UAMOR, default_uamor);
> +    if (mmu_has_feature(MMU_FTR_PKEY))
> +        mtspr(SPRN_UAMOR, default_uamor);
>  #endif
>  }
>  #endif /* CONFIG_SMP */
>
>
>
> -aneesh
Hello Aneesh,

Your modifications work! I have 2 cores again and I can see the boot 
messages.

Thanks a lot!

Cheers,
Christian
