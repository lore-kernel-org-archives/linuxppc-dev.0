Return-Path: <linuxppc-dev+bounces-25886-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8433BC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Aug 2026 19:25:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMpwN1XQXz2xnS;
	Sun, 16 Aug 2026 05:25:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::3b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786821940;
	cv=none; b=II17tqzmvYglH5PgkK+6rvenFCAbZBsy0sFnRA37Gv2Btxujr04TuKh05nvAZ/i5MOhDLp7+59DY/pkCjak+HpGIU6o8nqNSO7bc63vYOFABXdvFTl85JYmMDjj0JVG1mX4IuYnHc7gB+/0MwE2ebUUO5Oym2xURL7sRT48bXlGKQyapykK/nHleLNr9k+me12mrJQlSKtCf6S5xb1BHNQfa/WUH0OV4abhWN1XBkR+VTRqxlIqu+dIo0prTeWg08/oFDEWnVTeWKqDzMR+KqrU07aNoLesGZWQmsrRXWMUssl++YaWC1UeK3FcuXt3+lHePeTmwE9vcgBl40C0kxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786821940; c=relaxed/relaxed;
	bh=wDGkls3rbL+h9/jGYxDHUwi/1Owmx8SOKcN1B9dL9cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2uGqKIeULudkTF6tvyhrjtyFyrE0xw/YNIu2UIykQ02bFXGMVravfopjQTiloWMjndF5peaEDiFw+31qcDAwdm5WMm5UPEoiR44aNm3wYDc2PHahFmGEAwWqY4iGE2eYsMSr+0KuGq7ImK7A3jb6g52466F6p8KlgN4TiUnlNyy12PuA6PySmMjNiDRwbAEJidh327U+4BWNQeD2QJzjav7NUZdwrxtjQPxStzUqynpq5C/ZcqJovZhmM+Y8DLffoLic414GlIB6rAE3E8axVJUMs3j8pPFhYJYZS+QeS3F2kZJs7W2F6cxdvpYreKCB+vVV1WZGEUrEYgSflz5Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XKvQuslM; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::3b; helo=mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XKvQuslM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::3b; helo=mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 28826 seconds by postgrey-1.37 at boromir; Sun, 16 Aug 2026 05:25:33 AEST
Received: from mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMpwF1Syqz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 05:25:30 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=6Ju9cxsbKIzu4nS8o05SDUO/qtHPRUYljZsU/spdKGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786821907; v=1; x=1787426707;
 b=XKvQuslMpmArq1h2GC/neykYpl4NBFPEAsn9S8TsXZFpXXPgquCReJAWOSk8Z6gpuzyq2Vwb
 vfmU8rdVU5aefsvKzU4caBsMlCmkLWq0h9i4OaiecpzCymCHSLkmTXSqPrxH03r9+5jrHLZ04PC
 PqckOz+r2W4qnX0ENHBdnWwk=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: from linux.dev (62.216.208.217)
	by mta11.migadu.com with ESMTPS id 0a40309b412adbeb;
	Fri, 14 Aug 2026 14:46:57 +0000
X-Migadu-Flow: FLOW_OUT
Date: Fri, 14 Aug 2026 16:46:51 +0200
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fsl_rio: Use snprintf() in fsl_rio_setup()
Message-ID: <an8qW5UqKpyNVBo2@linux.dev>
References: <20260630144951.692473-2-thorsten.blum@linux.dev>
 <44f93c64-55e9-4240-bc2c-be49280219f9@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44f93c64-55e9-4240-bc2c-be49280219f9@kernel.org>

On Fri, Aug 14, 2026 at 02:26:24PM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 30/06/2026 à 16:49, Thorsten Blum a écrit :
> > While the current code works correctly, replace the unbounded sprintf()
> > with the safer snprintf() in fsl_rio_setup() to follow secure coding
> > best practices.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/powerpc/sysdev/fsl_rio.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
> > index eb55dabb4748..077c03cd93e4 100644
> > --- a/arch/powerpc/sysdev/fsl_rio.c
> > +++ b/arch/powerpc/sysdev/fsl_rio.c
> > @@ -612,7 +612,7 @@ static int fsl_rio_setup(struct platform_device *dev)
> >   				kfree(port);
> >   				continue;
> >   		}
> > -		sprintf(port->name, "RIO mport %d", i);
> > +		snprintf(port->name, sizeof(port->name), "RIO mport %d", i);
> 
> Are you sure it is correct ?
> 
> Shouldn't it be sizeof(port->name) - 1 ?

snprintf() takes the destination buffer size (including the NUL) as its
second argument, so sizeof(port->name) should be correct.

