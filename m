Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F23C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 03:00:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF31206C3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 03:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="hbBdgWq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF31206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bcHL08XhzDqFw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 13:00:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bcBr5JvjzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 12:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=hbBdgWq/; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49bcBn3GWMz9sSg;
 Tue,  2 Jun 2020 12:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1591066611;
 bh=YCwgkBAIWR9lwcZTT3gJGRHrETSDKFKv9oHQKKerD1g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hbBdgWq/e1Emt3gRHmqD91+k4UdRYjXCpeFqENlHwoArQaV+KU7uWGLPbrf5+6Trr
 Fqj/ynRGm/Lfi0OnBPtSJmw41FmwJq9Imu80idpvhtdRhtX7lStU/LJAP5M5khPQm+
 8+MwVX42mFeaetY8yuod+gPeLHl9z0gsE04oJor+DF3BIskjXraOCLxzzxpLOfLNPz
 gK6Rxx4IzvN8CZnX4iVw2uflA+suvEVTUjyGExPXzSPZ5/WPxVL7RMquIsh75zaXsl
 CoF+zwYUD2yso3mE3N7oW9Yb61Shiw7rcqu1KRC4WQfh4f7qyw5k4uPG1PNvvl3tzt
 jmTVNMdNqKBag==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Markus Elfring <Markus.Elfring@web.de>,
 Liao Pingfang <liao.pingfang@zte.com.cn>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error
 message
In-Reply-To: <c3d22d89-9133-30aa-8270-c515df214963@web.de>
References: <c3d22d89-9133-30aa-8270-c515df214963@web.de>
Date: Tue, 02 Jun 2020 12:57:11 +1000
Message-ID: <87imgai394.fsf@mpe.ellerman.id.au>
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Tony Luck <tony.luck@intel.com>,
 Kees Cook <keescook@chromium.org>, Wang Liang <wang.liang82@zte.com.cn>,
 Anton Vorontsov <anton@enomsg.org>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>,
 Paul Mackerras <paulus@samba.org>, Xue Zhihong <xue.zhihong@zte.com.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Markus Elfring <Markus.Elfring@web.de> writes:
>> Please just remove the message instead, it's a tiny allocation that's
>> unlikely to ever fail, and the caller will print an error anyway.
>
> How do you think about to take another look at a previous update suggestion
> like the following?
>
> powerpc/nvram: Delete three error messages for a failed memory allocation
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> https://lore.kernel.org/linuxppc-dev/00845261-8528-d011-d3b8-e9355a231d3a@users.sourceforge.net/
> https://lore.kernel.org/patchwork/patch/752720/
> https://lkml.org/lkml/2017/1/19/537

That deleted the messages from nvram_scan_partitions(), but neither of
the callers of nvram_scan_paritions() check its return value or print
anything if it fails. So removing those messages would make those
failures silent which is not what we want.

cheers
