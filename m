Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C6C32789
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:13:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82C62086A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFazb3c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82C62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qT2Q3z8czF3Fh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 12:13:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eFazb3c7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::e41; helo=mail-vs1-xe41.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="eFazb3c7";
 dkim-atps=neutral
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com
 [IPv6:2607:f8b0:4864:20::e41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qSr95bsGzF3CH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 12:04:57 +1100 (AEDT)
Received: by mail-vs1-xe41.google.com with SMTP id e7so1912310vsc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 17:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=;
 b=eFazb3c7zMawmEuLNjfsk/It40P/kZA634ojboNSO3So2qlyJ29LyFhO0/QW48NaB8
 kbrri3Yn351FGwvXfSV9Lfr6DEeUttVtBJgkrVmcocs0A5GwSrzSsyI2B3buzW3FuyJ/
 hyabXtsc8ANcHIyckTZ0GHWNuBf8WD4smIyJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=;
 b=WFtoYAmSji2uXM1ziBMtiDGIE3UG9nH7pBLd0WFJKC6ujilYH6xDKsfsQuAeStA1dA
 dbxbhsBMmbzVELFSm9iNv/iECqqTA4qLsPTideVCvLwHYpom86ZFZlmDZXSn52KX/8G3
 nOvUzhMUlHJGjYPZXOdwE55Ym861ZRfoVRvMA4z/maLk/UtFf+u9np8A+wCkv+WsHA5e
 Bpg35JRv4SB+xk2hFNdQ5YcVk/pVaPoYuf5B5Pt6lbzEFCSQQT+SlSioJgfG3eSKDExs
 CnAvf6vU7oe3KZ1Fp3pgK+QM04Fqo3jAhSpkBG4PBoPaAJ5/o7o2tHpDzPAGCdS9er2B
 YtFA==
X-Gm-Message-State: AGRZ1gIgY+yruK2Tt+HJL4Odie8kQtbXCRn1W1CnQP0N5VNi5fyzpoko
 fmsQJg/DnIEM+4hxzKu5H8V9n7TWFEo=
X-Google-Smtp-Source: AJdET5ewLRGdFgtWur20xNX4YlPLsSZNZKun/Jrs9m5ZwZMLyrUxYzZ4g7pwRXesWovbLB+anksWSA==
X-Received: by 2002:a67:46c8:: with SMTP id a69mr12272653vsg.45.1541552694960; 
 Tue, 06 Nov 2018 17:04:54 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com.
 [209.85.222.49])
 by smtp.gmail.com with ESMTPSA id s10sm5701629uao.19.2018.11.06.17.04.54
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Nov 2018 17:04:54 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id n7so5280844uao.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Nov 2018 17:04:54 -0800 (PST)
X-Received: by 2002:a9f:386c:: with SMTP id q41mr3848271uad.27.1541552692505; 
 Tue, 06 Nov 2018 17:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031184050.sd5opni3mznaapkv@holly.lan>
 <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
 <20181103104503.eftn5btx7otgufro@holly.lan>
In-Reply-To: <20181103104503.eftn5btx7otgufro@holly.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Nov 2018 17:04:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XbSm48ttzXvvhTir9ViKA9T7Huiho3CNuzprqAVpHyJg@mail.gmail.com>
Message-ID: <CAD=FV=XbSm48ttzXvvhTir9ViKA9T7Huiho3CNuzprqAVpHyJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
To: Daniel Thompson <daniel.thompson@linaro.org>
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

Hi,

On Sat, Nov 3, 2018 at 3:45 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Oct 31, 2018 at 02:41:14PM -0700, Doug Anderson wrote:
> > > As mentioned in another part of the thread we can also add robustness
> > > by skipping a cpu where csd->flags != 0 (and adding an appropriately
> > > large comment regarding why). Doing the check directly is abusing
> > > internal knowledge that smp.c normally keeps to itself so an accessor
> > > of some kind would be needed.
> >
> > Sure.  I could add smp_async_func_finished() that just looked like:
> >
> > int smp_async_func_finished(call_single_data_t *csd)
> > {
> >   return !(csd->flags & CSD_FLAG_LOCK);
> > }
> >
> > My understanding of all the mutual exclusion / memory barrier concepts
> > employed by smp.c is pretty weak, though.  I'm hoping that it's safe
> > to just access the structure and check the bit directly.
> >
> > ...but do you think adding a generic accessor like this is better than
> > just keeping track of this in kgdb directly?  I could avoid the
> > accessor by adding a "rounding_up" member to "struct
> > debuggerinfo_struct" and doing something like this in roundup:
> >
> >   /* If it didn't round up last time, don't try again */
> >   if (kgdb_info[cpu].rounding_up)
> >     continue
> >
> >   kgdb_info[cpu].rounding_up = true
> >   smp_call_function_single_async(cpu, csd);
> >
> > ...and then in kgdb_nmicallback() I could just add:
> >
> >   kgdb_info[cpu].rounding_up = false
> >
> > In that case we're not adding a generic accessor to smp.c that most
> > people should never use.
>
> Whilst it is very tempting to make a sarcastic reply here ("Of course! What
> kgdb really needs is yet another set of condition variables") I can't
> because I actually agree with the proposal. I don't really want kgdb to
> be too "special" especially when it doesn't need to be.
>
> Only thing to note is that rounding_up will not be manipulated within a
> common spin lock so you might have to invest a bit of thought to make
> sure any races between the master and slave as the slave CPU clears the
> flag are benign.

OK, so I've hopefully got all this thought through and posted v3.
I've put most of my thoughts in the patch descriptions themselves so
let's continue the discussion there.

-Doug
