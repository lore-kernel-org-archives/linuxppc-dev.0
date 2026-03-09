Return-Path: <linuxppc-dev+bounces-17877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077D9EA8558
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 05:20:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTlht3F66z3bnm;
	Mon, 09 Mar 2026 16:20:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773033646;
	cv=none; b=kET1PMhMbBXHK7W1Kpp7w5TDtHH9M78rSQoSXKI8KpdmwGMMcRhsbUnjJBmz3tS5Xxn0OAcltaIDiPmqvMYvrQFqDXGKAQhPWVSegu+KHhLRQxe2cbQUeQQgH7y66nSm7+ION6PWbDW7gwRKj5kt+1yIoLElcq59LKiWsc8oV13jazqhtUS5Zr0RXD6w2SFUVbb1hInnJz1VLnYL4TZ7WniWPq6wFes+iUa0ruhp5tQ33gn5i5OxYBqTywZAoS7HWKuJdvhkNSbgOOGOE9KShCXiU1/Ou7D/gHMdXz0pyo1oM5pc05hAB/Sv4mMc+IYAVi8ZDlIOUJ6T3zfSZujjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773033646; c=relaxed/relaxed;
	bh=GYxXHJAUoEft+ukHvIOWUDSdqul5umEHp08LGsOMZic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1vwYkRl3cIx12weeNEek/OJJKexBsLiQbfA2DTFKRi3bgK0cT2Ef4h6H5KfejyOIJQh3JUe1beXQ4H7W2y6uN6vd6pVOyePaobiHg4D9cvyIM6vEUnSF656UbryJZegfjQ3sBprAp5//AIGe0m4R+yrxb2tIdjDybB2NsDu53PZ+S2lPmebrLcka2tPdG0cibp4ig1dEAaZYaEA0qZoTEG+xFcjzBKkJS7r41MBqCnBoJs/wb+KELtdXu4ZV65n6Cn/3YQ3w74/ygidUAlWS/ZPzjYgKHz+P+A2xp0r6GiDmrx1HqNZQDXXNmJbTOKcNX9wyC60UwqZN6l1EI4xMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Mlc7EsE4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Mlc7EsE4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTlhs0sFcz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 16:20:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0223E600AD;
	Mon,  9 Mar 2026 05:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14901C4CEF7;
	Mon,  9 Mar 2026 05:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773033641;
	bh=FS2i29kMamMTD50UjT5XoJKxEGOFFM6i/0fwpn6znmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mlc7EsE4X+wfssChkP8CkIXLdXZzl6+V/Galgzpkz2mQ4D5ArZfb7/h2GQY29FMZP
	 1eaBjJtv3Zgj5LxMPhVPBCbOlTFvOZ3T7ygrMDR4osGl1dIv4ykS3EOKMDC04keDhk
	 tbz4danL/fWORo/SJQj7It7/IwTZ2Cwfoq5GGv/U=
Date: Mon, 9 Mar 2026 06:20:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Kees Cook <kees@kernel.org>, Haren Myneni <haren@linux.ibm.com>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: vas-api: constify dynamic struct class in
 coproc api register
Message-ID: <2026030945-varied-spouse-861c@gregkh>
References: <20260308123917.1013607-1-jkoolstra@xs4all.nl>
 <2026030846-wince-recess-c338@gregkh>
 <1567347751.876335.1773008140595@kpc.webmail.kpnmail.nl>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567347751.876335.1773008140595@kpc.webmail.kpnmail.nl>

On Sun, Mar 08, 2026 at 11:15:40PM +0100, Jori Koolstra wrote:
> 
> > Op 08-03-2026 17:19 CET schreef Greg KH <gregkh@linuxfoundation.org>:
> > 
> >  
> > On Sun, Mar 08, 2026 at 01:39:12PM +0100, Jori Koolstra wrote:
> > > diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> > > index 9f093176b8db..34403582c895 100644
> > > --- a/arch/powerpc/platforms/powernv/vas-window.c
> > > +++ b/arch/powerpc/platforms/powernv/vas-window.c
> > > @@ -1459,7 +1459,6 @@ static const struct vas_user_win_ops vops =  {
> > >  int vas_register_api_powernv(struct module *mod, enum vas_cop_type cop_type,
> > >  			     const char *name)
> > >  {
> > > -
> > >  	return vas_register_coproc_api(mod, cop_type, name, &vops);
> > >  }
> > >  EXPORT_SYMBOL_GPL(vas_register_api_powernv);
> > > 
> > 
> > This change wasn't needed here :(
> > 
> > thanks,
> > 
> > greg k-h
> 
> My bad, I meant to copy this here instead of at the top of me last email:
> 
> Now checkpatch complains that:
> 
> CHECK: Blank lines aren't necessary after an open brace '{'

That's true, but don't mix patches together, and usually, for code
outside of drivers/staging/ don't worry about checkpatch issues.

> So the rule is: don't touch white space unless you absolutely have to?
> 
> That is good to know to prevent silly v2's. I know that non-functional
> changes are frowned upon; but you also shouldn't sneak in a white space
> fixes?

Exactly, don't sneak in anything :)

thanks,

greg k-h

