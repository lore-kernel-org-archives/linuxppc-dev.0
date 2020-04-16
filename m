Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F0C2BB55
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 17:05:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C0C20732
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 17:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C0C20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4935FJ2qW4zDqTW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 03:05:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=deneb.enyo.de (client-ip=37.24.231.21; helo=albireo.enyo.de;
 envelope-from=fw@deneb.enyo.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Received: from albireo.enyo.de (albireo.enyo.de [37.24.231.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4934lX4KhhzDqxL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 02:42:47 +1000 (AEST)
Received: from [172.17.203.2] (helo=deneb.enyo.de)
 by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 id 1jP7az-0003ic-3t; Thu, 16 Apr 2020 16:42:33 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
 (envelope-from <fw@deneb.enyo.de>)
 id 1jP7ay-0001zp-VH; Thu, 16 Apr 2020 18:42:32 +0200
From: Florian Weimer <fw@deneb.enyo.de>
To: Rich Felker <dalias@libc.org>
Subject: Re: [musl] Powerpc Linux 'scv' system call ABI proposal take 2
References: <1586931450.ub4c8cq8dj.astroid@bobo.none>
 <20200415225539.GL11469@brightrain.aerifal.cx>
 <87k12gf32r.fsf@mid.deneb.enyo.de>
 <20200416153509.GT11469@brightrain.aerifal.cx>
Date: Thu, 16 Apr 2020 18:42:32 +0200
In-Reply-To: <20200416153509.GT11469@brightrain.aerifal.cx> (Rich Felker's
 message of "Thu, 16 Apr 2020 11:35:09 -0400")
Message-ID: <87sgh3e613.fsf@mid.deneb.enyo.de>
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
Cc: musl@lists.openwall.com, libc-alpha@sourceware.org,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 libc-dev@lists.llvm.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Rich Felker:

> On Thu, Apr 16, 2020 at 06:48:44AM +0200, Florian Weimer wrote:
>> * Rich Felker:
>> 
>> > My preference would be that it work just like the i386 AT_SYSINFO
>> > where you just replace "int $128" with "call *%%gs:16" and the kernel
>> > provides a stub in the vdso that performs either scv or the old
>> > mechanism with the same calling convention.
>> 
>> The i386 mechanism has received some criticism because it provides an
>> effective means to redirect execution flow to anyone who can write to
>> the TCB.  I am not sure if it makes sense to copy it.
>
> Indeed that's a good point. Do you have ideas for making it equally
> efficient without use of a function pointer in the TCB?

We could add a shared non-writable mapping at a 64K offset from the
thread pointer and store the function pointer or the code there.  Then
it would be safe.

However, since this is apparently tied to POWER9 and we already have a
POWER9 multilib, and assuming that we are going to backport the kernel
change, I would tweak the selection criterion for that multilib to
include the new HWCAP2 flag.  If a user runs this glibc on a kernel
which does not have support, they will get set baseline (POWER8)
multilib, which still works.  This way, outside the dynamic loader, no
run-time dispatch is needed at all.  I guess this is not at all the
answer you were looking for. 8-)

If a single binary is needed, I would perhaps follow what Arm did for
-moutline-atomics: lay out the code so that its easy to execute for
the non-POWER9 case, assuming that POWER9 machines will be better at
predicting things than their predecessors.

Or you could also put the function pointer into a RELRO segment.  Then
there's overlap with the __libc_single_threaded discussion, where
people objected to this kind of optimization (although I did not
propose to change the TCB ABI, that would be required for
__libc_single_threaded because it's an external interface).
