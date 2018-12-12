Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC99C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 03:07:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557BB20839
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 03:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pSBgd6YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557BB20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43F1vW3k99zDqrW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:07:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pSBgd6YA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=bhelgaas@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="pSBgd6YA"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F1rb3MxYzDqrC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 14:04:56 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id r24so10365187wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 19:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xa6KCEdb9vp66HZWrqn/Rv4w1V6eaK3nMdHX+gjSeX4=;
 b=pSBgd6YALlonWcS42xIY6xbTPL7zgiyvKhGlxMKklGeFSWS3KGhCrtmZTYBuJyYCRb
 ObIcWMMPXLQauzj9tNFmZl8oMAxDubuQuuodJh8UcDcUPlcIG4Qm/zVtO3TPlEsUz5Os
 16eT/w5arG3MIKDhhxELp2vyhXzkz8ARPAjgQ2NvaFNPLmfmrHSqjOA8JMyGDJ2w68pn
 73s7ke/IUVrFGoOwj5mBsYo4sQgxkWRwLI7zyT4o4vz+IDPDycgskuBm5i5ZT1KdpN5k
 Ebkd6lWak/scXbremeMiF1vKi3VaYSP0UlPjftzpVneRpjR3ubQwr2n+Qb3izZPKShBQ
 b4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xa6KCEdb9vp66HZWrqn/Rv4w1V6eaK3nMdHX+gjSeX4=;
 b=p/Ivl9yhDYnAo10fNhGOwXoYvZxQaivkdl4CJddUra/gOS/MKC9Lm5KqpN9ww4VyAq
 1KXCLfJtZjOooDFzxadHkWsn0IfEgisyaYp7FPQCmiY96A6MNiTTMDWKV+Mnnop/Lz8r
 nCxqeGZgRM2+nqPpQmWU0U/287Jxogms/7rPG93NcNOO9IUF67mKkczt+ELxegCL2uu/
 HyVUqKotZzYz1Fxx6NUjNMM4ARkTRnQ3c/mye/cQgCun8+k/Ukv96aaZ8eHsvr++5WKD
 p4QpWPx5HtWPLemlqAYtMqW7waQqrKFI+nvMhowry9siBuYHzo/+7Gy+9bMwz0+o2BxY
 JLag==
X-Gm-Message-State: AA+aEWYQoFDIoEB8mHHDmPIl9cq5abQ+LJiMEcv0oTu8eAKshqTuaFAw
 1oIXfjmTw18TrpxbMLeUU+l9ryqHROX0Pf1q8mfX
X-Google-Smtp-Source: AFSGD/U9bFlRuiLKLpj2pNZhoDkyTHfdjBiYD3R1XrAPDfbe+wRg861ZU4V8hkZdcibbHmHAgtH3DbCsFttdtx/dn0g=
X-Received: by 2002:a1c:8d49:: with SMTP id p70mr4884817wmd.68.1544583893038; 
 Tue, 11 Dec 2018 19:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181211140143.GD99796@google.com> <20181212002234.GC2719@umbus.fritz.box>
In-Reply-To: <20181212002234.GC2719@umbus.fritz.box>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Dec 2018 21:04:41 -0600
Message-ID: <CAErSpo5skJK0vkQp3t+-YJ-Fw_vpo2f9GUsU9DnnhtO6X+v0mw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
To: David Gibson <david@gibson.dropbear.id.au>
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
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
 netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sbest@redhat.com,
 saeedm@mellanox.com, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 paulus@samba.org, Or Gerlitz <ogerlitz@mellanox.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, tariqt@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 11, 2018 at 6:38 PM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Tue, Dec 11, 2018 at 08:01:43AM -0600, Bjorn Helgaas wrote:
> > Hi David,
> >
> > I see you're still working on this, but if you do end up going this
> > direction eventually, would you mind splitting this into two patches:
> > 1) rename the quirk to make it more generic (but not changing any
> > behavior), and 2) add the ConnectX devices to the quirk.  That way
> > the ConnectX change is smaller and more easily
> > understood/reverted/etc.
>
> Sure.  Would it make sense to send (1) as an independent cleanup,
> while I'm still working out exactly what (if anything) we need for
> (2)?

You could, but I don't think there's really much benefit in doing the
first without the second, and I think there is some value in handling
both patches at the same time.
