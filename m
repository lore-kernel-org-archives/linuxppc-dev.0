Return-Path: <SRS0=u30M=3O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30112C2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jan 2020 17:48:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0782071A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jan 2020 17:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0782071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 484k5T4J8jzDqWN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jan 2020 04:48:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=mit.edu
 (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mit.edu
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484k3h0vBBzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jan 2020 04:47:10 +1100 (AEDT)
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com
 [67.53.201.206]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00PHkXAB020640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jan 2020 12:46:36 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 24C63420324; Sat, 25 Jan 2020 12:46:33 -0500 (EST)
Date: Sat, 25 Jan 2020 12:46:33 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Message-ID: <20200125174633.GN1108497@mit.edu>
References: <20200110145422.49141-1-broonie@kernel.org>
 <20200110155153.GG19453@zn.tnic> <20200110170559.GA304349@mit.edu>
 <20200120172627.GH6852@sirena.org.uk>
 <20200120175901.GB576@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120175901.GB576@zn.tnic>
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 herbert@gondor.apana.org.au, x86@kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Brown <broonie@kernel.org>, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 20, 2020 at 06:59:01PM +0100, Borislav Petkov wrote:
> On Mon, Jan 20, 2020 at 05:26:27PM +0000, Mark Brown wrote:
> > I think the important thing here is that *someone* takes the patches.
> > We've now got Ted and Borislav both saying they're OK applying the
> > patches, an additional proposal that Andrew takes the patches, nobody
> > saying anything negative about applying the patches and yet the patches
> > are not applied.  The random tree sounds like a sensible enough tree to
> > take this so if Ted picks them up perhaps that's most sensible?
> 
> Yes, Ted, pls pick them up so that we're done with this.

I've picked them up and pushed them to the random tree.

     	    	    	       	       - Ted
