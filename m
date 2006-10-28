Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3485067D56
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 17:24:04 +1000 (EST)
Subject: Re: Is get_property() correct?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
References: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 17:23:55 +1000
Message-Id: <1162020235.25682.124.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-10-28 at 00:41 -0600, Grant Likely wrote:
> Is the implementation of get_property correct?  The comment says it
> returns the value of a property; but the return statement just returns
> the property pointer (cast as void*) it got from of_find_property();
> not the value.
> 
> Does the comment or the code need to change?

Well considering that we don't know the type of the property value, the
best we can do is return a pointer to it ... 

The comment might want an update, though it never stroke me as confusing
but heh :)

> in prom.c:
> 
> /*
>  * Find a property with a given name for a given node
>  * and return the value.
>  */
> const void *get_property(const struct device_node *np, const char *name,
>                          int *lenp)
> {
>         struct property *pp = of_find_property(np,name,lenp);
>         return pp ? pp->value : NULL;
> }
> EXPORT_SYMBOL(get_property);
> 
> Cheers,
> g.
> 
