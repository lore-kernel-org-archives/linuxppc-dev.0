Return-Path: <SRS0=uftn=2G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2376CC43603
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 06:48:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716E620717
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 06:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axvd/GuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716E620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47bsL035WjzDqTk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 17:48:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.120;
 helo=us-smtp-1.mimecast.com; envelope-from=bhsharma@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.b="axvd/GuM"; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47bsHr5vJtzDqTZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2019 17:46:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576478788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPUbX9Jz4xx+ZUII2dhvvUhvv4VHD3gib9TjJw4FvFo=;
 b=axvd/GuMCMCsTs+CMigP/dZ5im6iSKbMZASuAT33LNq6UiMoLwqAXtc6WMgvVGlxe4ktns
 1no5hUBHbNV/FC9qBK4j/cyMrB+XvnUHoVfzqSZgdeZVyNf84Us07YSRNE4Y1/1ijxIfrA
 ifQe2KwFh8pnpgyiv2vqa5Td0DuW/U4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-5F8lQ5REMwKIN7kSv5gmTQ-1; Mon, 16 Dec 2019 01:46:26 -0500
Received: by mail-lj1-f197.google.com with SMTP id r14so1770741ljc.18
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 22:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uPUbX9Jz4xx+ZUII2dhvvUhvv4VHD3gib9TjJw4FvFo=;
 b=TZUr+JgCH67PuqwuPvgvN05dMB6N5dnLp6z0QWWUMd3KiYvdBnoGmGJuZWpAmL43Lv
 3KNSDdPihCnaenMQBrFrTF+8Qv3PFSi9kJVDuUUnHVGRM6G7MdVt45nj7HRlD3xIgiaz
 /5fbKEczRNqSUtpbysfEEvzkkxIplf7dYWzqZ/e/jCRu8wcgHXhIni3Pd5cqDv/Zl8hk
 vRKVfgIPG05ySCS9uzpdUxm+UShyYFtZohq0BCb2eKE7Pgyc2GxVKCRJZljp+dXCOpDa
 RQrmXVuF263KhFBfQRAg8XZof2gCBIRCCjlarGYQZvNUwb3lATgG+y8PqutnIJzs0/E/
 NugA==
X-Gm-Message-State: APjAAAV/z8NQww8yoqFcJNSFE8JtuDtfbJXkGYqZVgwkbdpsVllS0wnH
 F5iPF3kMJnjXh10A73msXxdbusveG3nrK3uXLwbB/+Yn7jgzEpb0BWSNCl289PRyQe+OULb/PY5
 GwIJnGYUd1n+mnpefw1+coTYZGa3mTWSRKtkihEsG1w==
X-Received: by 2002:a19:f619:: with SMTP id x25mr15220135lfe.146.1576478784854; 
 Sun, 15 Dec 2019 22:46:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYIqap6RvvS/V3qRxs6d85Vgoutpx8l9xgfgCmVn0EpC3k91P2m6SYYYdmxGiRTrSSf+TXl7Fnv3bF7BQRunc=
X-Received: by 2002:a19:f619:: with SMTP id x25mr15220124lfe.146.1576478784677; 
 Sun, 15 Dec 2019 22:46:24 -0800 (PST)
MIME-Version: 1.0
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
 <20191214122734.GC28635@zn.tnic>
In-Reply-To: <20191214122734.GC28635@zn.tnic>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 16 Dec 2019 12:16:12 +0530
Message-ID: <CACi5LpP2PPcmaQw95V4MUzhvENq9+mB7UR7eib2HADCDHLz4oA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To: Borislav Petkov <bp@alien8.de>
X-MC-Unique: 5F8lQ5REMwKIN7kSv5gmTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Dave Anderson <anderson@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Will Deacon <will@kernel.org>, x86@kernel.org,
 kexec mailing list <kexec@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kazuhito Hagio <k-hagio@ab.jp.nec.com>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Steve Capper <steve.capper@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Boris,

On Sat, Dec 14, 2019 at 5:57 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> > Bhupesh Sharma (5):
> >   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
> >   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
> >   Documentation/arm64: Fix a simple typo in memory.rst
> >   Documentation/vmcoreinfo: Add documentation for 'MAX_PHYSMEM_BITS'
> >   Documentation/vmcoreinfo: Add documentation for 'TCR_EL1.T1SZ'
>
> why are those last two separate patches and not part of the patches
> which export the respective variable/define?

I remember there was a suggestion during the review of an earlier
version to keep them as a separate patch(es) so that the documentation
text is easier to review, but I have no strong preference towards the
same.

I can merge the documentation patches with the respective patches
(which export the variables/defines to vmcoreinfo) in v6, unless other
maintainers have an objections towards the same.

Thanks,
Bhupesh

