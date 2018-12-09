Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF55C07E85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 22:36:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3EE20672
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 22:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r00ExyEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3EE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ch024X2WzDqlW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 09:36:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r00ExyEx";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CgxM40ShzDqWt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 09:34:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="r00ExyEx"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43CgxM1n19z8tbv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 09:34:31 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43CgxM1QFvz9s7h; Mon, 10 Dec 2018 09:34:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=alexei.starovoitov@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="r00ExyEx"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43CgxL4L3gz9s7T
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2018 09:34:30 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id s198so4059994pgs.2
 for <linuxppc-dev@ozlabs.org>; Sun, 09 Dec 2018 14:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NNazr7Y/P5261p40ZKG5EhCDX6/JPbb6FMZY7P6SUDU=;
 b=r00ExyExuGcRpwcV0VKl5EgGVHK4lfUcGlnHCrcfh83mV+OsLA7aMrGMWTZy3SxEqZ
 pnSEGk49b5Fo/qDEHTh1KJEWvCYjLwRs0k2lLvPTiD7wzvlEmBhZ9WnI4sRFTW99GGMX
 4HriyQZT/hAigzKFcHm2F7wftfdCwiWke7J61U6atMJLaiXRgsmSOb4BlRLbTYV+M3wv
 66V8A4BcdtQttLjRvimW7XcGuLKs+ldXUHcOWWgxc1obI4jPe7BDVENXwiNCQB0DJAkR
 6V0V4Y3VHPwdidiPL0rCR3TKw447zcJC0arx0X+ieOxgfcjm7LhGzXxmXmmjt3K9hal/
 RWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NNazr7Y/P5261p40ZKG5EhCDX6/JPbb6FMZY7P6SUDU=;
 b=IarZLVZDDzwUSBVdFmEXuEQlgtStHm93s38rtNRq/NBj/UNmzHBYMEfNTSE3qwKWof
 L2PVev6H3tl9varSSbps46EybyVrn5Und5pZo8KQgkxXhPmgF32Es+ny1LkKpVwPjd/f
 MHdFPZnziEX7WMVF0d54sKASSHiA0Z6MUohG/Laupj8oN0ypBeMEDphZ9ULJf6s8GBsI
 U8PyjQosWbacxd6eG9Kj2wQyIMDBwa9wTMCjRTuMsZ2tgibQu1pTJA1x8GpYpZCLrDfi
 dM7OLSy85ZiimwU08Ho3q/khTPBA2byHJYCJdXOArf6bJH50Fo4++eAkIYDPGsJq+gnF
 fKPw==
X-Gm-Message-State: AA+aEWaDwuzseSGUATia8jrKKGDaJA9dY9uDA+r//A7WBjvBzv9NPNld
 YaIdDfY45cSWgNvdudpmyWQ=
X-Google-Smtp-Source: AFSGD/VbVIFCwtvwqjK/qoQbrvh3x7QVlKF9Mzbpyrbub4Y1I4px9rkvhEj9JlUAmXexl/b4naltjA==
X-Received: by 2002:a65:4049:: with SMTP id h9mr8734944pgp.304.1544394868314; 
 Sun, 09 Dec 2018 14:34:28 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:4662])
 by smtp.gmail.com with ESMTPSA id u29sm12752356pgn.23.2018.12.09.14.34.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 14:34:27 -0800 (PST)
Date: Sun, 9 Dec 2018 14:34:25 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH bpf] bpf: powerpc: fix broken uapi for
 BPF_PROG_TYPE_PERF_EVENT
Message-ID: <20181209223424.pvdigrtm4tdbt4h7@ast-mbp.dhcp.thefacebook.com>
References: <20181206092701.4153-1-sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206092701.4153-1-sandipan@linux.ibm.com>
User-Agent: NeoMutt/20180223
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
Cc: daniel@iogearbox.net, ast@kernel.org, linuxppc-dev@ozlabs.org,
 netdev@vger.kernel.org, naveen.n.rao@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 06, 2018 at 02:57:01PM +0530, Sandipan Das wrote:
> Now that there are different variants of pt_regs for userspace and
> kernel, the uapi for the BPF_PROG_TYPE_PERF_EVENT program type must
> be changed by exporting the user_pt_regs structure instead of the
> pt_regs structure that is in-kernel only.
> 
> Fixes: 002af9391bfb ("powerpc: Split user/kernel definitions of struct pt_regs")
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

Thanks! Applied to bpf tree.

