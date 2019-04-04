Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5074C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:19:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE3C206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 12:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="bN5wfQWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE3C206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zhpb18V8zDqMs
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 23:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="bN5wfQWJ"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZhmQ2GYpzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 23:17:56 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id a71so1457828qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mJ9lyu9lgje97o92Z/sLGDTR3ug4FpzQgmmTePE7M2M=;
 b=bN5wfQWJwWYhwVaiLOffEZC/Trcwg05e6QaxWtvDTZ7a0tHjRBHRxZB9rnbZ8q6VSU
 TlkVw5rYHr/iiUw1U3wtYwbcxku9H9+J3UcEwDi83TtsiPiD2WFDezR3PX8Jl+KHCxlZ
 viCT14mz9QFmq80u1JAlJ+i6F38UE1Ge7tH3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mJ9lyu9lgje97o92Z/sLGDTR3ug4FpzQgmmTePE7M2M=;
 b=cBKsO2bqM6uTqzs52P8rzW7Iq1fmYyXtwmvEeo9YZo+8ADACuonP9jxOF/AtFHpXnr
 EkjE+DryECkmSl4bdAbvBTcEzVihxP2heQn+cmbFTsT3XrrKeCJQ8RPLGvGXOhd8zFOq
 CMvmlaURBeD+yHVnfTXDiB/nJ42xFOuu7cDKHx9e28LRDQFMo/nYKnVuoXHqepBCIlvq
 ESMaaZVbC6Uxveh/vkzTibZdDY8Ajq4moPR1EdOjBZIwICrweujonN5DszCJGV1rwaYG
 NcPXmvNC6lA0dyiL9v5r1L5eO/hExdoL0OKnmjlJ0AIXM4tdORe2CyhEtWTiQPcNhkOz
 gkng==
X-Gm-Message-State: APjAAAW78QYDnt7evax6zSO2qoQbJuwj7aLs0RjDDOdtfyhfWdIvdeQw
 1p2zlgoElflwLDB5r9gqipZG4Bu/LD+z5bCt7MY=
X-Google-Smtp-Source: APXvYqySRDvX0dIEGt55Sb+eYa0+NlPRvEpqafI8y23L+fPVZ10v6zgjtgW5Qd7t0ixA4xS7CaTSsZQpE2hYJys9pTs=
X-Received: by 2002:a37:9fc6:: with SMTP id i189mr4931623qke.246.1554380272617; 
 Thu, 04 Apr 2019 05:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190329064453.12761-1-joel@jms.id.au>
 <20190329095318.GJ3969@gate.crashing.org>
In-Reply-To: <20190329095318.GJ3969@gate.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 4 Apr 2019 12:17:40 +0000
Message-ID: <CACPK8Xes6+j+bjCbqwBLJpvP-Hi_WzbtEwfUSzJjeAW9jwFRKA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/vmlinux.lds: Drop binutils < 2.18 workarounds
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 29 Mar 2019 at 09:53, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Fri, Mar 29, 2019 at 05:14:53PM +1030, Joel Stanley wrote:
> > -     NOTES :kernel :notes
> > +     NOTES
>
> I think this still need to be
>
>         NOTES :kernel
>
> or the linker will complain.  Did you try to build ppc64_defconfig?

Yeah, I did build (and boot, in qemu) the ppc64_defconfig. I tried
leaving in/removing the :kernel annotation in a bunch of places and as
long as I had it in the first spot, the kernel linked.

Shall I respin with this added?

> (And I do not know if there are any tools that expect the notes in a phdr,
> or even specifically the second phdr).
>
>
> Segher
