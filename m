Return-Path: <SRS0=S2bx=J6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21CC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 18:07:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1891C611AC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 May 2021 18:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1891C611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FYrXw4s6sz30F9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 04:07:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport header.b=EJWaRFAb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cisco.com (client-ip=173.37.142.92; helo=alln-iport-5.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256
 header.s=iport header.b=EJWaRFAb; dkim-atps=neutral
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FYrXN5BCbz2xZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 04:07:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=993; q=dns/txt; s=iport;
 t=1620065220; x=1621274820;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7X2Sx/02p8jds+5OouAKIoXCEMD74/3FvpAFk7V449g=;
 b=EJWaRFAbJYC6YW6/IkWGnfCJV4hMsZ4AJOcTOgTbiuWFAVVkXA9UX49P
 jpaqAB/AHsTnrEdIrz9vq4CwiM0bFDw5FcHY5iPu4WtEXjBROmbO7s7Ac
 an3e+cw1fUmj5lvErwcAf5figNGsz+N7yUw21M/ASMvv1pQvnexnhDtpi w=;
X-IPAS-Result: =?us-ascii?q?A0ABAACVOpBgmIkNJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUMEAQEBAQELAYMhVgE5MYxoiVKQG4pkgXwLAQEBD?=
 =?us-ascii?q?QEBKAwEAQGBFgGCdT8DAgKBewIlNAkOAgQBAQEDAgMBAQEBAQUBAQECAQYEF?=
 =?us-ascii?q?AEBAQEBAQEBaIVQDYZFAQUyAUYQCxguPBsGgwQBgwcPqBt4gTSBAYNcQYQOg?=
 =?us-ascii?q?T4GFA+BFwGNXyccgUlChDc+gmABAgGHVgSBZYIaAoFMgSiRHI03nD6DGoEom?=
 =?us-ascii?q?3Y3EKUSLbhiAgQGBQIWgVQ4gVszGggbFYMkUBkOjjiIa4VpIQMvAjYCBgoBA?=
 =?us-ascii?q?QMJjQ8BAQ?=
IronPort-HdrOrdr: A9a23:UuRB3K4c3ftbjkInKwPXwbKBI+orLtY04lQ7vn1ZYxY9SKOlvu
 qpm+kW0gKxpTYKQXc7mc2BPq7oewK4ybde544NMbC+GDT8sGyzI414qafkyTvsGyrxn9QtsZ
 tIWa54FdH2EBxGnd/3iTPIceoI7dGb/MmT79v24GxqSWhRBp1IzwA8MQqDF10zeQ8uP+tfKL
 O5xu5q4wWtYm4WaMPTPAhnY8Hmq8fQnJzrJT4qbiRH1CC0gTml6KH3HnGjt390bxp1zbgv6m
 TDmQDij5/Cj9iA1hTe22XPhq45pPLdzLJ4aPCku4w8Nijrzj2lfp1mXKeP+Aooufi15Ewx+e
 O8xSsIDoBU927beH2zrF/L3QTtuQxek0PK+Bu/nWbpp9D/SXYBL/d5wahdchff9iMbzahB7J
 4=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,270,1613433600"; d="scan'208";a="708392964"
Received: from alln-core-4.cisco.com ([173.36.13.137])
 by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 03 May 2021 18:06:57 +0000
Received: from zorba ([10.24.21.191])
 by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 143I6tWd008213
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 May 2021 18:06:56 GMT
Date: Mon, 3 May 2021 11:06:54 -0700
From: Daniel Walker <danielwa@cisco.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] lib: early_string: allow early usage of some string
 functions
Message-ID: <20210503180654.GP3844417@zorba>
References: <20210430042217.1198052-1-danielwa@cisco.com>
 <dc26a67e-dba0-1b8c-3718-3c75415c61f1@csgroup.eu>
 <1929b3a8-f882-c930-4b99-10c6a8f127c7@csgroup.eu>
 <e355ecc9-574a-dbcb-7864-5aa4974e1971@csgroup.eu>
 <20210503180141.GO3844417@zorba>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503180141.GO3844417@zorba>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.21.191, [10.24.21.191]
X-Outbound-Node: alln-core-4.cisco.com
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
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 xe-linux-external@cisco.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 03, 2021 at 11:01:41AM -0700, Daniel Walker wrote:
> On Sat, May 01, 2021 at 09:31:47AM +0200, Christophe Leroy wrote:
> > 
> > > In fact, should be like in prom_init today:
> > > 
> > > #ifdef __EARLY_STRING_ENABLED
> > >      if (dsize >= count)
> > >          return count;
> > > #else
> > >      BUG_ON(dsize >= count);
> > > #endif
> > 
> > Thinking about it once more, this BUG_ON() is overkill and should be
> > avoided, see https://www.kernel.org/doc/html/latest/process/deprecated.html
> > 
> > Therefore, something like the following would make it:
> > 
> > 	if (dsize >= count) {
> > 		WARN_ON(!__is_defined(__EARLY_STRING_ENABLED));
> > 
> > 		return count;
> > 	}
> 
> I agree, it's overkill it stop the system for this condition.
> 
> how about I do something more like this for my changes,
> 
> 
> > 	if (WARN_ON(dsize >= count && !__is_defined(__EARLY_STRING_ENABLED)))
> > 		return count;

I'll have to work on this one..

Daniel
