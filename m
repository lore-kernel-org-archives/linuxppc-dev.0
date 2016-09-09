Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVq0j5sh2zDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 17:42:12 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/5] powerpc/cell: drop unused iic_get_irq_host()
Date: Fri, 09 Sep 2016 09:42:06 +0200
Message-ID: <4412383.iXkqCAodFZ@wuerfel>
In-Reply-To: <87wpildhsa.fsf@possimpible.ozlabs.ibm.com>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
 <6411576.kd9HS3NQth@wuerfel> <87wpildhsa.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, September 9, 2016 10:43:33 AM CEST Daniel Axtens wrote:
> Hi Arnd,
> 
> > I'm currently experimenting with a patch that adds -Wmissing-declaration to
> > the normal kernel CFLAGS for everyone, and fixing up the warnings I get with
> > that on ARM.
> >
> > Are you looking at all the powerpc specific code? If we can catch all the
> > existing warnings for some of the major architectures, we can hopefully
> > enable this in the mainline kernel at some point so we don't need sparse
> > for it any more.
> 
> At the moment I'm just trying to squash sparse warnings on powerpc. This
> particular catch came from making something static via a dodgy python
> script and then Andrew finding it was EXPORTed. Removing the EXPORT
> threw the warning - so it's a bit more complex than just a sparse
> warning.

I think we just need to pick one of these three cases each time
we see the warning:

- if it's used elsewhere, include the correct header
- if it's not used at all, remove the function
- if it's only used in the same file, make it static.
- if it's exported, decide whether to add a declaration in a
  header or remove the function along with the export.

> I think powerpc has the missing prototype warnings enabled and -Werror
> as well.

All architectures have -Wstrict-prototypes enabled, but not
-Wmissing-prototypes, -Wmissing-declarations or
-Wmissing-variable-declarations, which are similar to what sparse
does.

	Arnd
