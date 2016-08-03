Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4Nnc5mRXzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 05:44:52 +1000 (AEST)
Date: Wed, 3 Aug 2016 14:44:29 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Fengguang Wu <fengguang.wu@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160803194429.GA14627@gate.crashing.org>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <5216072.9VpDc0iy8Q@wuerfel> <20160804013729.7fffa45a@roar.ozlabs.ibm.com>
 <3892328.nUGXIq3MaH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3892328.nUGXIq3MaH@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Wed, Aug 03, 2016 at 08:52:48PM +0200, Arnd Bergmann wrote:
> From my first look, it seems that all of lib/*.o is now getting linked
> into vmlinux, while we traditionally leave out everything from lib/
> that is not referenced.
> 
> I also see a noticeable overhead in link time, the numbers are for
> a cache-hot rebuild after a successful allyesconfig build, using a
> 24-way Opteron@2.5Ghz, just relinking vmlinux:
> 
> $ time make skj30 vmlinux # before
> real	2m8.092s
> user	3m41.008s
> sys	0m48.172s
> 
> $ time make skj30 vmlinux # after
> real	4m10.189s
> user	5m43.804s
> sys	0m52.988s

Is it better when using rcT instead of rcsT?


Segher
