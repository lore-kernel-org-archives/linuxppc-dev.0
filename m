Return-Path: <SRS0=9U3E=NO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF8AC0044C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 10:47:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF102081D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 10:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHB0y0Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF102081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42nFyR1s2nzF36q
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 21:47:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MHB0y0Ya";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=daniel.thompson@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="MHB0y0Ya"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42nFvf3R2NzDrP4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 21:45:17 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id v24-v6so3992123wmh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Nov 2018 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YmQq90FRkqBQp0/v6HvhwKCbNPsiefsFk4oklN2EcKs=;
 b=MHB0y0YaXByvjwLMoonMq5QIjx9CsU+rAU+j5poaVTafUlBxWYiuUEF8m8kd6fUby4
 QmIDj233bXRVK/YHOYnKiwKvCqqeDu+b+pcNNyGTzoUDVA4Y5GFMOGiovxZt7wz4jmyt
 xJjWXL3cZPHkutGq/DuKCnwo4rBDuc8nFlcaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YmQq90FRkqBQp0/v6HvhwKCbNPsiefsFk4oklN2EcKs=;
 b=lLFYJPyweFJQ+yN0GuctKtkQzwUXg0PGnauIXqAUfmPRQjHr2ZaUyirGsZFhQ8rRfx
 SMeqi1IdYC2awdDxX3rnE2b0I6pst/4yeP67tIZNZf62KKITdGP89F6FxDJaswcaNZr5
 yk0GUbcjFrg3VzC5JvEejPh5O/b0NfMegdz2uoV+khOdjPi8yDtHkts/POD9zxjKp5Nc
 /lhjRhRPstmFv21AaMTTOximu709W7DFh/cgw11exPcqLohvShT5lq5gQ3FWChjfZFAY
 g7DP4dwU5djG2YFjn8h5MRdHC8YreJNjSWFBkTfdZlPleUVlWO8fNmqEBDp3kzDCeoJw
 lUOg==
X-Gm-Message-State: AGRZ1gJc3mrzkdkWI+bEiVOu8y5hFGGdSTJ5cjCjtT72EOBxJ8zZv0xX
 qOxacDjMNPwNm9vcwUk4WP1cJA==
X-Google-Smtp-Source: AJdET5ffk8gt8qQ1YuVWXJvRkvWY6hwLLFRlaE0/rLpCJJIwLmN6I0KvCp4FDHXIC/Svzn3L0Yykkg==
X-Received: by 2002:a1c:2283:: with SMTP id
 i125-v6mr601230wmi.42.1541241914508; 
 Sat, 03 Nov 2018 03:45:14 -0700 (PDT)
Received: from holly.lan (82-132-212-57.dab.02.net. [82.132.212.57])
 by smtp.gmail.com with ESMTPSA id o9-v6sm44092322wra.42.2018.11.03.03.45.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 03 Nov 2018 03:45:13 -0700 (PDT)
Date: Sat, 3 Nov 2018 10:45:03 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181103104503.eftn5btx7otgufro@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031184050.sd5opni3mznaapkv@holly.lan>
 <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org,
 dalias@libc.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, paulus@samba.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org, Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vineet Gupta <vgupta@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 Jason Wessel <jason.wessel@windriver.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 31, 2018 at 02:41:14PM -0700, Doug Anderson wrote:
> > As mentioned in another part of the thread we can also add robustness
> > by skipping a cpu where csd->flags != 0 (and adding an appropriately
> > large comment regarding why). Doing the check directly is abusing
> > internal knowledge that smp.c normally keeps to itself so an accessor
> > of some kind would be needed.
> 
> Sure.  I could add smp_async_func_finished() that just looked like:
> 
> int smp_async_func_finished(call_single_data_t *csd)
> {
>   return !(csd->flags & CSD_FLAG_LOCK);
> }
> 
> My understanding of all the mutual exclusion / memory barrier concepts
> employed by smp.c is pretty weak, though.  I'm hoping that it's safe
> to just access the structure and check the bit directly.
> 
> ...but do you think adding a generic accessor like this is better than
> just keeping track of this in kgdb directly?  I could avoid the
> accessor by adding a "rounding_up" member to "struct
> debuggerinfo_struct" and doing something like this in roundup:
> 
>   /* If it didn't round up last time, don't try again */
>   if (kgdb_info[cpu].rounding_up)
>     continue
> 
>   kgdb_info[cpu].rounding_up = true
>   smp_call_function_single_async(cpu, csd);
> 
> ...and then in kgdb_nmicallback() I could just add:
> 
>   kgdb_info[cpu].rounding_up = false
> 
> In that case we're not adding a generic accessor to smp.c that most
> people should never use.

Whilst it is very tempting to make a sarcastic reply here ("Of course! What
kgdb really needs is yet another set of condition variables") I can't
because I actually agree with the proposal. I don't really want kgdb to
be too "special" especially when it doesn't need to be.

Only thing to note is that rounding_up will not be manipulated within a
common spin lock so you might have to invest a bit of thought to make
sure any races between the master and slave as the slave CPU clears the
flag are benign.


Daniel.
