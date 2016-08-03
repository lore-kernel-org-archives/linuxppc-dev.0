Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s450t5bJjzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 17:53:33 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Wed, 03 Aug 2016 09:52:23 +0200
Message-ID: <1944325.MtNrGQyQle@wuerfel>
In-Reply-To: <20160803102324.6372e66a@canb.auug.org.au>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <20160802220243.GK3296@wotan.suse.de>
 <20160803102324.6372e66a@canb.auug.org.au>
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

On Wednesday, August 3, 2016 10:23:24 AM CEST Stephen Rothwell wrote:
> Hi Luis,
> 
> On Wed, 3 Aug 2016 00:02:43 +0200 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> >
> > Thanks for the confirmation. For how long is it known this is broken?
> > Does anyone care and fix these ? Or is this best effort?
> 
> This has been broken for many years 
> 
> I have a couple of times almost fixed it, but it requires that we
> change from using "ld -r" to build the built-in.o objects and some
> changes to the powerpc head.S code ... I will give it another shot now
> that the merge window is almost over (and linux-next goes into its
> quieter time).

Using a different way to link the kernel would also help us with
the remaining allyesconfig problem on ARM, as the problem is only in
'ld -r' not producing trampolines for symbols that later cannot get
them any more. It would probably also help building with ld.gold,
which is currently not working.

What is your suggested alternative?

	Arnd
