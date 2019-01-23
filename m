Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84882C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 23:13:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F8321855
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 23:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F8321855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lLgN1HsYzDqK1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 10:13:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lLcH1zPWzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 10:10:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43lLcG3g6bz9s7h;
 Thu, 24 Jan 2019 10:10:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
In-Reply-To: <20190119182113.Horde.DK6jqX3cEzsvR0fKFZrY2g4@messagerie.si.c-s.fr>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <87zhrx2bf1.fsf@concordia.ellerman.id.au>
 <20190119182113.Horde.DK6jqX3cEzsvR0fKFZrY2g4@messagerie.si.c-s.fr>
Date: Thu, 24 Jan 2019 10:10:37 +1100
Message-ID: <875zufx95e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LEROY Christophe <christophe.leroy@c-s.fr> writes:
> Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:
>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK whi=
ch
>>> moves the thread_info into task_struct.
>>>
>>> Moving thread_info into task_struct has the following advantages:
>>> - It protects thread_info from corruption in the case of stack
>>> overflows.
>>> - Its address is harder to determine if stack addresses are
>>> leaked, making a number of attacks more difficult.
>>>
>>> Changes since v12:
>>>  - Patch 1: Taken comment from Mike (re-introduced the 'panic' in=20=20
>>> case memblock allocation fails in setup_64.c
>>>  - Patch 1: Added alloc_stack() function in setup_32.c to also=20=20
>>> panic in case of allocation failure.
>>
>> Hi Christophe,
>>
>> I can't get this series to boot on qemu mac99. I'm getting eg:
>
> Problem new with version 13 or it is the first time you test ?

I did test a previous version of the series, but I'm not sure if I
tested pmac32 before. So I don't have a known good version.

>> [    0.981514] NFS: Registering the id_resolver key type
>> [    0.981752] Key type id_resolver registered
>> [    0.981868] Key type id_legacy registered
>> [    0.995711] Unrecoverable exception 0 at 0 (msr=3D0)
>> [    0.996091] Oops: Unrecoverable exception, sig: 6 [#1]
>> [    0.996314] BE PAGE_SIZE=3D4K MMU=3DHash PowerMac
>> [    0.996617] Modules linked in:
>> [    0.996869] CPU: 0 PID: 416 Comm: modprobe Not tainted=20=20
>> 5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792 #342
>
> Comm:modprobe  =3D=3D> Something wrong with modules ? I never tested with=
=20=20
> CONFIG_MODULES.

Yep good clue.

cheers
