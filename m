Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD5C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:05:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141B82184C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 20:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIWSV/M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141B82184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K8CX0VmhzDqcl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 07:05:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aIWSV/M+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="aIWSV/M+"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K86z3lWLzDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 07:01:47 +1100 (AEDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A5D82184C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545163305;
 bh=zCAO2BbTkh/sFdthPUz5p/F48j8PylSJki+FT1GeNBI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=aIWSV/M+A2x00EJre0yBqvCAiMfzRebXQ9HppmIi/dbxAQmQlc19xnThZIWBW+Lrc
 FgjZKnZyI3yIU94x6uUD6jYWM5sBTDq6qhvipUyhDenWsiY5Xrza0Ryai02RQCjTL2
 oYjmBJRSQcFe1SB7SpxVUPmMhiPH6WtcIEzpe15Q=
Received: by mail-qt1-f170.google.com with SMTP id e5so19614230qtr.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 12:01:45 -0800 (PST)
X-Gm-Message-State: AA+aEWbTOGgMIYSiieF6RSQnh6hFZZniVrGuI3D2Vcl//uRaTSLHSKQW
 3iQRCw7asoIEmEGmGz59CqzPxK3GQqyxSLoCVA==
X-Google-Smtp-Source: AFSGD/VLtRpCxETOi7/sDAgrhrMINBjkV30Qxy1JP5KyQy21s/XbziBnJNS5pgk3sHWFNTf+9jjwZ5qUv/i6suQejiQ=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr18734258qvb.218.1545163304244; 
 Tue, 18 Dec 2018 12:01:44 -0800 (PST)
MIME-Version: 1.0
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
 <871s6gv30z.fsf@concordia.ellerman.id.au>
 <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
In-Reply-To: <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 18 Dec 2018 14:01:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
Message-ID: <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle
 cache
To: Frank Rowand <frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 18, 2018 at 12:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 12/17/18 2:52 AM, Michael Ellerman wrote:
> > Hi Frank,
> >
> > frowand.list@gmail.com writes:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Non-overlay dynamic devicetree node removal may leave the node in
> >> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> >> will incorrectly find the stale entry.  Remove the node from the
> >> cache.
> >>
> >> Add paranoia checks in of_find_node_by_phandle() as a second level
> >> of defense (do not return cached node if detached, do not add node
> >> to cache if detached).
> >>
> >> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >
> > Similarly here can we add:
> >
> > Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
>
> Yes, thanks.
>
>
> > Cc: stable@vger.kernel.org # v4.17+
>
> Nope, 0b3ce78e90fc does not belong in stable (it is a feature, not a bug
> fix).  So the bug will not be in stable.

0b3ce78e90fc landed in v4.17, so Michael's line above is correct.
Annotating it with 4.17 only saves Greg from trying and then emailing
us to backport this patch as it wouldn't apply.

Rob
