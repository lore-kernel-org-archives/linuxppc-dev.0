Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C3AC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 02:35:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1712146F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 02:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1712146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RSNw3k9fzDqHJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 13:35:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43RSLh6JPMzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 13:33:48 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 711D328CFC;
 Fri, 28 Dec 2018 21:33:44 -0500 (EST)
Date: Sat, 29 Dec 2018 13:34:02 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
In-Reply-To: <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
Message-ID: <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 29 Dec 2018, Michael Schmitz wrote:

> 
> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to suggest.
> 
> Or (really going out on a limb here):
> 
> IS_BUILTIN(CONFIG_NVRAM) ||
> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
> 
> Not that I'd advocate that, for this series.
> 

Well, you are a maintainer for atari_scsi.c.

Are you saying that you want IS_BUILTIN(CONFIG_NVRAM) used here instead of 
ifdef?

OTOH, if you approve of the existing patch, please send your acked-by.

-- 

> Cheers,
> 
> 	Michael
> 
> 
> 
> 
