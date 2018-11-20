Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1652C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 21:31:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7BB20C01
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 21:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ppsPzzKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7BB20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zzR75sV8zF3Nw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 08:31:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ppsPzzKV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="ppsPzzKV"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zzNJ1rXgzF3Ng
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 08:28:47 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id u6so2151951plm.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 13:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jJtY5JPbAncBdwXDSajCFlPE6/tq+bH0KVJy/kUKyas=;
 b=ppsPzzKVRwHyJ1R4w2Nd6XSqyunRzCFtFIQWyZu0j+OjBeu6NnZcGI4QQMNmcABeFW
 hmgtdqeEVOfo/9nUl/ZyyCMslC3mMCrFBRTRVm37s3SF/izZpJ0e7Gmc9nNfTm9d6SiM
 /ajsFHsrj5IenPKsmA3xw6/6DzCfFO19GSYuHmx0TGOwR16JlQM9eEzMxlEpIs7Znt6Z
 YuRJxHtyUX38JHpQNJt/GGJ3KCHf5o1N9+Hv/7V+24W6/Qq/aVvhCpVF/1/C+1400vj9
 an1qpbfLiZfdYQAWHvi3QHwyDh02VkhRuNkJBfbbdg0TeZXdUmNJntWlzjn2OJfNqjGo
 69XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jJtY5JPbAncBdwXDSajCFlPE6/tq+bH0KVJy/kUKyas=;
 b=HQmrjbAo3DvhBLTCHBgltCOHvfWW8f2hc10O6Lq12BmKG2OHLPUiTAiu6FZnA1u+04
 /tlP3pKE+s1tOxPe+cCScYgjUWxUWvCfXue94c91IJyrpuFgkusfIonFeqjRSa5/Wux8
 DD7k5pZ8wSLBw9RihaxzH8QDO7LKfUWFp4ltW4OyX/JSB1GFytEJ4sxhq255JmgqJBaN
 oc3yl7114Y1ASrTBQG0uDdGkYbvv7bAUTb45b/q1Hgw5+/I1eNWNBi222k5xMlxPT4+s
 riK+MjyXyEDMMyEzpiEsfXwD3HnCa1GbIBQzPrlygMAs7N7QLy0FsofA3iweigWMhGBx
 SNmQ==
X-Gm-Message-State: AGRZ1gKK4pn9GrIb+UKP3EjAJOjlMt7d08F//THbQfdFEC1AQKOm5mVN
 yjExT0fWAF4gMG2xdk3sJOIS1LkImcRABd5Rdde7TA==
X-Google-Smtp-Source: AFSGD/W3NfVehzlF9WvgO2jvf61idE56154TzUvFVGVXSH/QqhW5koa9L+ECKlT3MIhSLPU5oyEpEZTXwY+hlHqYTz8=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr3418977pga.202.1542749325067; 
 Tue, 20 Nov 2018 13:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20181114024412.19368-1-joel@jms.id.au>
 <CAKwvOd=P6eQsysnhYVjekbKzVMiGZH8K2nO=Y2gNaH6j+yAhSQ@mail.gmail.com>
 <CACPK8XcdMgrnUQsHH4-fHX2Cw7=zXPBhsDJUNGQJ1=hjh0P4CQ@mail.gmail.com>
 <20181120182029.GA23873@gate.crashing.org>
 <CAKwvOdmbkZCQzFCDQUMdM-_Ds4zFDZRtr=ZbsHzVzKoEg55K7w@mail.gmail.com>
 <20181120201511.GC23873@gate.crashing.org>
In-Reply-To: <20181120201511.GC23873@gate.crashing.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 20 Nov 2018 13:28:33 -0800
Message-ID: <CAKwvOdkHBpMfyrJkwZ1s6m18Ewrfe8K0VPztq1gDWP2ux97PGA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/math-emu: Update macros from gmp-6.1.2
To: segher@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev@lists.ozlabs.org, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 20, 2018 at 12:15 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Nov 20, 2018 at 10:45:19AM -0800, Nick Desaulniers wrote:
> > On Tue, Nov 20, 2018 at 10:20 AM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > > Segher, which tree contains the One True Upstream for longlong.h?
> > >
> > > You should probably get your updates from the same place as was used to
> > > get the file in the first place.
> >
> > So sounds like GMP is the source to take then.
>
> I'm pretty sure the kernel got it from GCC.
> How much does the kernel
> one differ from current GCC?

Compare udiv_qrnnd implementations from:
gcc: https://github.com/gcc-mirror/gcc/blob/f7289f563a5e447ac21a5901ed75aad0dbd37732/include/longlong.h#L1679
gmp: https://gmplib.org/repo/gmp/file/tip/longlong.h#l2063

The kernel currently is using the GCC impl, which Joel's patch here
changes it to the GMP impl.

If you prefer the kernel to keep the kernel keep the GCC derivative,
then Joel can drop the change to udiv_qrnnd() as it does not contain
inline assembly relevant to the original issue.
-- 
Thanks,
~Nick Desaulniers
