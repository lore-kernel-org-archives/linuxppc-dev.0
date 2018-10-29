Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF851C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 19:53:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC0F2080A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 19:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC0F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kQJF5n1LzF10S
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 06:53:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kQGD29G7zDsGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 06:51:31 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4FE73AF62;
 Mon, 29 Oct 2018 19:51:28 +0000 (UTC)
Date: Mon, 29 Oct 2018 20:51:27 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [PATCH v08 0/5] powerpc/hotplug: Update affinity for migrated CPUs
Message-ID: <20181029205127.3987eaaa@kitsune.suse.cz>
In-Reply-To: <9573dc30-01ad-2650-c247-28df08875cef@linux.vnet.ibm.com>
References: <9573dc30-01ad-2650-c247-28df08875cef@linux.vnet.ibm.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 29 Jul 2018 08:18:34 -0500
Michael Bringmann <mwb@linux.vnet.ibm.com> wrote:

> The migration of LPARs across Power systems affects many attributes
> including that of the associativity of CPUs.  The patches in this
> set execute when a system is coming up fresh upon a migration target.
> They are intended to,
> 
> * Recognize changes to the associativity of CPUs recorded in internal
>   data structures when compared to the latest copies in the device
> tree.
> * Generate calls to other code layers to reset the data structures
>   related to associativity of the CPUs.
> * Re-register the 'changed' entities into the target system.
>   Re-registration of CPUs mostly entails acting as if they have been
>   newly hot-added into the target system.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> 
Hello,

what is the status of this patchset other than it no longer applies?

Thanks

Michal
