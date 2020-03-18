Return-Path: <SRS0=Ik3v=5D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C46C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 19:44:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5743C20754
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 19:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5743C20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jL8V3tGWzDqxL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 06:44:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=jarkko.sakkinen@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jL6w14sLzDqxD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 06:42:57 +1100 (AEDT)
IronPort-SDR: AJtzJGIikqfPt/8ehClN00KgQvXwTfRlzyVgzTmDDhg0IBxSkNIKaKdoPGz1pmlFTh/T5WllMe
 AkA5noF25I3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 12:42:54 -0700
IronPort-SDR: Suav0KM2ojYrxipcrlkmBmqgkdJt9MoK6XuOeygK+vUXd09ADpQG18cojbOlMEEpsFJ67Q6Qap
 UbLZ2rE+Eekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; d="scan'208";a="418064574"
Received: from mbeldzik-mobl.ger.corp.intel.com (HELO localhost)
 ([10.252.55.127])
 by orsmga005.jf.intel.com with ESMTP; 18 Mar 2020 12:42:49 -0700
Date: Wed, 18 Mar 2020 21:42:47 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as
 module
Message-ID: <20200318194247.GC48177@linux.intel.com>
References: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Cc: sachinp@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 17, 2020 at 09:08:19AM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This patch fixes the following problem when the ibmvtpm driver
> is built as a module:
> 
> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> make: *** [Makefile:1298: modules] Error 2
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Hi, wrong tag (we use "tpm:"), missing fixes tag and please cc stable.
Thanks.

/Jarkko
