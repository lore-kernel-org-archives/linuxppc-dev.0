Return-Path: <SRS0=Luu/=QX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E183C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 19:24:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B6D2192D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 19:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B6D2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4420SN1nwgzDqW3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 06:24:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4420Qm734SzDqTP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 06:23:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ee
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4420Qm5nS2z8swG
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 06:23:12 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4420Qm5Nrfz9sD4; Sun, 17 Feb 2019 06:23:12 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=none (mailfrom) smtp.mailfrom=linux.ee
 (client-ip=193.40.6.72; helo=mx2.cyber.ee; envelope-from=mroos@linux.ee;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ee
X-Greylist: delayed 445 seconds by postgrey-1.36 at bilbo;
 Sun, 17 Feb 2019 06:23:11 AEDT
Received: from mx2.cyber.ee (mx2.cyber.ee [193.40.6.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4420Ql6rG9z9s5c
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2019 06:23:11 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190215061400.20302-1-mpe@ellerman.id.au>
From: Meelis Roos <mroos@linux.ee>
Message-ID: <0ef0b01c-e5e0-5295-3ccd-ff539dc82681@linux.ee>
Date: Sat, 16 Feb 2019 21:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190215061400.20302-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
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
Cc: malat@debian.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> Rather than relying on that we can pass an explict end_pos based on
> the sizeof(vrsave). The result should be exactly the same but it's
> more obviously not over-reading/writing the stack and it avoids the
> compiler warning.

It works on my PowerMac G4 with Debian-ports unstable with gcc 8.

-- 
Meelis Roos
