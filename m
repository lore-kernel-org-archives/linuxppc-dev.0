Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8DAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:00:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F1F20896
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F1F20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SgW74N8wzDqJh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 04:00:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.58.91; helo=7.mo178.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 7.mo178.mail-out.ovh.net (7.mo178.mail-out.ovh.net
 [46.105.58.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SgTN4DLnzDqDs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 03:59:01 +1100 (AEDT)
Received: from player739.ha.ovh.net (unknown [10.109.146.163])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2B67057CBC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:49:27 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id 0B61B42A849F;
 Mon, 25 Mar 2019 16:49:19 +0000 (UTC)
Date: Mon, 25 Mar 2019 17:49:19 +0100
From: Greg Kurz <groug@kaod.org>
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: Re: [PATCH v4 0/4] ocxl: OpenCAPI Cleanup
Message-ID: <20190325174919.5c877cf9@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190325053456.14599-1-alastair@au1.ibm.com>
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325053456.14599-1-alastair@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 474848285720549707
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrjeekgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, alastair@d-silva.org,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Alastair,

I forgot to mention it during v3 but please don't link new version
of a patchset to the previous one with --in-reply-to. This is to
ensure I can see them in my email client without having to scroll
back many days in the past (which likely means a fair number of
e-mails on linuxppc-dev).

Cheers,

--
Greg

On Mon, 25 Mar 2019 16:34:51 +1100
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some minor cleanups for the OpenCAPI driver as a prerequisite
> for an ocxl driver refactoring to allow the driver core to
> be utilised by external drivers.
> 
> Changelog:
> V4:
>   - Drop printf format changes as they omit the format indicator for '0'
> V3:
>   - Add missed header in 'ocxl: Remove some unused exported symbols'.
>     This addresses the introduced sparse warnings
> V2:
>   - remove intermediate assignment of 'link' var in
>                 'Rename struct link to ocxl_link'
>   - Don't shift definition of ocxl_context_attach in
>                 'Remove some unused exported symbols'
> 
> 
> Alastair D'Silva (4):
>   ocxl: Rename struct link to ocxl_link
>   ocxl: read_pasid never returns an error, so make it void
>   ocxl: Remove superfluous 'extern' from headers
>   ocxl: Remove some unused exported symbols
> 
>  drivers/misc/ocxl/config.c        | 13 ++---
>  drivers/misc/ocxl/file.c          |  5 +-
>  drivers/misc/ocxl/link.c          | 36 ++++++-------
>  drivers/misc/ocxl/ocxl_internal.h | 85 +++++++++++++++++++------------
>  include/misc/ocxl.h               | 53 ++++++-------------
>  5 files changed, 91 insertions(+), 101 deletions(-)
> 

