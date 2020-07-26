Return-Path: <SRS0=4CH2=BF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A98DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 20:50:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E7D20715
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 20:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E7D20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFFSh49yhzDrHb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 06:50:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.94; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0094.hostedemail.com
 [216.40.44.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFFQP5zGfzDsP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 06:48:27 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id C430D181D337B;
 Sun, 26 Jul 2020 20:48:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: salt89_0e0b54526f5b
X-Filterd-Recvd-Size: 2643
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
 (Authenticated sender: webmail@joe@perches.com)
 by omf13.hostedemail.com (Postfix) with ESMTPA;
 Sun, 26 Jul 2020 20:48:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Sun, 26 Jul 2020 13:48:23 -0700
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
In-Reply-To: <4e505c35-8428-89bb-7f9b-bc819382c3cd@infradead.org>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
 <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
 <add7c13b1ca24c8cb6f243b99d61c19287020efd.camel@perches.com>
 <4e505c35-8428-89bb-7f9b-bc819382c3cd@infradead.org>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <8ccba434d98ba1319dbb9a386f7a7450@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [172.58.17.243]
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2020-07-26 12:08, Randy Dunlap wrote:
> On 7/26/20 10:49 AM, Joe Perches wrote:
>> On Sun, 2020-07-26 at 10:23 -0700, Randy Dunlap wrote:
>>> On 7/26/20 7:29 AM, Christophe Leroy wrote:
>>>> Randy Dunlap <rdunlap@infradead.org> a écrit :
>>>> 
>>>>> Drop duplicated words in arch/powerpc/ header files.
>>>> 
>>>> How did you detect them ? Do you have some script for tgat, or you 
>>>> just read all comments ?
>>> 
>>> Yes, it's a script that finds lots of false positives, so I have to 
>>> check
>>> each and every one of them for validity.
>> 
>> And it's a lot of work too. (thanks Randy)
>> 
>> It could be something like:
>> 
>> $ grep-2.5.4 -nrP --include=*.[ch] '\b([A-Z]?[a-z]{2,}\b)[ \t]*(?:\n[ 
>> \t]*\*[ \t]*|)\1\b' * | \
>>   grep -vP '\b(?:struct|enum|union)\s+([A-Z]?[a-z]{2,})\s+\*?\s*\1\b' 
>> | \
>>   grep -vP '\blong\s+long\b' | \
>>   grep -vP '\b([A-Z]?[a-z]{2,})(?:\t+| {2,})\1\b'
> 
> Hi Joe,

Hi Randy

> (what is grep-2.5.4 ?)

It's the last version of grep that allowed spanning multiple lines.

That's to find the comment second lines that start with *

> It looks like you tried a few iterations of this -- since it drops 
> things
> like "long long".  There are lots of data types that are repeated & 
> valid.
> And many struct names, like "struct kref kref", "struct completion 
> completion",
> and "struct mutex mutex".  I handle (ignore) those manually

that's the first exclude pattern.

