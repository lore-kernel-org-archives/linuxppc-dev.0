Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6241FECDE43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC469204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 18:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC469204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bcfn3RLVzF3Hb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:15:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bccP6C2szF10b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 05:13:41 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id l58so30711173otd.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 11:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rDBJm4nqmeaWFBJegkp3BQkCCdXjYEENsmO3iMF20io=;
 b=FRubtjmjZkf7Gk5gph/cUooR5d/ozfQi2Fr8qY9ThL4c+Dcz1GTtNoMlzX+i7f6tlH
 WdNpRGN7GZdnvc78cOnzKyYzl/hp6smcx7ZNiF+1zukG7xuXt3Gc1b2UrT7TAChWU/Hc
 LA5KrSWeZmPQa9SyqzB82SPWn0vSCSLc3mgLE97EUWqn4UKdnG1i/Rbsspkr1b5Sn91O
 SCfXS/FCqEHKWDjNS4Va4xxCh3UCvxgiNHy4mupFiKTVmGQpd+Rl7bBih9yhRr4rwQNw
 cq/Lk2DDc9thRZ8Y0aln0d3ZvnzHPalLRZcIfCDscMST9UZwQSJmDKxiEHDAmaFD7TLL
 f/XA==
X-Gm-Message-State: ABuFfohJnCWprMPo3lmHD4tRT8PI0ALvwK4uCfJGzPM26aY3Cj8tMmTp
 LCn9WpBfJhxLuixJ91C7Mw==
X-Google-Smtp-Source: ACcGV60nfGlaU/lcwaRenMZMvmmeXcFbwlfgCJJenxTqj8a+3KPHewNwOEJ2JrqNvTrBGvXgP5PmWg==
X-Received: by 2002:a9d:2e30:: with SMTP id q45mr18918099otb.69.1539886419710; 
 Thu, 18 Oct 2018 11:13:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w128-v6sm5629737oiw.15.2018.10.18.11.13.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Oct 2018 11:13:39 -0700 (PDT)
Date: Thu, 18 Oct 2018 13:13:38 -0500
From: Rob Herring <robh@kernel.org>
To: frowand.list@gmail.com
Subject: Re: [PATCH v4 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
Message-ID: <20181018181338.GD15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 07:37:29PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> If overlay properties #address-cells or #size-cells are already in
> the live devicetree for any given node, then the values in the
> overlay must match the values in the live tree.
> 
> If the properties are already in the live tree then there is no
> need to create a changeset entry to add them since they must
> have the same value.  This reduces the memory used by the
> changeset and eliminates a possible memory leak.  This is
> verified by 12 fewer warnings during the devicetree unittest,
> as the possible memory leak warnings about #address-cells and

Still missing the rest...

And what about my other comments too?

> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> Changes since v3:
>   - for errors of an overlay changing the value of #size-cells or
>     #address-cells, return -EINVAL so that overlay apply will fail
>   - for errors of an overlay changing the value of #size-cells or
>     #address-cells, make the message more direct.
>     Old message:
>       OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
>     New message:
>       OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed
> 
>  drivers/of/overlay.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
