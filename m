Return-Path: <SRS0=pDMz=DZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26086C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 04:07:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683EB21D47
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 04:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFp2OsV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683EB21D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CDRDK5LHHzDqp5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2020 15:07:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=sandipan.osd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=dFp2OsV6; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CDR7F08YszDql2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2020 15:02:48 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id p21so3494260pju.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=C+aijD2XhOVm310wYhkSxTnzHtu0eEUfvk+BZoL498Y=;
 b=dFp2OsV6zSWdep3HHCgBnCe62gnpY6dMwhYeRHKsU7BrD1qqJX1+ztiOvGsEg8fD0r
 EDjJvLSn+Tz1D0fEYljkbVXxGQQ87wCm8XNrV298LlyGkbUEuFDgaw8p1IIUTXcxE217
 vS1IaxqYteLAzyM6usV8/oeITWnlxjAWGICBOYgHSoxGM+jujVc+3qaFaD4ZI5n+TTRC
 H2p16KlnD7uYpcXYXvoXk3faVw6aMDZ1oDJvzJfFmvZUFdsAxPL7EtPxY7dTFgRgiQx2
 zlq+PhMhhRGXH9sEhYx49hEPWuKbI3ybAJMXusxSlgdwiW100xikTkXtOljAp/26VDmc
 1suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C+aijD2XhOVm310wYhkSxTnzHtu0eEUfvk+BZoL498Y=;
 b=Y/+GVr+S9nMRDMSjUGiB8UN2HA2TbX1mNLEgitW9ewGZJLO2lZnGKZqAraech0xkVY
 0iQPHqLQvOBUj8ptK/t61/lfJh/sPxWfeAmmLGdgLTD39Thoor3BNfpJkoO1eAkxJNWY
 t4sEVct5Q/3SW3P2IEoPa17omOtpLrMGTh6XUnAUdEsJmr/wWhJJb1PM/DEy3Isi1q4b
 abQu3UoUXaJ30P66f0F4T5kxUBBVmtDAEKqASX/OJjK9X4wwYFEUyrAy2XF9VclcbhvR
 JNn/Vb6QQyn8yW5Q6HQjz2s3moxCPucaH7Mxe8yMyjY2oGjJ9B5GlhsqukVwl3kRr30q
 yFUw==
X-Gm-Message-State: AOAM533qw+J0IGcD9rc624qhvDNSd/6s1VoDxOyWZUMJiROdU2wJAEp8
 ksX8B5dZ0asdMe/Z0z/rVlMim3hFN+g=
X-Google-Smtp-Source: ABdhPJyzAPazF8/gszHJCJPRmFp43GAJA+uYe3WL+q3RCoqVU0F5EA9VeQHfWEclgqoCoCJDerT5+Q==
X-Received: by 2002:a17:90a:4b4e:: with SMTP id
 o14mr12141677pjl.216.1602993766864; 
 Sat, 17 Oct 2020 21:02:46 -0700 (PDT)
Received: from [192.168.0.102] ([49.207.205.150])
 by smtp.gmail.com with ESMTPSA id e21sm7064495pgi.91.2020.10.17.21.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 21:02:46 -0700 (PDT)
Subject: Re: [PATCH v5 20/23] powerpc/book3s64/hash/kuap: Enable kuap on hash
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20200827040931.297759-1-aneesh.kumar@linux.ibm.com>
 <20200827040931.297759-21-aneesh.kumar@linux.ibm.com>
From: Sandipan Das <sandipan.osd@gmail.com>
Message-ID: <a2011341-8da0-207e-d035-844610c67d75@gmail.com>
Date: Sun, 18 Oct 2020 09:32:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827040931.297759-21-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 27/08/20 9:39 am, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/mm/book3s64/pkeys.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Sandipan Das <sandipan@linux.ibm.com>
