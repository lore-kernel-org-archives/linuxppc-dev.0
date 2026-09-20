Return-Path: <linuxppc-dev+bounces-27796-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E62AC982D8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2026 17:43:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hntxR3jK9z2y8c;
	Mon, 21 Sep 2026 03:43:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789926187;
	cv=none; b=hfC3KsyBzQcHHun1N/c7leAI7L3i+xGwP1ELdpBzMFlWJTTLBSXHIZhvMw8Nrb6LlMWY707264hK4L+Mhb5J3HxOmdnXWQOvAUL8/mxy7aiRmn/nmVUxLBA+u5Y6S0Wsm66yxHcceKS8bv76c0Q2748G/epU/YxYnK1eXavdnihRENHyulXsmggEAt05deqfrTyF2wECSYcimy4czdWrD9EEDVPQzfAakBllvTKNxcMwi+rkjzDucDP+xvL3Y8zPM5CqSARA2JIm8sqPfgMPT2yDBHpK6l8W1eVTto3K3baJvH4+vRxEOpjkmVNS/g1/ylopL9Wqww6mi7RGzjE1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789926187; c=relaxed/relaxed;
	bh=gCLm8+Efx9s+fwHTecUHn46iwQu/QjUqg79TBziXlTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzkEC4mzuu270t6YTKfHawiuuyDKjtYbcKobTgW2lnjCJ+X23Ub3aU1oUP/lIjRm4G98lCe2ulX2QRk4N+UHFiUA6guwpVjjOe7WApaeCzsVsiCMbeumCGZV7WWepMPhZElodsU87T1O81ewgGO/5NkxMQMVZFnlXMecWHwOlNLxsFMrsrFlU7qUz4kSQAZhRvholWrnvmP3UxZsMlOSPAz7cwohvACiH76b/06KJJr69YXayUG2Rrkk0j2ML2By+GHoe9e/qc+tE8YsbE6nf9jyQ74XpBIcVa6AIwSfL7WG8wy0cr4taecmMDXWwNRFz3SBQHs+mPtgtahcXc9Krg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 465 seconds by postgrey-1.37 at boromir; Mon, 21 Sep 2026 03:43:06 AEST
Received: from linkmauve.fr (linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hntxQ19HFz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 03:43:06 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id BD5587189D4C; Sun, 20 Sep 2026 19:35:09 +0200 (CEST)
Date: Sun, 20 Sep 2026 19:35:09 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] powerpc/sstep: Fix compilation on 32-bit PowerPC
Message-ID: <arAZTed4p3FYnUgU@desktop>
References: <20260730065007.964703-1-linkmauve@linkmauve.fr>
 <3c39b0e5-8265-4d39-ab39-196ccf560a05@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c39b0e5-8265-4d39-ab39-196ccf560a05@kernel.org>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

On Thu, Jul 30, 2026 at 09:01:10AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 30/07/2026 à 08:50, Link Mauve a écrit :
> > Two local variables were only set but never read on 32-bit PowerPC,
> > which causes an error during compilation with W=1.
> > 
> > This series first makes the 64-bit guards consistent by converting all
> > uses of __powerpc64__ to use CONFIG_PPC64 instead, and then guard the
> > two variables rc and suffix behind CONFIG_PPC64 checks.
> > 
> 
> For the two patches,
> 
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

None of these two patches have made it to any kernel, do I need to ping
someone?  I was originally expecting it to reach 7.3, now I guess 7.4
will do.

> 
> > Link Mauve (2):
> >    powerpc/sstep: Consistently use one define to check arch bit width
> >    powerpc/sstep: Don’t define variables we won’t be using
> > 
> >   arch/powerpc/lib/sstep.c | 111 ++++++++++++++++++++-------------------
> >   1 file changed, 58 insertions(+), 53 deletions(-)
> > 
> > Changes since v1:
> > - Link to v1:
> >    https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinuxppc-dev%2Famrpdv0g__ELifId%40desktop%2FT%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C69210bfbc364426c4ce108deee06d0f2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639209910199709261%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2B%2BdoT%2FTkFxUUy63ED%2B5Kb5dfCSI8hQpjWGfpndI%2Fn0c%3D&reserved=0
> > - Switch from __powerpc64__ to CONFIG_PPC64, as it is the preferred
> >    check.
> > - Document that the build error was only occurring with W=1.
> > - Declare both variables on the same line.
> > 
> > base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
> 

Thanks,

-- 
Link Mauve

