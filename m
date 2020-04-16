Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB1C2D0EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 04:56:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB6620767
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 04:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB6620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492n4N5CptzDrMW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=deneb.enyo.de (client-ip=37.24.231.21; helo=albireo.enyo.de;
 envelope-from=fw@deneb.enyo.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=deneb.enyo.de
X-Greylist: delayed 332 seconds by postgrey-1.36 at bilbo;
 Thu, 16 Apr 2020 14:54:31 AEST
Received: from albireo.enyo.de (albireo.enyo.de [37.24.231.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492n2H6lcVzDr8N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 14:54:30 +1000 (AEST)
Received: from [172.17.203.2] (helo=deneb.enyo.de)
 by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 id 1jOwSC-0000Im-Uu; Thu, 16 Apr 2020 04:48:44 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
 (envelope-from <fw@deneb.enyo.de>)
 id 1jOwSC-000733-RG; Thu, 16 Apr 2020 06:48:44 +0200
From: Florian Weimer <fw@deneb.enyo.de>
To: Rich Felker <dalias@libc.org>
Subject: Re: [musl] Powerpc Linux 'scv' system call ABI proposal take 2
References: <1586931450.ub4c8cq8dj.astroid@bobo.none>
 <20200415225539.GL11469@brightrain.aerifal.cx>
Date: Thu, 16 Apr 2020 06:48:44 +0200
In-Reply-To: <20200415225539.GL11469@brightrain.aerifal.cx> (Rich Felker's
 message of "Wed, 15 Apr 2020 18:55:39 -0400")
Message-ID: <87k12gf32r.fsf@mid.deneb.enyo.de>
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

> My preference would be that it work just like the i386 AT_SYSINFO
> where you just replace "int $128" with "call *%%gs:16" and the kernel
> provides a stub in the vdso that performs either scv or the old
> mechanism with the same calling convention.

The i386 mechanism has received some criticism because it provides an
effective means to redirect execution flow to anyone who can write to
the TCB.  I am not sure if it makes sense to copy it.
