Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8845C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 03:16:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1CD218A5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 03:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1CD218A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PsPh6SGMzDqRf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 14:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux-foundation.org
 (client-ip=140.211.169.12; helo=mail.linuxfoundation.org;
 envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PsMx6Kp8zDqQF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 14:14:37 +1100 (AEDT)
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net
 [73.223.200.170])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0983B1869;
 Thu, 21 Mar 2019 03:14:34 +0000 (UTC)
Date: Wed, 20 Mar 2019 20:14:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Walker <danielwa@cisco.com>
Subject: Re: [PATCH 1/4] add generic builtin command line
Message-Id: <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
In-Reply-To: <20190320232328.3bijcxek2yg43a25@zorba>
References: <20190319232448.45964-2-danielwa@cisco.com>
 <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
 <20190320232328.3bijcxek2yg43a25@zorba>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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
Cc: Maksym Kokhan <maksym.kokhan@globallogic.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 20 Mar 2019 16:23:28 -0700 Daniel Walker <danielwa@cisco.com> wrote:

> On Wed, Mar 20, 2019 at 03:53:19PM -0700, Andrew Morton wrote:
> > On Tue, 19 Mar 2019 16:24:45 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> > 
> > > This code allows architectures to use a generic builtin command line.
> > 
> > I wasn't cc'ed on [2/4].  No mailing lists were cc'ed on [0/4] but it
> > didn't say anything useful anyway ;)
> > 
> > I'll queue them up for testing and shall await feedback from the
> > powerpc developers.
> > 
> 
> You weren't CC'd , but it was To: you,
> 
>  35 From: Daniel Walker <danielwa@cisco.com>
>  36 To: Andrew Morton <akpm@linux-foundation.org>,
>  37         Christophe Leroy <christophe.leroy@c-s.fr>,
>  38         Michael Ellerman <mpe@ellerman.id.au>,
>  39         Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
>  40         linuxppc-dev@lists.ozlabs.org, Frank Rowand <frowand.list@gmail.com>
>  41 Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>  42 Subject: [PATCH 2/4] drivers: of: generic command line support

hm.

> Thanks for picking it up.

The patches (or some version of them) are already in linux-next,
which messes me up.  I'll disable them for now.

