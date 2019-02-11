Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C1C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:57:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A2420844
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2G2u39h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A2420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ydRf3KyczDqQw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 18:57:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ydPb5yZ8zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 18:55:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N2G2u39h"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43ydPb2m82z8v8Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 18:55:31 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43ydPb2SkDz9sMr; Mon, 11 Feb 2019 18:55:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=sergey.senozhatsky.work@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N2G2u39h"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43ydPZ4Cpkz9sML
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2019 18:55:30 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id m1so4601755pgq.8
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2019 23:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ygAEYs2cUK0TFmtHBpTd5q1OXKnqXfmKH4w1qi/rkyE=;
 b=N2G2u39hE7742HJ34qPv5zld3vE71j66atBmbESmuD7la48FpTSssaywppnOm5KUu4
 Ylr+laAskz9xKmLsh3EPfmVfjTP7kOdiA7r+01vRcxQGNWZPXMXmWqOLtRd4SEa0H0V2
 bOMTxVNwj/Qai5hZNZvVmdhu6Vgdz7xJ1ay3qKzuONaDiSUfkAWufnv3Sw+GGiYB7SHJ
 kSSBUgGO18OTpuHilZp1I5/+aDCHVTb1lX+gy07NjAsZb9OfRgi9s5GNPPYbZTaP5sYI
 OZtRGePYFQF+Ry/87MyrWPjMHWkdRv8AyoLQwFQge/RTYsdfFXQRQ39ThUjDvEm9PjgM
 0y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ygAEYs2cUK0TFmtHBpTd5q1OXKnqXfmKH4w1qi/rkyE=;
 b=AFRr4CJ8Ems+O8FU3y35hnVnQVKD1KXmJwo/28q7VL1g9juJ4xIRCrHY9zRLQ77y5w
 Y60ydCTBjWXYwBRrHKuerywVFrKdrTmwnhkYtQi8EyS5EGPHiW7zHb6zqxao52V6TsNS
 uI6lRN+pfqIXIyZEgLyEa/oCbhVXsiT7rR9OrN3VDyezvRYxRmjv2XPg2n/gyrvs2gMU
 p6OgzQJyIpHRH2lmQJTdTSZaCc1z1jz2hpRXF3Mug1gHVjkWZ5vul500A80/oaDVjXzW
 1ZZJKFw8o7Yeerlxlvqzbg71Sq3vWsECxqpLCKXCoHFPs/TNWA4lOInL1AvekP//4+ow
 MgDw==
X-Gm-Message-State: AHQUAuYXsNZch35IBtEqFIXwwNwo/tq6h4cDYBsvzltBNwmmR6VSBEP+
 6/sDGgrDteCzBJdUMPwTgRk=
X-Google-Smtp-Source: AHgI3IYwJrTZAnuaPYyDWZ08ETuWFKbUPQzGipOaxRvNkL74WbdP2DA2ucnKRH6VIK5oE9Ofh/9nyg==
X-Received: by 2002:a63:da18:: with SMTP id c24mr16494423pgh.318.1549871728594; 
 Sun, 10 Feb 2019 23:55:28 -0800 (PST)
Received: from localhost ([175.223.48.87])
 by smtp.gmail.com with ESMTPSA id y72sm14624151pfa.98.2019.02.10.23.55.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 23:55:27 -0800 (PST)
Date: Mon, 11 Feb 2019 16:55:24 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190211075524.GA26690@jagdpanzerIV>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190208185515.r6vkrezbd3odhpxt@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208185515.r6vkrezbd3odhpxt@home.goodmis.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linux-arch@vger.kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tj@kernel.org,
 akpm@linux-foundation.org, dyoung@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On (02/08/19 13:55), Steven Rostedt wrote:
[..]
> > +	if (len) {
> > +		/*
> > +		 * Order the stores above in vsnprintf() vs the store of the
> > +		 * space below which joins the two strings. Note this doesn't
> > +		 * make the code truly race free because there is no barrier on
> > +		 * the read side. ie. Another CPU might load the uninitialised
> > +		 * tail of the buffer first and then the space below (rather
> > +		 * than the NULL that was there previously), and so print the
> > +		 * uninitialised tail. But the whole string lives in BSS so in
> > +		 * practice it should just see NULLs.
> > +		 */
> > +		smp_wmb();
> 
> This shows me that this can be called at a time when more than one CPU is
> active. What happens if we have two CPUs calling dump_stack_add_arch_desc() at
> the same time? Can't that corrupt the dump_stack_arch_desc_str?

Can overwrite part of it, I guess (but it seems that Michael
is OK with this). The string is still NULL terminated.

The worst case scenario I can think of is not the one when
two CPUs call dump_stack_add_arch_desc(), but when CPUA calls
dump_stack_add_arch_desc() to append some data and at the
same time CPUB calls dump_stack_set_arch_desc() and simply
overwrites dump_stack_arch_desc_str. Not sure if this is
critical (or possible).

	-ss
