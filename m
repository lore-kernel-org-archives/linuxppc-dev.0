Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F99C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 08:15:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C1A20897
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 08:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C1A20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49YHSq118nzDqd9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 18:15:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=jani.nikula@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49YHQF5cNCzDqXR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 18:13:36 +1000 (AEST)
IronPort-SDR: 7kSpbvmwTg89IewVCg+jnq+MlictnYYtIOKnxz3wHziIwWs93VBaRpIEGL5Y0B2uZ/445LWJjI
 U6u39rAe98zQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 01:13:34 -0700
IronPort-SDR: D2OwS10W8ZRNlx/6Re2YsoM7kJBRLFponE5d5dxkGBhZBaxQ/ruwwvpzbgjrVkk988jxA2/K/b
 SWs0rrYn6mJA==
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; d="scan'208";a="443289103"
Received: from vtsikino-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.43.186])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 01:13:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, keescook@chromium.org,
 yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
 axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie,
 daniel@ffwll.ch, benh@kernel.crashing.org, rdna@fb.com,
 viro@zeniv.linux.org.uk, mark@fasheh.com, jlbec@evilplan.org,
 joseph.qi@linux.alibaba.com, vbabka@suse.cz, sfr@canb.auug.org.au,
 jack@suse.cz, amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Subject: Re: [PATCH 01/13] sysctl: add new register_sysctl_subdir() helper
In-Reply-To: <20200529074108.16928-2-mcgrof@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-2-mcgrof@kernel.org>
Date: Fri, 29 May 2020 11:13:21 +0300
Message-ID: <87d06n17mm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, julia.lawall@lip6.fr,
 Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 29 May 2020, Luis Chamberlain <mcgrof@kernel.org> wrote:
> Often enough all we need to do is create a subdirectory so that
> we can stuff sysctls underneath it. However, *if* that directory
> was already created early on the boot sequence we really have no
> need to use the full boiler plate code for it, we can just use
> local variables to help us guide sysctl to place the new leaf files.

I find it hard to figure out the lifetime requirements for the tables
passed in; when it's okay to use local variables and when you need
longer lifetimes. It's not documented, everyone appears to be using
static tables for this. It's far from obvious.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
