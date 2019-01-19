Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DDFC61CE8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 17:22:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE682084C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 17:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE682084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hl4s2NsSzDqst
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jan 2019 04:22:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hl373NCmzDqsv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jan 2019 04:21:22 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43hl2x5BSBz9vCJC;
 Sat, 19 Jan 2019 18:21:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 2B8lMW7w35Gr; Sat, 19 Jan 2019 18:21:13 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43hl2x4D1Kz9vCJ9;
 Sat, 19 Jan 2019 18:21:13 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 25AAE79; Sat, 19 Jan 2019 18:21:13 +0100 (CET)
Received: from 37-170-18-222.coucou-networks.fr
 (37-170-18-222.coucou-networks.fr [37.170.18.222]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 19 Jan 2019 18:21:13 +0100
Date: Sat, 19 Jan 2019 18:21:13 +0100
Message-ID: <20190119182113.Horde.DK6jqX3cEzsvR0fKFZrY2g4@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <87zhrx2bf1.fsf@concordia.ellerman.id.au>
In-Reply-To: <87zhrx2bf1.fsf@concordia.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK whic=
h
>> moves the thread_info into task_struct.
>>
>> Moving thread_info into task_struct has the following advantages:
>> - It protects thread_info from corruption in the case of stack
>> overflows.
>> - Its address is harder to determine if stack addresses are
>> leaked, making a number of attacks more difficult.
>>
>> Changes since v12:
>>  - Patch 1: Taken comment from Mike (re-introduced the 'panic' in=20=20
>>=20case memblock allocation fails in setup_64.c
>>  - Patch 1: Added alloc_stack() function in setup_32.c to also=20=20
>>=20panic in case of allocation failure.
>
> Hi Christophe,
>
> I can't get this series to boot on qemu mac99. I'm getting eg:

Problem new with version 13 or it is the first time you test ?

>
> [    0.981514] NFS: Registering the id_resolver key type
> [    0.981752] Key type id_resolver registered
> [    0.981868] Key type id_legacy registered
> [    0.995711] Unrecoverable exception 0 at 0 (msr=3D0)
> [    0.996091] Oops: Unrecoverable exception, sig: 6 [#1]
> [    0.996314] BE PAGE_SIZE=3D4K MMU=3DHash PowerMac
> [    0.996617] Modules linked in:
> [    0.996869] CPU: 0 PID: 416 Comm: modprobe Not tainted=20=20
>=205.0.0-rc2-gcc-7.3.0-00043-g53f2de798792 #342

Comm:modprobe  =3D=3D> Something wrong with modules ? I never tested with=
=20=20
CONFIG_MODULES.

Christophe

>=20[    0.997138] NIP:  00000000 LR: 00000000 CTR: 00000000
> [    0.997309] REGS: ef237f50 TRAP: 0000   Not tainted=20=20=20
>=20(5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792)
> [    0.997508] MSR:  00000000 <>  CR: 00000000  XER: 00000000
> [    0.997712]
> [    0.997712] GPR00: 00000000 ef238000 00000000 00000000 00000000=20=20
>=2000000000 00000000 00000000
> [    0.997712] GPR08: 00000000 00000000 00000000 00000000 00000000=20=20
>=2000000000 c006477c ef13d8c0
> [    0.997712] GPR16: 00000000 00000000 00000000 00000000 00000000=20=20
>=2000000000 00000000 00000000
> [    0.997712] GPR24: 00000000 00000000 00000000 00000000 00000000=20=20
>=2000000000 00000000 00000000
> [    0.998671] NIP [00000000]   (null)
> [    0.998774] LR [00000000]   (null)
> [    0.998895] Call Trace:
> [    0.999030] Instruction dump:
> [    0.999320] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20=
=20
>=20XXXXXXXX XXXXXXXX
> [    0.999546] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 XXXXXXXX=20=
=20
>=20XXXXXXXX XXXXXXXX
> [    1.000023] ---[ end trace 925ea3419844fe68 ]---
>
> I haven't had time to dig any further.
>
> cheers


