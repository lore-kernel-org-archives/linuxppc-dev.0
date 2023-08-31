Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31394C83F01
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Aug 2023 12:10:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rc0P33lB4z3c2Z
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Aug 2023 22:10:47 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rc0NW5q2rz300g
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2023 22:10:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rc0NR0kHmz4wb5;
	Thu, 31 Aug 2023 22:10:15 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230829225837.15520-1-rdunlap@infradead.org>
References: <20230829225837.15520-1-rdunlap@infradead.org>
Subject: Re: [PATCH] macintosh/ams: linux/platform_device.h is needed
Message-Id: <169348378762.53003.9449787448140786027.b4-ty@ellerman.id.au>
Date: Thu, 31 Aug 2023 22:09:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 29 Aug 2023 15:58:37 -0700, Randy Dunlap wrote:
> ams.h uses struct platform_device, so the header should be used
> to prevent build errors:
> 
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_enable':
> drivers/macintosh/ams/ams-input.c:68:45: error: invalid use of undefined type 'struct platform_device'
>    68 |         input->dev.parent = &ams_info.of_dev->dev;
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
> drivers/macintosh/ams/ams-input.c:146:51: error: invalid use of undefined type 'struct platform_device'
>   146 |         return device_create_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_exit':
> drivers/macintosh/ams/ams-input.c:151:44: error: invalid use of undefined type 'struct platform_device'
>   151 |         device_remove_file(&ams_info.of_dev->dev, &dev_attr_joystick);
> drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
> drivers/macintosh/ams/ams-input.c:147:1: error: control reaches end of non-void function [-Werror=return-type]
>   147 | }
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh/ams: linux/platform_device.h is needed
      https://git.kernel.org/powerpc/c/85a616416e9e01db0bfa92f26457e92642e2236b

cheers
