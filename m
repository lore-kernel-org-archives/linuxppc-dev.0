Return-Path: <SRS0=BgZL=ZL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869D4C432C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 16:13:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F58223AC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oGIJW8Hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F58223AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HW8R1FzFzDqbt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 03:13:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=axboe@kernel.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.b="oGIJW8Hf"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HW5g1Lz5zDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 03:11:01 +1100 (AEDT)
Received: by mail-io1-xd44.google.com with SMTP id k1so23837839ioj.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yxTg9Jz6CUPbj7hb+zClDPA6shnTNr7Uh8vLjm12KTA=;
 b=oGIJW8HfkgkobB0o2Qa1NbNfnl9mEqSGpPEO2LkogyZvOuMJQ7TF55da86qlugqMCd
 338Wge2YPFXsoEIf9RGDawq7jpCCeV3jwC0W058T6wHLBemhZJS3koszJqUTfQULDiaX
 2B6RyRY6HS9AE+8hVENsQBKSpUdhkmyAKNXz0Nm/Cxj0QFJRN/CWS+DE/OAhOnYHg0xk
 tK1FlPGkzCpUU1kARsuIumFoSGAGKhbP5ourqDXhrP7e5xrJzr7bWyrrGYocI1tJI7bI
 UgAaDI7OLq1bomHv0lR8zAsfor6M3fEsHwxDtlUp7bVspKwb2e69Lw3GuCnkI9VLqTxF
 /QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yxTg9Jz6CUPbj7hb+zClDPA6shnTNr7Uh8vLjm12KTA=;
 b=gCTjcXsgkWRMerY+ggn1hkUkjo6xRZ7fhECFboQ+KzvWIezk0AnlApU7mA4rRILxqy
 lAlc6mH7OZApRqDNL8GAidSemlHWC7bdSI/NnGxKDfGzfWX9L29ecuDSl3bX7X9v2jUr
 9vSVl3DzQ5HJLltKKjW5TltctE1/0eXSyVwJ8KbC9MteTVbHe3ZcFn9dY4baYoePsXzQ
 TffVloj+dTnC2j557Qok+GN5EuD6xqvalmZNTsSFoR2wqibDR3CtjUpmKtfvXccoGgIz
 0wHOxUmS0Onv7q0DSa+INfYcI+uNrM28KN3kSjQmBwRcIkmfOYDeBgH/hn5PN8ksFJGH
 0MwA==
X-Gm-Message-State: APjAAAV4f5nZ+ideegb362HKTeG4lKkQn3nUdSBwqA4PSt4I0kTI5Xcr
 6GegvCDBlaqwTNesgDv3r397Og==
X-Google-Smtp-Source: APXvYqw/6l4rejQYc8a+bdmv6/89DOI3Ir5+fK0WCl1y9yQpIdn8Kiz4M9g4FLh+4h0UiHB53RA+ow==
X-Received: by 2002:a02:140a:: with SMTP id 10mr18915165jag.72.1574179857938; 
 Tue, 19 Nov 2019 08:10:57 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id u6sm5616560ilm.22.2019.11.19.08.10.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:10:56 -0800 (PST)
Subject: Re: [PATCH v6 15/24] fs/io_uring: set FOLL_PIN via pin_user_pages()
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20191119081643.1866232-1-jhubbard@nvidia.com>
 <20191119081643.1866232-16-jhubbard@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2ae65d1b-a3eb-74ed-afce-c493de5bbfd3@kernel.dk>
Date: Tue, 19 Nov 2019 09:10:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119081643.1866232-16-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@suse.cz>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 linux-media@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/19/19 1:16 AM, John Hubbard wrote:
> Convert fs/io_uring to use the new pin_user_pages() call, which sets
> FOLL_PIN. Setting FOLL_PIN is now required for code that requires
> tracking of pinned pages, and therefore for any code that calls
> put_user_page().
> 
> In partial anticipation of this work, the io_uring code was already
> calling put_user_page() instead of put_page(). Therefore, in order to
> convert from the get_user_pages()/put_page() model, to the
> pin_user_pages()/put_user_page() model, the only change required
> here is to change get_user_pages() to pin_user_pages().
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

You dropped my reviewed-by now... Given the file, you'd probably want
to keep that.

-- 
Jens Axboe

