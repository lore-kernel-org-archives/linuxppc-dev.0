Return-Path: <SRS0=PW48=IB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983F1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 10:58:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F8E64EEE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 10:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F8E64EEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dr9vp06y2z3dRs
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 21:58:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nefkom.net (client-ip=212.18.0.9; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
X-Greylist: delayed 649 seconds by postgrey-1.36 at boromir;
 Wed, 03 Mar 2021 21:57:31 AEDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dr9tz3l9nz3d8h
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Mar 2021 21:57:31 +1100 (AEDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4Dr9fN2CZxz1qtd7;
 Wed,  3 Mar 2021 11:46:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4Dr9fN1Ftmz1qwjx;
 Wed,  3 Mar 2021 11:46:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id SblTSEWGU7-O; Wed,  3 Mar 2021 11:46:35 +0100 (CET)
X-Auth-Info: Axyhjc4rBEzDLbMrWl1hfC1lqjWQmeVKKob8n6+6z1N27WUyAB38JWBlHrVKC9BT
Received: from igel.home (ppp-46-244-163-86.dynamic.mnet-online.de
 [46.244.163.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed,  3 Mar 2021 11:46:35 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
 id 586712C36B8; Wed,  3 Mar 2021 11:46:34 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
References: <51c397a23631d8bb2e2a6515c63440d88bf74afd.1614674144.git.christophe.leroy@csgroup.eu>
 <CANpmjNPOJfL_qsSZYRbwMUrxnXxtF5L3k9hursZZ7k9H1jLEuA@mail.gmail.com>
 <b9dc8d35-a3b0-261a-b1a4-5f4d33406095@csgroup.eu>
 <CAG_fn=WFffkVzqC9b6pyNuweFhFswZfa8RRio2nL9-Wq10nBbw@mail.gmail.com>
 <f806de26-daf9-9317-fdaa-a0f7a32d8fe0@csgroup.eu>
 <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <3abbe4c9-16ad-c168-a90f-087978ccd8f7@csgroup.eu>
 <CANpmjNMKEObjf=WyfDQB5vPmR5RuyUMBJyfr6P2ykCd67wyMbA__49537.1361424745$1614767987$gmane$org@mail.gmail.com>
X-Yow: Somewhere in Tenafly, New Jersey, a chiropractor is viewing
 ``Leave it to Beaver''!
Date: Wed, 03 Mar 2021 11:46:34 +0100
In-Reply-To: <CANpmjNMKEObjf=WyfDQB5vPmR5RuyUMBJyfr6P2ykCd67wyMbA__49537.1361424745$1614767987$gmane$org@mail.gmail.com>
 (Marco Elver's message of "Wed, 3 Mar 2021 11:39:02 +0100")
Message-ID: <87pn0gy0ol.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>, Alexander Potapenko <glider@google.com>,
 linuxppc-dev@lists.ozlabs.org, Dmitry Vyukov <dvyukov@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mär 03 2021, Marco Elver wrote:

> On Wed, 3 Mar 2021 at 11:32, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> ./include/linux/kern_levels.h:5:18: warning: format '%zd' expects argument of type 'signed size_t',
>> but argument 3 has type 'ptrdiff_t' {aka 'const long int'} [-Wformat=]
>>      5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
>>        |                  ^~~~~~
>> ./include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
>>     11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
>>        |                  ^~~~~~~~
>> ./include/linux/printk.h:343:9: note: in expansion of macro 'KERN_ERR'
>>    343 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>>        |         ^~~~~~~~
>> mm/kfence/report.c:233:3: note: in expansion of macro 'pr_err'
>>    233 |   pr_err("Invalid free of 0x%p (in kfence-#%zd):\n", (void *)address,
>>        |   ^~~~~~
>>
>> Christophe
>
> No this is not expected. Is 'signed size_t' != 'long int' on ppc32?

If you want to format a ptrdiff_t you should use %td.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
