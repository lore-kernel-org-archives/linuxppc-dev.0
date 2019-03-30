Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A0AC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 17:20:24 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4E7218CD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 17:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4E7218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Wljc64XkzDqSc
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 04:20:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sdf.org
 (client-ip=205.166.94.20; helo=mx.sdf.org; envelope-from=lkml@sdf.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sdf.org
Received: from mx.sdf.org (mx.sdf.org [205.166.94.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Wlgw4rJ0zDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 04:18:51 +1100 (AEDT)
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
 by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2UHG5GI011346
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO); 
 Sat, 30 Mar 2019 17:16:06 GMT
Received: (from lkml@localhost)
 by sdf.org (8.15.2/8.12.8/Submit) id x2UHG23t020732;
 Sat, 30 Mar 2019 17:16:02 GMT
Date: Sat, 30 Mar 2019 17:16:02 GMT
From: George Spelvin <lkml@sdf.org>
Message-Id: <201903301716.x2UHG23t020732@sdf.org>
To: adrian.hunter@intel.com, ard.biesheuvel@linaro.org,
 benh@kernel.crashing.org, bp@alien8.de, darrick.wong@oracle.com,
 dchinner@redhat.com, dedekind1@gmail.com, gregkh@linuxfoundation.org,
 hpa@zytor.com, jlbec@evilplan.org, jpoimboe@redhat.com,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 lkml@sdf.org, mark@fasheh.com, mingo@redhat.com, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, ocfs2-devel@oss.oracle.com,
 paulus@samba.org, richard@nod.at, sfr@canb.auug.org.au,
 st5pub@yandex.ru, tglx@linutronix.de, vgupta@synopsys.com, x86@kernel.org
Subject: Re: [PATCH 0/5] simple sort swap function usage improvements
In-Reply-To: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
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
Cc: mhocko@suse.com, gustavo@embeddedor.com, peterz@infradead.org,
 amir73il@gmail.com, linux@rasmusvillemoes.dk, kamalesh@linux.vnet.ibm.com,
 piaojun@huawei.com, yamada.masahiro@socionext.com, jiang.biao2@zte.com.cn,
 jslaby@suse.cz, yuehaibing@huawei.com, rppt@linux.ibm.com, ge.changwei@h3c.com,
 keescook@chromium.org, jannh@google.com, ashish.samant@oracle.com,
 npiggin@gmail.com, jiangyiwen@huawei.com, andriy.shevchenko@linux.intel.com,
 lchen@suse.com, malat@debian.org, akpm@linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Great work; that is indeed a logical follow-on.

Reviewed by: George Spelvin <lkml@sdf.org>

I you feel even more ambitious, you could try impementing Rasmus
Villemoes' idea of having generic *compare* functions.  (It's on
my to-do list, but I haven't made meaningful progress yet, and I'm
happy to pawn it off.)

A significant fraction of the time, the sort key is a 4- or 8-byte
integer field in a structure at a small offset from the base or
list_head.

A function pointer < 4096 could be interpreted as encoding:
- Key size (1 bit)
- Key signedness (1 bit)
- Sort direction (1 bit)
- Offset (9 bits; +/-256 words = +/-1024 bytes, or 0..511 words from start)

With the correct level of preprocessor hackery,
SIMPLE_CMP_ASCENDING(struct type, key_field)
SIMPLE_LIST_CMP_ASCENDING(struct type, list_field, key_field)
SIMPLE_CMP_DESCENDING(struct type, key_field)
SIMPLE_LIST_CMP_DESCENDING(struct type, list_field, key_field)

could encode all that and cause a compile-time error if the key
is the wrong type or the offset is out of range.
