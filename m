Return-Path: <SRS0=voBx=EC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44517C55179
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 23:39:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFC92223C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 23:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFC92223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CLSpF0rqkzDqRs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2020 10:39:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nefkom.net (client-ip=212.18.0.9; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CLSmX55b8zDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2020 10:37:28 +1100 (AEDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4CLSmP52JLz1qrf4;
 Wed, 28 Oct 2020 00:37:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4CLSmP4L4Wz1qxh0;
 Wed, 28 Oct 2020 00:37:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id d_0TcLPL1O-b; Wed, 28 Oct 2020 00:37:24 +0100 (CET)
X-Auth-Info: y1E296PKjR1EjwCQjRjly4MXLwtDaL72s0jq/tkD+COt/3N7THhYadhmeT3nZR5p
Received: from igel.home (ppp-46-244-161-64.dynamic.mnet-online.de
 [46.244.161.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed, 28 Oct 2020 00:37:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
 id EF9D32C2B09; Wed, 28 Oct 2020 00:37:23 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/uaccess: Switch __put_user_size_allowed()
 to __put_user_asm_goto()
References: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy__44535.5968013004$1599217383$gmane$org@csgroup.eu>
 <87mu079ron.fsf@igel.home>
X-Yow: ...I think I'm having an overnight sensation right now!!
Date: Wed, 28 Oct 2020 00:37:23 +0100
In-Reply-To: <87mu079ron.fsf@igel.home> (Andreas Schwab's message of "Wed, 28
 Oct 2020 00:26:16 +0100")
Message-ID: <87imav9r64.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

On Okt 28 2020, Andreas Schwab wrote:

> On Sep 04 2020, Christophe Leroy wrote:
>
>> __put_user_asm_goto() provides more flexibility to GCC and avoids using
>> a local variable to tell if the write succeeded or not.
>> GCC can then avoid implementing a cmp in the fast path.
>
> That breaks CLONE_CHILD_SETTID.  I'm getting an assertion failure in
> __libc_fork (THREAD_GETMEM (self, tid) != ppid).

This is what schedule_tail now looks like.  As you can see, put_user has
become a nop:

000000000000455c <.schedule_tail>:
    455c:       7c 08 02 a6     mflr    r0
    4560:       f8 01 00 10     std     r0,16(r1)
    4564:       f8 21 ff 91     stdu    r1,-112(r1)
    4568:       4b ff cd 4d     bl      12b4 <.finish_task_switch>
    456c:       4b ff c0 99     bl      604 <.balance_callback>
    4570:       e8 6d 01 88     ld      r3,392(r13)
    4574:       e9 23 06 b0     ld      r9,1712(r3)
    4578:       2f a9 00 00     cmpdi   cr7,r9,0
    457c:       41 9e 00 14     beq     cr7,4590 <.schedule_tail+0x34>
    4580:       38 80 00 00     li      r4,0
    4584:       38 a0 00 00     li      r5,0
    4588:       48 00 00 01     bl      4588 <.schedule_tail+0x2c>
                        4588: R_PPC64_REL24     .__task_pid_nr_ns
    458c:       60 00 00 00     nop
    4590:       48 00 00 01     bl      4590 <.schedule_tail+0x34>
                        4590: R_PPC64_REL24     .calculate_sigpending
    4594:       60 00 00 00     nop
    4598:       38 21 00 70     addi    r1,r1,112
    459c:       e8 01 00 10     ld      r0,16(r1)
    45a0:       7c 08 03 a6     mtlr    r0
    45a4:       4e 80 00 20     blr

This is schedule_tail in 5.9:

000000000000455c <.schedule_tail>:
    455c:       7c 08 02 a6     mflr    r0
    4560:       fb c1 ff f0     std     r30,-16(r1)
    4564:       fb e1 ff f8     std     r31,-8(r1)
    4568:       f8 01 00 10     std     r0,16(r1)
    456c:       f8 21 ff 81     stdu    r1,-128(r1)
    4570:       4b ff cd 45     bl      12b4 <.finish_task_switch>
    4574:       4b ff c0 91     bl      604 <.balance_callback>
    4578:       eb cd 01 88     ld      r30,392(r13)
    457c:       eb fe 06 b0     ld      r31,1712(r30)
    4580:       2f bf 00 00     cmpdi   cr7,r31,0
    4584:       41 9e 00 2c     beq     cr7,45b0 <.schedule_tail+0x54>
    4588:       7f c3 f3 78     mr      r3,r30
    458c:       38 80 00 00     li      r4,0
    4590:       38 a0 00 00     li      r5,0
    4594:       48 00 00 01     bl      4594 <.schedule_tail+0x38>
                        4594: R_PPC64_REL24     .__task_pid_nr_ns
    4598:       60 00 00 00     nop
    459c:       e9 3e 0a b8     ld      r9,2744(r30)
    45a0:       7f bf 48 40     cmpld   cr7,r31,r9
    45a4:       41 9d 00 0c     bgt     cr7,45b0 <.schedule_tail+0x54>
    45a8:       2b a9 00 03     cmpldi  cr7,r9,3
    45ac:       41 9d 00 14     bgt     cr7,45c0 <.schedule_tail+0x64>
    45b0:       48 00 00 01     bl      45b0 <.schedule_tail+0x54>
                        45b0: R_PPC64_REL24     .calculate_sigpending
    45b4:       60 00 00 00     nop
    45b8:       38 21 00 80     addi    r1,r1,128
    45bc:       48 00 00 00     b       45bc <.schedule_tail+0x60>
                        45bc: R_PPC64_REL24     _restgpr0_30
    45c0:       39 20 00 00     li      r9,0
    45c4:       90 7f 00 00     stw     r3,0(r31)
    45c8:       4b ff ff e8     b       45b0 <.schedule_tail+0x54>


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
