Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C8C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:50:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0167620835
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99jRDws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0167620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q4qB0bs1zDqjk
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:49:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l99jRDws";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="l99jRDws"; 
 dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q4jG20dfzF3Fc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:44:50 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id q17-v6so2878866plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vg7SRoj7yAJ2vTnwB8FUNMQs7vEPUrfNYQlTrmGRmw4=;
 b=l99jRDwsP8sCeqQ+NMUg4SWvQPNxLBzJov/0NT38yGnuwGNiI1E3WqEH0LvvP4sSTO
 pUWG7pdGpLvtZKMBSzAK7VAiHipviusz0FpC34Kr0zwNlYZAqAAf+xO8az9RbQYKBL7n
 hAKeIth+cZlVJihKMubHnKEVWnhNWdirXkqUKCOWnp3bMJi4xSAQzHMbOCzBDPeo+cB3
 Gmaw9DlHstfLGk0oILZSX7W2W3wStllG+Mc8kVf2ORq7Gs2g3695T7nvcNhYjIkvtxxO
 kv9p1gKpBkaB62SYUcJx7NYurQRjwk6Zyog8dZhY3B8eL7tI7I75oaLo35HrNNzBZ1NK
 mI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vg7SRoj7yAJ2vTnwB8FUNMQs7vEPUrfNYQlTrmGRmw4=;
 b=Ae4eoGDgG954Xhfdj1qYyMMHtpbSLU8AcVOT+KbIl3PX1mXUlYV51J/luUZKZyDCoz
 SYRKVG3aEBYsHjBbTVaxfXvqVjz0z7oJIHjMRqdR+8D3GWiJhBKpfPKYHJx7O2aQNT0L
 7dKXX6zB+WztGrSonmtNIdH6eZLqcSRHskRWN24seDnHAwEZoo7EDMOofGVBjVXKuqXM
 i+9jjXYiramB44hpgYAxIIP71bTpLjfE1ddUEL6y6rDwkOPy4RzyUjbyidQhDyNqbg2c
 oROnFwzPwfDfHW1cnq8Rv+yKdJvVOVwrQkKVoL5jAbC8WMXLKJiebmy8f8B1VR5+PKg6
 RbMw==
X-Gm-Message-State: ABuFfog5WDdvaky4wpkkxT7+/920HbmODFiBvVzz3psJRr9v/0C0k94a
 rIn3nJSNT7Dr6JFMpBPLS+ihrFSF
X-Google-Smtp-Source: ACcGV63+eL+VExziZd2iNuKdeuPPcAeG1JdhUv62hrGrtsz8H8P/j6Qp24FzpQB9uzzmGaC2pXOXUA==
X-Received: by 2002:a17:902:7283:: with SMTP id
 d3-v6mr19734670pll.326.1538545488370; 
 Tue, 02 Oct 2018 22:44:48 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id s78-v6sm1300508pfd.138.2018.10.02.22.44.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 22:44:47 -0700 (PDT)
Date: Wed, 3 Oct 2018 15:44:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 7/7] powerpc/64: Modify CURRENT_THREAD_INFO()
Message-ID: <20181003154442.5d77ad9c@roar.ozlabs.ibm.com>
In-Reply-To: <e218eef4c27f7cf00c41914ba977b29edba943ff.1538396659.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <e218eef4c27f7cf00c41914ba977b29edba943ff.1538396659.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  1 Oct 2018 12:30:31 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> CURRENT_THREAD_INFO() now uses the PACA to retrieve 'current' pointer,
> it doesn't use 'sp' anymore.

Can you remove this too now? I think it will be clearer what's going on
and easier to read once everyone remembers current is the same offset as
current thread_info.

Overall nice series, thanks for doing this.

Thanks,
Nick
