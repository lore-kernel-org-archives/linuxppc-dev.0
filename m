Return-Path: <SRS0=rI0D=Y6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65436C5DF62
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 06:00:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A402075C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 06:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="YSGwBlFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A402075C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477G9L1HgBzF5V2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 17:00:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477G6q3KFqzF3jG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2019 16:58:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="YSGwBlFf"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 477G6q0k0vz9sPF; Wed,  6 Nov 2019 16:58:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1573019907; bh=56y9/gEaDzQmeKp9iXKr2ut32/omIfnBdtSxBPQKzkQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YSGwBlFfFtQL4eL2wF4UIeyChrpdMx5L4IUbxmr/LjnZOVz2ZGoNtyB+yYlJ6NtA2
 BeiWR2+BwJtRlAFJrHh8lmPqOVgoYHtG0PfPjtM+e0PeWvuqkDpPGr/usj1GDyfEfe
 v1g/aAkoeln+bBZwG8gP542+NfUDHOPkANX9UwdtqbLw+Qk7muJ+fjhgRTTIashezE
 YasQaF3hsR+LdzQHDsUrLk2WFEphkX6v8Sl/K5HoygKmAeqgteBfTNiOwlS/jcYEcs
 yBeX2BAOvFfASn2EVcrYBWyqM7kW5RvCdTgYnw6cxkN0oc4oBVajsfezPoNdhnmrbm
 SJqhWdJMjCEZw==
Date: Wed, 6 Nov 2019 15:30:58 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v10 0/8] KVM: PPC: Driver to manage pages of secure guest
Message-ID: <20191106043058.GA12069@oak.ozlabs.ibm.com>
References: <20191104041800.24527-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104041800.24527-1-bharata@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linuxram@us.ibm.com, cclaudio@linux.ibm.com, kvm-ppc@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 04, 2019 at 09:47:52AM +0530, Bharata B Rao wrote:
> Hi,
> 
> This is the next version of the patchset that adds required support
> in the KVM hypervisor to run secure guests on PEF-enabled POWER platforms.
> 
> The major change in this version is about not using kvm.arch->rmap[]
> array to store device PFNs, thus not depending on the memslot availability
> to reach to the device PFN from the fault path. Instead of rmap[], we
> now have a different array which gets created and destroyed along with
> memslot creation and deletion. These arrays hang off from kvm.arch and
> are arragned in a simple linked list for now. We could move to some other
> data structure in future if walking of linked list becomes an overhead
> due to large number of memslots.

Thanks.  This is looking really close now.

> Other changes include:
> 
> - Rearranged/Merged/Cleaned up patches, removed all Acks/Reviewed-by since
>   all the patches have changed.
> - Added a new patch to support H_SVM_INIT_ABORT hcall (From Suka)
> - Added KSM unmerge support so that VMAs that have device PFNs don't
>   participate in KSM merging and eventually crash in KSM code.
> - Release device pages during unplug (Paul) and ensure that memory
>   hotplug and unplug works correctly.
> - Let kvm-hv module to load on PEF-disabled platforms (Ram) when
>   CONFIG_PPC_UV is enabled allowing regular non-secure guests
>   to still run.
> - Support guest reset when swithing to secure is in progress.
> - Check if page is already secure in kvmppc_send_page_to_uv() before
>   sending it to UV.
> - Fixed sentinal for header file kvm_book3s_uvmem.h (Jason)
> 
> Now, all the dependencies required by this patchset are in powerpc/next
> on which this patchset is based upon.

Can you tell me what patches that are in powerpc/next but not upstream
this depends on?

Paul.
