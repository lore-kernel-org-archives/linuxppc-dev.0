Return-Path: <SRS0=P9+W=Y4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9018CA9EB5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 20:33:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6142089C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 20:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i7XYQ1ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6142089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 476Pd62MntzF3Wy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Nov 2019 07:33:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ziepe.ca (client-ip=2607:f8b0:4864:20::742;
 helo=mail-qk1-x742.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="i7XYQ1ZH"; 
 dkim-atps=neutral
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476Pb16WHHzDrFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2019 07:31:21 +1100 (AEDT)
Received: by mail-qk1-x742.google.com with SMTP id m16so18620102qki.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2019 12:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aYX4F5OJlshBJ+QLO90C7o41djzLcZaOuQTAXbn39ZY=;
 b=i7XYQ1ZHnaY5oxYezVkAZAHGtsh9bOxhHHH3Sn5BIbI+VqJGCPCEvJJaUK5id2Lxjo
 QZy6D5PvoaQcuBVLCBsiP73L6feFkqb9tVyMSKRQoFapdLhYlh11jHUlLfPVcbmAdyn1
 qgfQIJll3BI0DBDvZGBzvIVtKJCbp1OnuM2aeiBnkmmVUjaX5fsGUiMUJQeUjXWcxDWM
 sAgWZWBan6hPzPaW8EaeJ7isi+vnjjn+QWBP0lAA7PgqU29xvVlAbi4989CKgrofdhsL
 SLPnsPkcXFsQUt+67vnjQSIXC5MpAEuJFrM68zNna9vYOt+4Hz7I+EIeX0dmXrL/tCRN
 VzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aYX4F5OJlshBJ+QLO90C7o41djzLcZaOuQTAXbn39ZY=;
 b=LluEZcpsc72orpSNtxPFpv7TtrowKi3uwJGE4jJpQyIh7fk8eSV3R++aAgDx+evhaz
 9sM4sgXo/zHeXrgRMvLqwRFETrU2lkjV9csnaw63w3IrEZCNANnJwcLgke09HDse58pf
 7QsfolAek8X0v1c9SypInxlABiJNrEW0+gRbEtO8ylsIBKpN/ouEAty3iUI5BGEZOrLY
 Ezkijb2RqLW0YyEhM4Id5Bmpobxp3xQjPet1+y+iI+mUeVYbyeoe+W4CDcJ9VN4GAwLF
 oUIUqmzgFzYK/tcIvnIYP5zEqcCaaT5pPymIZQwr34wD/hL5b/ldCe44+DfaaS2FVnr4
 L66g==
X-Gm-Message-State: APjAAAXt95KMpjOQsjA5O+dTH8CGUmu+Ed5EDNqDKH4BrME5kv+8IYY3
 +DR0PcJHu6G31VOP7IcarWOxdw==
X-Google-Smtp-Source: APXvYqzTj81BtQYcnQbs3rWnwUMY938CFsks7F1nt4LFfYHLDO23qLLbnBWdB3geEbkRzW5fLjS+gw==
X-Received: by 2002:a37:7d03:: with SMTP id y3mr6497602qkc.385.1572899478562; 
 Mon, 04 Nov 2019 12:31:18 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id g20sm636338qke.129.2019.11.04.12.31.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Nov 2019 12:31:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iRj0P-0005GE-Di; Mon, 04 Nov 2019 16:31:17 -0400
Date: Mon, 4 Nov 2019 16:31:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 05/18] mm/gup: introduce pin_user_pages*() and FOLL_PIN
Message-ID: <20191104203117.GE30938@ziepe.ca>
References: <20191103211813.213227-1-jhubbard@nvidia.com>
 <20191103211813.213227-6-jhubbard@nvidia.com>
 <20191104173325.GD5134@redhat.com>
 <be9de35c-57e9-75c3-2e86-eae50904bbdf@nvidia.com>
 <20191104191811.GI5134@redhat.com>
 <e9656d47-b4a1-da8a-e8cc-ebcfb8cc06d6@nvidia.com>
 <20191104195248.GA7731@redhat.com>
 <25ec4bc0-caaa-2a01-2ae7-2d79663a40e1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ec4bc0-caaa-2a01-2ae7-2d79663a40e1@nvidia.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Dave Chinner <david@fromorbit.com>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 linux-kselftest@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, bpf@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 04, 2019 at 12:09:05PM -0800, John Hubbard wrote:

> Note for Jason: the (a) or (b) items are talking about the vfio case, which is
> one of the two call sites that now use pin_longterm_pages_remote(), and the
> other one is infiniband:
> 
> drivers/infiniband/core/umem_odp.c:646:         npages = pin_longterm_pages_remote(owning_process, owning_mm,

This is a mistake, it is not a longterm pin and does not need FOLL_PIN
semantics

> Jason should weigh in on how he wants this to go, with respect to branching
> and merging, since it sounds like that will conflict with the hmm branch 

I think since you don't need to change this site things should be
fine?

Jason
