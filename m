Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F15C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 23:26:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983162085A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 23:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="l9yer8uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983162085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44P8MQ6dKnzDqG6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:26:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.77; helo=rcdn-iport-6.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="l9yer8uM"; 
 dkim-atps=neutral
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44P8KS2RqqzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 10:24:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=570; q=dns/txt; s=iport;
 t=1553037900; x=1554247500;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DFRZMwk2U008BtMBHPP99TgTohzQ+FxwjN8PrE/7RKE=;
 b=l9yer8uMIp4URsjLXB1sLadxeOZpRZQa404dHgo/dBPZfRZ/j3uExR70
 2AEz+QZBSAMHLg3B4Gwr9TNX3cEoLi+DgXiJ2kQQFcH1di8zqqWNumzMZ
 90lGY3gpDOwC0eX7l23OXnMu6WxO1mACT+BYQMKTwSihMhRIK4lOrs8Xx w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AmAAC5eZFc/4cNJK1jHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBghBogQOMTossmj8UgWcNI4Q/hHciNAkNAQEDAQEJAQMCbRw?=
 =?us-ascii?q?MhgMBb4EVAYM0AYF0AQ+sAYQwAQsBhXMFFIEbAYZphEgXgUA/iQyFeQOSHJJ?=
 =?us-ascii?q?NCYIBSoUSi0MMGYFskXKLDIV7jTCBRziBVjMaCBsVgnMBNIsLhV8fkB4BAQ?=
X-IronPort-AV: E=Sophos;i="5.60,246,1549929600"; d="scan'208";a="537468394"
Received: from alln-core-2.cisco.com ([173.36.13.135])
 by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 19 Mar 2019 23:24:53 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
 by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id
 x2JNOrtU019667; Tue, 19 Mar 2019 23:24:53 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Generic command line -v2
Date: Tue, 19 Mar 2019 16:24:44 -0700
Message-Id: <20190319232448.45964-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

new in -v2
	* Updated with some changes to adding spaces from Christophe Leroy.
	* Added OF support with comments from Rob on my 2015 submission which he reviewed.
		(https://lore.kernel.org/patchwork/patch/604997/)
	  Christophe and Rob suggested to have support for this inside the OF code.
	* Powerpc was made to use the OF parts instead of having changes into it's code.
	* Removed trim effect from powerpc config files. sed only was used to convert.
	  requested by Michael Ellerman.

That's basically it. Otherwise the same changes.

Daniel


