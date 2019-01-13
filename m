Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06EFC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 12:36:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18465206B7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sToe6NVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18465206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cx0n39pSzDqXQ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 23:36:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sToe6NVO"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cwyM2lT7zDqX6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 23:34:03 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id w4so8889517plz.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 04:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vkY6g5Vqw/ZcPB3+ASMRoGn4tKrtMQnoGHCgEri+h4c=;
 b=sToe6NVOVkEom92efLv70SEU3rada5B2vsTWOSDUDI5zIPuhy+TyYWwbw/QeR7iK8p
 JH1OMPXX+8xzNEHKc/FbZ8Vt8fGYSX0ikWz9rsOCTF7jiqV8NsDzolK9LtTxSGx0BiSD
 kRX+h2ecEb2zS++ct7GSBZ54MCFLGuO14LnFSVTlt6FyTqGVBAkaXoPSu6yL23tluq+A
 uCHqKKy8yggrNWTArhtIjBiKsn3FSvsnQcBppJahmNkOSXO8/icjgQjAsoG8uyLNyt0u
 d+0uqQfEVJIeQ4tbUnOi2Yyk2FfNoZ22BKSb7+982GNPiLnKTCinugbLcP2eoDOtjuAB
 1q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vkY6g5Vqw/ZcPB3+ASMRoGn4tKrtMQnoGHCgEri+h4c=;
 b=NAtfqFW30Sd4LZbFez6dhTEDiWhW6OnGATPbaf1gzA5506j9Ekkqfd6s0BU7/67UbO
 jfoR75PCzNRLr4WXeOjzJDF9SSwD8r4W8A2vOfbRlfsYV6ghrPM3Lzq5NJwKlWpQOQjP
 Xjc9UPM2pTSZFap2eRf2ddoISWREs8bXxUBA5Q0vNDmW1nMtCJoFsb/FzuvylgiNPc0J
 Y4dpQ76I17FhPKxBGHMa7SyxM4TFlOPJn6SqXHyegxvXGUsFPj+yP/rmoSNj9ntemhB/
 /nyvm0Bio2t5IGJ5nZ4FAaMtMpkLaW+dEiOxugYTJdLXvTmbTwaVIFmv1+3WjWYsdNoN
 XzRw==
X-Gm-Message-State: AJcUukcOFh8+2uJOnF3rtK0kyMdGkNh+c5RbfNhzut8w6q6bXPLAX2oX
 zlzSxY/e1f+hZKaTtLBy7P0=
X-Google-Smtp-Source: ALg8bN4dB+C4g9JtLNHp7SyR95TpouuAZTp6SiLy1woSWmhuEb4R+8Lg6NDJC27Mbg+ReF4SMETS/A==
X-Received: by 2002:a17:902:690c:: with SMTP id
 j12mr21488290plk.206.1547382840505; 
 Sun, 13 Jan 2019 04:34:00 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 r4sm165801214pgn.54.2019.01.13.04.33.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Jan 2019 04:33:59 -0800 (PST)
Date: Sun, 13 Jan 2019 23:33:56 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190113123356.GA26056@350D>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <20190112010914.GB10427@350D>
 <20190112084541.GK14180@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112084541.GK14180@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Torsten Duwe <duwe@lst.de>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 12, 2019 at 02:45:41AM -0600, Segher Boessenkool wrote:
> On Sat, Jan 12, 2019 at 12:09:14PM +1100, Balbir Singh wrote:
> > Could you please define interesting frame on top a bit more? Usually
> > the topmost return address is in LR
> 
> There is no reliable way (other than DWARF unwind info) to find out where
> the value of LR at function entry currently lives (if anywhere). It may or
> may not be still available in LR, it may or may not be saved to the return
> stack slot.  It can also live in some GPR, or in some other stack slot.
> 
> (The same is true for all other registers).
> 
> The only thing the ABI guarantees you is that you can find all stack frames
> via the back chain.  If you want more you can use some heuristics and do
> some heroics (like GDB does), but this is not fully reliable.  Using DWARF
> unwind info is, but that requires big tables.
>

Thanks, so are you suggesting that a reliable stack is not possible on
ppc64le? Even with the restricted scope of the kernel?

Balbir Singh.
 
