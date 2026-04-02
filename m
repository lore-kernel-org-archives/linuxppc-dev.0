Return-Path: <linuxppc-dev+bounces-19220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5937D3942D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 14:15:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmkQX2Jgjz2xls;
	Fri, 03 Apr 2026 01:15:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775139316;
	cv=none; b=BtZCnwzHl85PzoFYLOSHiSra1JrGymxt7LHDDJyinlJV+sU0ko+hnX4rPU21zC9g8Ut4H8JZkWwrexlFwJaMBgm5qxeEucwWFw1hlEww+FWwXoxSKbtCfobvHTabxLYULkn3pjHca3U2gGMEuJqdbgmsXf5P0NLISm48HlucqxyWel6qk2xQh11Y5jqgYJQNAqA9xcRkkITZzZeesN8RcwijPXWkvWjj6k+uL8wuBJfzQmcbp3crD4cZsFPSi4VtmlZqbITA52r5jLiFdp21XwBqwgbrZQpCedVAwMfZ8h7XOSnPHnSuQ4Aj1iaNGGHXMNELWQz5seFE3FcBx4Bnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775139316; c=relaxed/relaxed;
	bh=fX4bnEZ+NTUmoAohEDrEMEcCYKUzMsFUCpWMPE00lNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnHjbSsFSetk7V42ZoYEQorYeEMeR2LcUd0MhCuB9t5/glimRNzWEWzeqtJATqRbCL0qKvi2U+jQx3SdTKrjHTLe1NFXdjjkxMH9IV8EAR3b2s1/1ngrvyX0xfw5odhXDgYKtVMiNAHqihkTQP+InpIirVqJ2QyElVXQ/lPxqrEu9jFiPBh2oyk0VE7sgPAyJp3kghq+9hQ9RooKEZ8CaBLvIggsBKZtXRyYKO/IUiHC+Bi8dGhBwzA7r60ympKyo8NlD4manfSviKZZRPTBdkT6dcZWz3tMdpKmlZzZj0LrfA8+PV652hjFY13MeDKSJ3dNZ2NExo3AvsT/dAQvVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YDb3esco; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YDb3esco;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmkQV5Rz4z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 01:15:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 01AC540667;
	Thu,  2 Apr 2026 14:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8849DC116C6;
	Thu,  2 Apr 2026 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775139311;
	bh=DSFsK07pp9CczWuDq8jyFDglDK77ECRre6nIbvn9Bm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDb3escooxxf/ssZF3/sg6AdaWiPm5BZ8mR6e7mylmIXwlNpCMYCxLoQXlxoCesuT
	 9Q6zHTk940FRWS8f1nJejIhFDFf9TAXqvfVhCYGrqbqHB6neDrimeFyPY1rM9B2Np5
	 ER/O0BEyEZ2abPDWjuJodCmoqhb54ebY2e0KyO5Q=
Date: Thu, 2 Apr 2026 16:15:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Andrew Donnellan <andrew@donnellan.id.au>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Christophe Lombard <clombard@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Update ocxl maintainer details
Message-ID: <2026040203-preface-barley-7472@gregkh>
References: <20251210-ocxl-maintainer-status-v1-1-d73981866db9@linux.ibm.com>
 <7bc40b84-4f1a-453f-9040-4ceae4d7e638@linux.ibm.com>
 <09db4bdb-6c87-484a-a2c9-87a1a2af2a8a@donnellan.id.au>
 <65282bee-62e4-4411-adf2-17106104f744@linux.ibm.com>
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
In-Reply-To: <65282bee-62e4-4411-adf2-17106104f744@linux.ibm.com>

On Tue, Mar 31, 2026 at 02:15:54PM +0530, Madhavan Srinivasan wrote:
> 
> On 3/31/26 1:51 PM, Andrew Donnellan wrote:
> > On 12/11/25 00:53, Frederic Barrat wrote:
> > > 
> > > 
> > > Le 10/12/2025 à 11:49, Andrew Donnellan a écrit :
> > > > I am leaving IBM, and Fred isn't working on OpenCAPI either. Mahesh has
> > > > kindly agreed to take over as maintainer to review the odd fixes that
> > > > still come in, and he has plenty of powerpc-specific experience.
> > > > 
> > > > Add Mahesh as ocxl maintainer, remove Fred as a maintainer, and
> > > > downgrade
> > > > myself to reviewer using my personal email address.
> > > > 
> > > > Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> > > > ---
> > > 
> > > Thanks Andrew! It's in good hands with Mahesh!
> > > 
> > > Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> > 
> > Can we get this merged?
> 
> Gregkh,
> 
> can you pull this in
> 
> Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> or I can take this via powerpc too. Just wanted to check thanks.

I'll take it, thanks.

greg k-h

