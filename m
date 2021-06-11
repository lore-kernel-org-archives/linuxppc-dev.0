Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F40BC48BD1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 13:24:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D79A613CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 13:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D79A613CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1hQY658sz3c41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 23:24:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DsPjPdR/;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3WXO5EAE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.28; helo=smtp-out1.suse.de;
 envelope-from=dsterba@suse.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256
 header.s=susede2_rsa header.b=DsPjPdR/; 
 dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=3WXO5EAE; 
 dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1hQ34dsZz2xZH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 23:24:11 +1000 (AEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8CB8721994;
 Fri, 11 Jun 2021 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1623417847;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoZe2Do+YjFfznb3FBAGTMrmvEaWFCHdUpFU1G49nbI=;
 b=DsPjPdR/cfZoznWMhaKw2jCReQocGLnq0vEnJz7X8/bGQYVgpxy7wp95U5fUoz1M7KM78/
 lO2UK4i5tLunQSK1zEYRN1rTnR+kGQ05PFOwnRnWD6Fd6xeLJGkm/Jf2XaAB9oJSQApAgB
 F2wxrLlTZqOTDKnNZkF7+OqUsTJI2GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1623417847;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoZe2Do+YjFfznb3FBAGTMrmvEaWFCHdUpFU1G49nbI=;
 b=3WXO5EAErIRttTmkRzoLqskq1oqP9k1xWfNAPTGWce7kDcJB+FkFYeIsKAoU0vg9toUpFm
 f+ez2JLbfaxrODBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id 661FAA3BBB;
 Fri, 11 Jun 2021 13:24:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 43475DA7A2; Fri, 11 Jun 2021 15:21:22 +0200 (CEST)
Date: Fri, 11 Jun 2021 15:21:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
Message-ID: <20210611132121.GF28158@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Chris Mason <clm@fb.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
 <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
 <20210610162046.GB28158@suse.cz>
 <6769ED4C-15A8-4CFF-BF2B-26A5328257A0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6769ED4C-15A8-4CFF-BF2B-26A5328257A0@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dsterba@suse.cz" <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 11, 2021 at 12:58:58PM +0000, Chris Mason wrote:
> > On Jun 10, 2021, at 12:20 PM, David Sterba <dsterba@suse.cz> wrote:
> > On Thu, Jun 10, 2021 at 04:50:09PM +0200, Christophe Leroy wrote:
> >> Le 10/06/2021 à 15:54, Chris Mason a écrit :
> >>>> On Jun 10, 2021, at 1:23 AM, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > And there's no such thing like "just bump BTRFS_MAX_COMPRESSED to 256K".
> > The constant is part of on-disk format for lzo and otherwise changing it
> > would impact performance so this would need proper evaluation.
> 
> Sorry, how is it baked into LZO?  It definitely will have performance implications, I agree there.

lzo_decompress_bio:

309         /*
310          * Compressed data header check.
311          *
312          * The real compressed size can't exceed the maximum extent length, and
313          * all pages should be used (whole unused page with just the segment
314          * header is not possible).  If this happens it means the compressed
315          * extent is corrupted.
316          */
317         if (tot_len > min_t(size_t, BTRFS_MAX_COMPRESSED, srclen) ||
318             tot_len < srclen - PAGE_SIZE) {
319                 ret = -EUCLEAN;
320                 goto done;
321         }
