Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35293C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:58:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1922086C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe5HHdak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1922086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rrbD4B51zF3W2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:58:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oe5HHdak";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oe5HHdak"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rrXd5t43zF3Gr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:56:17 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id b81-v6so3547pfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=ZfD90Hvp0FuovJUhMX05MqKYD8ZCEtw5w94uyNFI8Qo=;
 b=oe5HHdakLh9BH1W8MU3AFu1RzNoBlN/4tVsxRE/UQYqJI8N4qTm8fx2e0OcSlKqlP5
 O23wL4TRdei2KvgdoUFmb5KNYUk/KkkQmpYzkALD2XF6565COSai4DIhcKSmY+iCX5rg
 cSKz+Fi3+gDqQvJsPq7rYh8NYEaY5p1FBrYa4kZKDSD1vIq8nsQe0SmMLdTeofHGmPV+
 YVPgnXcJSNFDuKN04oFZ4yRoKp27EVetYuSal8ZUbmJW1imjT2+tlpnxeRRJBKJr4xxA
 8rNSnpT/ZSsWe1JVbb1j4O0kynwZevYWdKt+ZigJX9h0qWpFgya5lUuY5SLH8XrJ5kP8
 bfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=ZfD90Hvp0FuovJUhMX05MqKYD8ZCEtw5w94uyNFI8Qo=;
 b=eyyracwEa7dZ/rLc54Xsiezd+UCAzA3IHLghwNd0CWrQ1Mi128ZGR+369REnqjBLq+
 AQUhxtEmCdVCaMQSKJ4WvdzpPzAvtMWwLdDcvdstxUBWNW06h0mYbBuPMq07mOH50PJe
 sKhokhJlJklhtafUDFtuqp6FNVfykZLIfT9ChTGO2LbokQLwE0kUI1IYb9uw51VPC8Kv
 8ZysYZt6c8tshzZnkblWQ049v/5WgwjgWXF5nDKYAAwlsOPUBQhbTC33t5Io59++Foin
 FptyBCDIS69yU64ZxwB0k1qAS1WWWkRfF45g4hn7P1OPKkuY4h1cNLbQv6xYPKtMmlED
 J5eA==
X-Gm-Message-State: AGRZ1gKfwXeZPRflkVBl3r5anTRsWb3jp8S0Em9HJR8ND0RrY5p7+lYi
 zg5Z4HcGjw3pQMEPQZny618=
X-Google-Smtp-Source: AJdET5cJP7EBKyx+ty0Uz7zyAJ2LqRX4p3tJUuzYGVqeJCbd8TVYNpQ14Vj7fd2VGQAfhDcD+tqivQ==
X-Received: by 2002:a62:160c:: with SMTP id 12-v6mr7776030pfw.45.1541746575691; 
 Thu, 08 Nov 2018 22:56:15 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id e65-v6sm7181502pfa.90.2018.11.08.22.56.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Nov 2018 22:56:15 -0800 (PST)
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] of: overlay: validation checks, subsequent fixes for v20
Message-ID: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
Date: Thu, 8 Nov 2018 22:56:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-fpga@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

Please pull the changes to add the overlay validation checks.

This is the v7 version of the patch series.

-Frank


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git tags/kfree_validate_v7-for-4.20

for you to fetch changes up to eeb07c573ec307c53fe2f6ac6d8d11c261f64006:

  of: unittest: initialize args before calling of_*parse_*() (2018-11-08 22:12:37 -0800)

----------------------------------------------------------------
Add checks to (1) overlay apply process and (2) memory freeing
triggered by overlay release.  The checks are intended to detect
possible memory leaks and invalid overlays.

The checks revealed bugs in existing code.  Fixed the bugs.

While fixing bugs, noted other issues, which are fixed in
separate patches.

----------------------------------------------------------------
Frank Rowand (17):
      of: overlay: add tests to validate kfrees from overlay removal
      of: overlay: add missing of_node_put() after add new node to changeset
      of: overlay: add missing of_node_get() in __of_attach_node_sysfs
      powerpc/pseries: add of_node_put() in dlpar_detach_node()
      of: overlay: use prop add changeset entry for property in new nodes
      of: overlay: do not duplicate properties from overlay for new nodes
      of: overlay: reorder fields in struct fragment
      of: overlay: validate overlay properties #address-cells and #size-cells
      of: overlay: make all pr_debug() and pr_err() messages unique
      of: overlay: test case of two fragments adding same node
      of: overlay: check prevents multiple fragments add or delete same node
      of: overlay: check prevents multiple fragments touching same property
      of: unittest: remove unused of_unittest_apply_overlay() argument
      of: overlay: set node fields from properties when add new overlay node
      of: unittest: allow base devicetree to have symbol metadata
      of: unittest: find overlays[] entry by name instead of index
      of: unittest: initialize args before calling of_*parse_*()

 arch/powerpc/platforms/pseries/dlpar.c             |   2 +
 drivers/of/dynamic.c                               |  59 ++++-
 drivers/of/kobj.c                                  |   4 +-
 drivers/of/overlay.c                               | 292 ++++++++++++++++-----
 drivers/of/unittest-data/Makefile                  |   2 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |  96 +++++--
 include/linux/of.h                                 |  21 +-
 10 files changed, 432 insertions(+), 97 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
