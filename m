Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACD421A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 16:25:17 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 60A891401F6
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2015 16:25:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 18 Jun 2015 16:25:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4E77A2BB0067
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2015 16:25:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5I6P4nT35193042
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2015 16:25:13 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5I6Oexp005933
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2015 16:24:40 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF] disk-label: add support for booting from GPT FAT
 partition
In-Reply-To: <20150617122248.77211775@thh440s>
References: <1434017929-1792-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150617122248.77211775@thh440s>
Date: Thu, 18 Jun 2015 11:54:13 +0530
Message-ID: <874mm5edpu.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Huth <thuth@redhat.com> writes:

> On Thu, 11 Jun 2015 15:48:49 +0530
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>
>> +   block-size * to seek-pos
>> +   block gpt>part-entry-size l@-le to gpt-part-size
>> +   block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
>> +   1+ 1 ?DO
>> +      seek-pos 0 seek drop
>> +      block gpt-part-size read drop
>
> Can you be sure that gpt-part-size is only smaller than 4096 bytes
> here? 

So the size is usually 128, so this should be fine.

https://en.wikipedia.org/wiki/GUID_Partition_Table

Section: GPT header format

"84 (0x54)	4 bytes	Size of a single partition entry (usually 128)"

> If not, you might overflow the block array, don't you?

Regards
Nikunj
