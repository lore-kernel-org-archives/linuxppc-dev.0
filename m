Return-Path: <SRS0=cpv1=BH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AAEC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 05:54:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12E420658
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 05:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ay5dsS9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12E420658
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BG5Tc5K1bzDr8C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 15:54:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BG5RS3tQJzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2020 15:52:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=ay5dsS9/; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4BG5RS0PTBz9sTm; Tue, 28 Jul 2020 15:52:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1595915540; bh=+4m+nip6A1Fn0hjlDbrbBLcZlqpgnvDS+IvWIylIUoM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ay5dsS9/nml08EXtk/F7vGZhCVU7DszWdML4byQEKIHcxOlW9J+tLzRDW9WkaOJGW
 eAg1Q+nToPJCAzECLhEHktA7yy52iBwJNTQzs+vjci893uit6NQt+fV/BTt9m4d/CC
 NSNupufIUHS1wnD4azy97HsfLugKmuxU32D9BF/rXoXWh9SemJ3uQzIpxDJbJHeWnw
 MqwFIahGF7EeANpoZtUXEG91UBzgAYcKt6ZRxfo0fOp5lVSYcXGQQXhSrE6EmUftU5
 ch6mDVGYINSladlsZkQzTvVDPZ+1RTD5Q3+XdJk8G+6OkBvLFoshqcPthPiaKtHf8j
 jyF5m5mFDZP5w==
Date: Tue, 28 Jul 2020 15:52:15 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v2 0/2] Rework secure memslot dropping
Message-ID: <20200728055215.GC2460422@thinks.paulus.ozlabs.org>
References: <1595877869-2746-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595877869-2746-1-git-send-email-linuxram@us.ibm.com>
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
Cc: ldufour@linux.ibm.com, cclaudio@linux.ibm.com, kvm-ppc@vger.kernel.org,
 bharata@linux.ibm.com, sathnaga@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com, david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 27, 2020 at 12:24:27PM -0700, Ram Pai wrote:
> From: Laurent Dufour <ldufour@linux.ibm.com>
> 
> When doing memory hotplug on a secure VM, the secure pages are not well
> cleaned from the secure device when dropping the memslot.  This silent
> error, is then preventing the SVM to reboot properly after the following
> sequence of commands are run in the Qemu monitor:
> 
> device_add pc-dimm,id=dimm1,memdev=mem1
> device_del dimm1
> device_add pc-dimm,id=dimm1,memdev=mem1
> 
> At reboot time, when the kernel is booting again and switching to the
> secure mode, the page_in is failing for the pages in the memslot because
> the cleanup was not done properly, because the memslot is flagged as
> invalid during the hot unplug and thus the page fault mechanism is not
> triggered.
> 
> To prevent that during the memslot dropping, instead of belonging on the
> page fault mechanism to trigger the page out of the secured pages, it seems
> simpler to directly call the function doing the page out. This way the
> state of the memslot is not interfering on the page out process.
> 
> This series applies on top of the Ram's one titled:
> "[v6 0/5] Migrate non-migrated pages of a SVM."

Thanks, series applied to my kvm-ppc-next branch and pull request sent.

Paul.
