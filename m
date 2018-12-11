Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59136C67839
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:17:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2422084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2422084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DvTH5Cg0zDqyw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 09:17:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DvQh1YqyzDqDY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 09:15:40 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43DvQc2388z9v0sP;
 Tue, 11 Dec 2018 23:15:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id i4ZDwfpi6__X; Tue, 11 Dec 2018 23:15:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43DvQc1MzNz9v0sN;
 Tue, 11 Dec 2018 23:15:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 67CBF8B818;
 Tue, 11 Dec 2018 23:15:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id E5ORCR9wb88g; Tue, 11 Dec 2018 23:15:36 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E65B08B812;
 Tue, 11 Dec 2018 23:15:35 +0100 (CET)
Subject: Re: [RFC PATCH v2 11/11] powerpc/book3s32: Implement Kernel Userspace
 Access Protection
To: Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
 <98e37def51328f58d8c2ceb60edd4b3da7b6f2ef.1543356926.git.christophe.leroy@c-s.fr>
 <a6dbd5284d8700d591614481fda242a25ca5a3b5.camel@russell.cc>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fa21d262-1d44-6303-94a5-37fe2f060132@c-s.fr>
Date: Tue, 11 Dec 2018 20:46:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a6dbd5284d8700d591614481fda242a25ca5a3b5.camel@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 12/11/2018 05:25 AM, Russell Currey wrote:
> On Wed, 2018-11-28 at 09:27 +0000, Christophe Leroy wrote:
>> This patch implements Kernel Userspace Access Protection for
>> book3s/32.
>>
>> Due to limitations of the processor page protection capabilities,
>> the protection is only against writing. read protection cannot be
>> achieved using page protection.
>>
>> In order to provide the protection, Ku and Ks keys are modified in
>> Userspace Segment registers, and different PP bits are used to:
>>
>> PP01 provides RW for Key 0 and RO for Key 1
>> PP10 provides RW for all
>> PP11 provides RO for all
>>
>> Today PP10 is used for RW pages and PP11 for RO pages. This patch
>> modifies page protection to PP01 for RW pages.
>>
>> Then segment registers are set to Ku 0 and Ks 1. When kernel needs
>> to write to RW pages, the associated segment register is changed to
>> Ks 0 in order to allow write access to the kernel.
>>
>> In order to avoid having the read all segment registers when
>> locking/unlocking the access, some data is kept in the thread_struct
>> and saved on stack on exceptions. The field identifies both the
>> first unlocked segment and the first segment following the last
>> unlocked one. When no segment is unlocked, it contains value 0.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Hey Christophe, I tried to test this and got a machine check after the
> kernel starts init.

A program check you mean ?

> 
> Vector: 700 (Program Check) at [ef0b5e70]
>      pc: 00000ca4
>      lr: b7e1a030
>      sp: ef0b5f30
>     msr: 81002
>    current = 0xef0b8000
>      pid   = 1, comm = init
> 
> Testing with mac99 model in qemu.

That's pretty surprising. At 0xca4 there is nothing particular for me. 
This is a handler for system call. Do you have the same ?
How can this trigger a program check ? According to the MSR, the check 
is due to an illegal instruction (bit 12). An we are with MMU off.

c0000c00 <SystemCall>:
c0000c00:       7d 50 43 a6     mtsprg  0,r10
c0000c04:       7d 71 43 a6     mtsprg  1,r11
c0000c08:       7d 40 00 26     mfcr    r10
c0000c0c:       7d 7b 02 a6     mfsrr1  r11
c0000c10:       71 6b 40 00     andi.   r11,r11,16384
c0000c14:       3d 61 40 00     addis   r11,r1,16384
c0000c18:       41 82 00 14     beq     c0000c2c <SystemCall+0x2c>
c0000c1c:       7d 73 42 a6     mfsprg  r11,3
c0000c20:       81 6b fb d8     lwz     r11,-1064(r11)
c0000c24:       39 6b 20 00     addi    r11,r11,8192
c0000c28:       3d 6b 40 00     addis   r11,r11,16384
c0000c2c:       39 6b ff 40     addi    r11,r11,-192
c0000c30:       91 4b 00 a8     stw     r10,168(r11)
c0000c34:       91 8b 00 40     stw     r12,64(r11)
c0000c38:       91 2b 00 34     stw     r9,52(r11)
c0000c3c:       7d 50 42 a6     mfsprg  r10,0
c0000c40:       91 4b 00 38     stw     r10,56(r11)
c0000c44:       7d 91 42 a6     mfsprg  r12,1
c0000c48:       91 8b 00 3c     stw     r12,60(r11)
c0000c4c:       7d 48 02 a6     mflr    r10
c0000c50:       91 4b 00 a0     stw     r10,160(r11)
c0000c54:       7d 9a 02 a6     mfsrr0  r12
c0000c58:       7d 3b 02 a6     mfsrr1  r9
c0000c5c:       90 2b 00 14     stw     r1,20(r11)
c0000c60:       90 2b 00 00     stw     r1,0(r11)
c0000c64:       3c 2b c0 00     addis   r1,r11,-16384
c0000c68:       39 40 10 02     li      r10,4098
c0000c6c:       7d 40 01 24     mtmsr   r10
c0000c70:       90 0b 00 10     stw     r0,16(r11)
c0000c74:       3d 40 72 65     lis     r10,29285
c0000c78:       39 4a 67 73     addi    r10,r10,26483
c0000c7c:       91 4b 00 08     stw     r10,8(r11)
c0000c80:       90 6b 00 1c     stw     r3,28(r11)
c0000c84:       90 8b 00 20     stw     r4,32(r11)
c0000c88:       90 ab 00 24     stw     r5,36(r11)
c0000c8c:       90 cb 00 28     stw     r6,40(r11)
c0000c90:       90 eb 00 2c     stw     r7,44(r11)
c0000c94:       91 0b 00 30     stw     r8,48(r11)
c0000c98:       39 40 0c 01     li      r10,3073
c0000c9c:       91 4b 00 b0     stw     r10,176(r11)
c0000ca0:       39 40 10 32     li      r10,4146
c0000ca4:       51 2a 04 20     rlwimi  r10,r9,0,16,16
c0000ca8:       48 01 13 5d     bl      c0012004 <transfer_to_handler>

Christophe

> 
> - Russell
> 
