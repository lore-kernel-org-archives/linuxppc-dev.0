Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E85C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 09:56:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057A620869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNlh4KOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057A620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43phj7089qzDqP6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=acme@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="NNlh4KOP"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43phdW5rh5zDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 20:53:19 +1100 (AEDT)
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F36DA2183F;
 Tue, 29 Jan 2019 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548755598;
 bh=Dv5WAWwxOjJCOSKBm3bcnreU0q5AdFFEetxZtFvCwIM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NNlh4KOPRq2ZBJL3NKoxQ0U5wDXEmYiiKIqqU7rAjeOyMivEcLwdQO+L2QGUrhQmw
 CxI+KYnHDMT9uA++yWaV4AU55nY5s5SDr0uzn9PwepQzEg8WhTlUANxOJvGoe3Ogq1
 iDtg+GvbK/xYczsf1UqZkDhu6GVYKwzMy1q7CbY4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id DDD7A4034F; Tue, 29 Jan 2019 10:53:15 +0100 (CET)
Date: Tue, 29 Jan 2019 10:53:15 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] perf mem/c2c: Fix perf_mem_events to support powerpc
Message-ID: <20190129095315.GH4344@kernel.org>
References: <20190114041402.14033-1-ravi.bangoria@linux.ibm.com>
 <f308ef3e-f34b-6000-8826-27bdf8c3704e@linux.ibm.com>
 <874l9rsson.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l9rsson.fsf@concordia.ellerman.id.au>
X-Url: http://acmel.wordpress.com
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
Cc: dzickus@redhat.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, fowles@inreach.com,
 linux-kernel@vger.kernel.org, jmario@redhat.com, namhyung@kernel.org,
 jolsa@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Tue, Jan 29, 2019 at 08:45:44PM +1100, Michael Ellerman escreveu:
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
> 
> > On 1/14/19 9:44 AM, Ravi Bangoria wrote:
> >> Powerpc hw does not have inbuilt latency filter (--ldlat) for mem-load
> >> event and, perf_mem_events by default includes ldlat=30 which is
> >> causing failure on powerpc. Refactor code to support perf mem/c2c on
> >> powerpc.
> >> 
> >> This patch depends on kernel side changes done my Madhavan:
> >> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html
> >> 
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >
> >
> > Arnaldo / Michael, Any thoughts?
> 
> I haven't merged the kernel patch, I think because Maddy told me not to
> because it would break the userspace tooling :)
> 
> What is the actual dependency between them? ie. should we merge the
> kernel fix first or second or what?

I think its just a tooling side, I haven't processed it because I'm
waiting for Ravi to address Jiri's comment, after that I'm happy to put
it in my perf/urgent branch that I'm brewing to push to Ingo today or
tomorrow.

- Arnaldo
