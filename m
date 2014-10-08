Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7E041A185A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 11:45:29 +1100 (EST)
Message-ID: <1412729129.4133.2.camel@ale.ozlabs.ibm.com>
Subject: Re: [v3,12/16] cxl: Add base builtin support
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 08 Oct 2014 11:45:29 +1100
In-Reply-To: <20141007230416.2040C14011E@ozlabs.org>
References: <20141007230416.2040C14011E@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 imunsie@au.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anton@samba.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-08 at 10:04 +1100, Michael Ellerman wrote:
> On Tue, 2014-07-10 at 10:48:18 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > This adds the base cxl support that needs to be build into the kernel t=
o use
> > cxl as a module. This is needed so that the cxl call backs from the cor=
e
> > powerpc mm code always exist irrespective of if the cxl module is loade=
d or
> > not. This is similar to how cell works with CONFIG_SPU_BASE.
> >=20
> > This adds a cxl_slbia() call (similar to spu_flush_all_slbs()) which ch=
ecks for
> > the cxl module being loaded. If the modules is not loaded we return, ot=
herwise
> > we call into the cxl SLB invalidation code.
> >=20
> > This also adds the cxl_ctx_in_use() function for use in the mm code to =
see if
> > any cxl contexts are currently in use. This is used by the tlbie() to
> > determine if it can do local TLB invalidations or not. This also adds g=
et/put
> > calls for the cxl driver module to refcount the active cxl contexts.
>=20
> This last paragraph is no longer true.

Yep, thanks.  I'll move it to patch 7 where it does apply.

Mikey
