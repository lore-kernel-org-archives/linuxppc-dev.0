Return-Path: <linuxppc-dev+bounces-18042-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24211FD0658
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 08:24:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW3gh3F69z3f1M;
	Wed, 11 Mar 2026 19:24:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773217456;
	cv=none; b=R6TBF31bTVWkPeMiCRZeckD3kUs+eFtbKbPs9H2tEDsKVyRCoRDwfQZbjalGkYsWAjlqZr+1lgfmMCTOG+EV9vucHq03VKZr1t8l7GHJ1sHvTC1vEilLxEhivgbqnmE81EoqZ/gmSgXbfjc2C1A92CAw/94Pc8Rv4cYOK87sX9fC7n1JxPjG8ZTjtE+GosuS3GIve4gpX7kzhlRACVjirSQGElr1sqDsfLNWgJEPpe1MaX07eiZy7Q3NLLxKiAWQhjbe2LHRkze2ALXhCeqOdzaeSDNUM06PGTVLsZmjnZTzlzxD5w+G+yJWI3V/A5LD5eVhVY1wkAtvodLJz+3KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773217456; c=relaxed/relaxed;
	bh=Bddz08RrWbh2g0l0r7J+jQHntnapD5Pp78lMmMEUgtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDZVLmpu9lXaX10oWudPXvrvOd3M+j/BOwIFdZpYgC9ClEwHN4lhNhPbQozDXnnR3VyVfspunP0M0KrySDk2oa5ikeFajMVQfFun2yvcXAWRHZYhaQdXgVD1/BSeSG9BVJ7mQpr0PBU0OzhyRr9RjextekOR1waeRkaMtN84mEzbz2Tl3qp9xiVSWTBnjrsBeAK0bgLMUEAn7a4anckQbDeEwopKCVEQaJi+fH5sxzK6TZyaQKdYI8SV+cb8/6UVbll1nfF6ZV3HB2w1ONrNle3F5H1TH/wfZdFQqTGSGBiJ9kn8sDLKyXWBLG9+DP0b/64yoMNb5gYbcGzFXURF4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eeqNaROk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=eeqNaROk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW3gf524Lz3f1K
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 19:24:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DB588418F9;
	Wed, 11 Mar 2026 08:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C5C4CEF7;
	Wed, 11 Mar 2026 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773217451;
	bh=dv8CapPcHU2C+UPdJ63rwR82PJQ9Lvi9bsHcC34LSxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeqNaROkc36vhuZZvSHJDPoiwMb29CQf/insgW+qVaDb/gFgmswjWF2SZd+7L8z8L
	 kx11nJQ0ipmrz0Hjp4oRfs24ig+jQpI2SjsdFFEDe3tPIhX+AQB4NGDdQJd0VisiKj
	 LYNOD37oD2DdiJsPkp0zAjFb0lQ0vnKa3bT0UonE=
Date: Wed, 11 Mar 2026 09:23:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Jonathan Greental <yonatan02greental@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc: vas-api: constify dynamic struct class in
 coproc api register
Message-ID: <2026031154-labored-frivolous-154b@gregkh>
References: <20260308214634.1215051-1-jkoolstra@xs4all.nl>
 <2026030924-penniless-hermit-ffc0@gregkh>
 <1304966204.915283.1773053337271@kpc.webmail.kpnmail.nl>
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
In-Reply-To: <1304966204.915283.1773053337271@kpc.webmail.kpnmail.nl>

On Mon, Mar 09, 2026 at 11:48:57AM +0100, Jori Koolstra wrote:
> My bad, the earlier email went out to soon.
> 
> > Op 09-03-2026 07:01 CET schreef Greg KH <gregkh@linuxfoundation.org>:
> > >  arch/powerpc/platforms/book3s/vas-api.c | 34 +++++++++++++++++++------
> > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
> > > index ea4ffa63f043..e377981fd533 100644
> > > --- a/arch/powerpc/platforms/book3s/vas-api.c
> > > +++ b/arch/powerpc/platforms/book3s/vas-api.c
> > > @@ -45,7 +45,7 @@ static struct coproc_dev {
> > >  	struct device *device;
> > >  	char *name;
> > >  	dev_t devt;
> > > -	struct class *class;
> > > +	const struct class *class;
> > >  	enum vas_cop_type cop_type;
> > >  	const struct vas_user_win_ops *vops;
> > >  } coproc_device;
> > > @@ -599,6 +599,21 @@ static struct file_operations coproc_fops = {
> > >  	.unlocked_ioctl = coproc_ioctl,
> > >  };
> > >  
> > > +static const struct class nx_gzip_class = {
> > > +	.name		= "nx-gzip",
> > > +	.devnode	= coproc_devnode
> > > +};
> > > +
> > > +static const struct class* cop_to_class(enum vas_cop_type cop)
> > > +{
> > > +	switch (cop) {
> > > +	case VAS_COP_TYPE_GZIP:		return &nx_gzip_class;
> > > +	default:
> > > +		pr_err("No device class defined for cop type %d\n", cop);
> > > +		return NULL;
> > > +	}
> > > +}
> > > +
> > >  /*
> > >   * Supporting only nx-gzip coprocessor type now, but this API code
> > >   * extended to other coprocessor types later.
> > > @@ -609,6 +624,10 @@ int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
> > >  {
> > >  	int rc = -EINVAL;
> > >  	dev_t devno;
> > > +	const struct class* class = cop_to_class(cop_type);
> > > +
> > > +	if (!class)
> > > +		return rc;
> > 
> > How can this happen?
> > 
> > This feels odd, are different types of devices being registered here?  I
> > don't see where VAS_COP_TYPE_GZIP was being tested in the original code,
> > why add this additional logic?
> > 
> 
> My line of thought is this:
> 
> There is a function vas_register_coproc_api() that does some kind of registering
> for different coprocessor types. It has the following comment above:
> 
> /*
>  * Supporting only nx-gzip coprocessor type now, but this API code
>  * extended to other coprocessor types later.
>  */

I guess "later" never happened :(

> If you look at where this function is eventually triggered it is indeed only ever
> passed VAS_COP_TYPE_GZIP. For instance, line 1238 of drivers/crypto/nx/nx-common-series.c
> has the call
> 
> 	ret = vas_register_api_pseries(THIS_MODULE, VAS_COP_TYPE_GZIP,
> 				       "nx-gzip");
> 
> (which immediately calls vas_register_coproc_api())
> 
> It also passes a hard-coded name for the device ("nx-gzip"), and this name is also
> used as the device class name. Now, this is a problem if we want to get rid of
> class_create(). Somehow "nx-gzip" needs to get linked to the appropriate const struct
> class. I figured it is better to use the cop_type, and a cop_to_class() function to
> set this link. However, since the other co-processor types are not implemented (yet)
> it would seem silly to already assign struct classes for these, hence the NULL return.
> It is meant to signal: not implemented. Then again, if ever a new co-processor was added
> you must update the cop_to_class()... but at least this is my line of thought.
> 
> There is also a function static char *cop_to_str(int cop) that strangely takes
> an int instead of an enum vas_cop_type, and also misses an option I think.

Ok, I'll defer to the maintainer here, as it's their code, and seems to
not follow the "normal" style of handling classes.

thanks,

greg k-h

