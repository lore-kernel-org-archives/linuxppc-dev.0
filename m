Return-Path: <SRS0=luaH=AT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3643DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 04:40:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AF220774
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 04:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AF220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1mnT1mzRzDr2w
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 14:40:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.214.193;
 helo=mail-pl1-f193.google.com; envelope-from=mcgrof@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1mlS1lPjzDqWW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 14:38:27 +1000 (AEST)
Received: by mail-pl1-f193.google.com with SMTP id d10so17652714pls.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2020 21:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rLqyPrHmkwwskxepcX7hcpAy9KCQ3ceDS+STlZ/U0Zo=;
 b=Zb9Uf2Dt9EhVskvKPNnCCp9AqE84Xs+BRiJnzDRMg3X06Zh2cIdcQgK5w4+qHyajPv
 qcFF9HtBy+klqNQeHJDzgiVl7tFTvBor1tIrMF/WK8wNm079sPh3VXF2ONKUw3ucNCop
 YM2P3I1ASnWT4WTVqpr1TXkGkjKZPHAeAaLDHaL1ZX5Kwr5kh5VE1J4RTUoy3QC19L4y
 W4SbmjHzKtsesERu7ragqCUtDCwlXgMF7sXRos+QS/nObIH24aLXmIeUZvFLypvul4h1
 URn8lgWs0iUjdXY5FaPb8il4ml1Jf5q0QZn7zQxUGgjkkMHw9xWcWGmK5De/Nq4P0+Ga
 8ICw==
X-Gm-Message-State: AOAM533mOkdtsjAEn3m85mbLhFGBpGDUkdmBALeTqw5sqDxeCOkCuP4N
 CBvk/ekOPbCo8INZnfmm+Ek=
X-Google-Smtp-Source: ABdhPJzQZBDpIZw9iAzqNJSgkNYuYBasQcAK531ZK3GOkmKLjjDjlLx8Uewlh2xjKVlV5/alkiMSig==
X-Received: by 2002:a17:90a:e017:: with SMTP id
 u23mr7680022pjy.179.1594183105448; 
 Tue, 07 Jul 2020 21:38:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id e5sm3979787pjy.26.2020.07.07.21.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 21:38:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id C7031400DB; Wed,  8 Jul 2020 04:38:23 +0000 (UTC)
Date: Wed, 8 Jul 2020 04:38:23 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 08/12] init: main: add KUnit to kernel init
Message-ID: <20200708043823.GZ4332@42.do-not-panic.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-9-brendanhiggins@google.com>
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
Cc: linux-doc@vger.kernel.org, catalin.marinas@arm.com, jcmvbkbc@gmail.com,
 will@kernel.org, paulus@samba.org, linux-kselftest@vger.kernel.org,
 frowand.list@gmail.com, anton.ivanov@cambridgegreys.com,
 linux-arch@vger.kernel.org, richard@nod.at, rppt@linux.ibm.com,
 yzaikin@google.com, linux-xtensa@linux-xtensa.org, keescook@chromium.org,
 arnd@arndb.de, jdike@addtoit.com, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, davidgow@google.com, skhan@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
 chris@zankel.net, monstr@monstr.eu, sboyd@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, logang@deltatee.com,
 akpm@linux-foundation.org, alan.maguire@oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 26, 2020 at 02:09:13PM -0700, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().

The commit log does not explain *why*.

> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
