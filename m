Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD05C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 19:07:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAB820657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 19:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAB820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ldB05nP3zF3LJ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 06:07:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ld7v42D4zF3KJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 06:05:15 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id z2-v6so18445376qts.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 12:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Zay1dDah+Wo1IYhAg+QvBwYX588XVNGuiadaf6M7fU=;
 b=be/yguktibNpGFbp01Hy88XpRx7wyOEC3ZZPbKeeEm8ar/IcbnuK2W7s5pZmlOQtjn
 kNtxxhgBxNZjXJypX7DPfUvPryI9DlhwZcz+97gYNk4XovWsxKQ9rVPCUUyLqsGE4aMP
 5oe3W071bUmVRWoKmZreAYI6nS14B6nKUbJe8P2bgc97cQy959uoxfRej3A56CHeulYK
 +EE5YUtyNDkD44gTSnSFi7Jwi8/AbSQmBnMrp+nz2iM2R5UlrQ7NDNhEgfXp79DkzBqt
 K+3gW79Lf8W4qdWFYkmTs7YfbOKmNlKTy1MGdC/bvzlw3CkzBLQfpdpiAIuaXAsJOnV+
 zYOg==
X-Gm-Message-State: AGRZ1gKGQd6ODkhCFkxbEW1pJxhzKrQV6lpoRZxyLMh3cG959/ZryDR6
 pVYTybwHySDrX7i5dYMudNX6Rlat
X-Google-Smtp-Source: AJdET5cbqdWEdnFxvqJeQ5EHIZczqw/DRpgX55bxQ5Wfj4teCbNRnHx0TXA39O3ZMilVaw+QwukfZA==
X-Received: by 2002:aed:2ac7:: with SMTP id
 t65-v6mr2246542qtd.19.1541012713101; 
 Wed, 31 Oct 2018 12:05:13 -0700 (PDT)
Received: from [10.0.0.11] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id m46-v6sm22572178qtc.93.2018.10.31.12.05.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Oct 2018 12:05:12 -0700 (PDT)
Subject: Re: [PATCH] selftests/powerpc: Fix compilation issue due to asm label
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20181031171813.8970-1-naveen.n.rao@linux.vnet.ibm.com>
 <1541006651.phri6idrd6.naveen@linux.ibm.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <908fdc11-3341-e3d0-c823-da7120549c85@debian.org>
Date: Wed, 31 Oct 2018 16:05:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541006651.phri6idrd6.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Naveen,

On 10/31/18 2:24 PM, Naveen N. Rao wrote:
> Naveen N. Rao wrote:
>> We are using 'dscr_insn' as a label in inline asm to identify if a
>> SIGILL was generated by the mtspr instruction at that point. However,
>> with inline assembly, the compiler is still free to duplicate the asm
>> statement for optimization purposes, which results in the label being
>> defined twice with the error:
>>     /tmp/ccerQCql.s:874: Error: symbol `dscr_insn' is already defined
>>
>> With different compiler versions, we may also see:
>>     /tmp/ccJzLDlN.o:(.toc+0x0): undefined reference to `dscr_insn'
>>
>> Remove the use of the label in the inline assembly. Instead, just look
>> for the offending instruction in the signal handler.

Cool, I've tested this patch on my mainline tree and selftests are being
able to build again. I also tested the rfi_flush_test selftest as other
tests (ptrace/ and tm/) and everything seems to be normal again.

Thank you!

>> Reported-by: Breno Leitao <leitao@debian.org>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Tested-by: Breno Leitao <leitao@debian.org>


