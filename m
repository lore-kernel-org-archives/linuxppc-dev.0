Return-Path: <SRS0=KC/l=27=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB2DC282DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jan 2020 17:11:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090532072E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jan 2020 17:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090532072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47vTzp61npzDqk5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jan 2020 04:11:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=mit.edu
 (client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mit.edu
X-Greylist: delayed 205 seconds by postgrey-1.36 at bilbo;
 Sat, 11 Jan 2020 04:10:00 AEDT
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47vTxh4FJZzDqcm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2020 04:09:58 +1100 (AEDT)
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com
 [104.133.0.111] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00AH5xC3031814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 12:06:00 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 9E7ED4207DF; Fri, 10 Jan 2020 12:05:59 -0500 (EST)
Date: Fri, 10 Jan 2020 12:05:59 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Message-ID: <20200110170559.GA304349@mit.edu>
References: <20200110145422.49141-1-broonie@kernel.org>
 <20200110155153.GG19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110155153.GG19453@zn.tnic>
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

On Fri, Jan 10, 2020 at 04:51:53PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 02:54:12PM +0000, Mark Brown wrote:
> > This is a resend of a series from Richard Henderson last posted back in
> > November:
> > 
> >    https://lore.kernel.org/linux-arm-kernel/20191106141308.30535-1-rth@twiddle.net/
> > 
> > Back then Borislav said they looked good and asked if he should take
> > them through the tip tree but things seem to have got lost since then.
> 
> Or, alternatively, akpm could take them. In any case, if someone else
> ends up doing that, for the x86 bits:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Or I can take them through the random.git tree, since we have a lot of
changes this cycle going to Linus anyway.  Any objections?

	     	   	    	  	   - Ted
