Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxtXT5cR6zDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 18:42:17 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Helge Deller' <deller@gmx.de>, 'Sergey Senozhatsky'
 <sergey.senozhatsky.work@gmail.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Petr Mladek
 <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>, "James E . J . Bottomley"
 <jejb@parisc-linux.org>, Steven Rostedt <rostedt@goodmis.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Paul Mackerras <paulus@samba.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] [RFC] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Date: Wed, 20 Sep 2017 08:41:40 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD007AF31@AcuExch.aculab.com>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
 <20170918174432.4fksyzco2g6gczwe@intel.com>
 <20170918183902.GA30752@p100.box>
 <20170919020537.GA16991@jagdpanzerIV.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6DD007A0D0@AcuExch.aculab.com>
 <a7a0f1f6-781b-eba3-9b81-69b979503990@gmx.de>
In-Reply-To: <a7a0f1f6-781b-eba3-9b81-69b979503990@gmx.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Helge Deller
> Sent: 19 September 2017 21:08
...
> > Using 'unsigned long' for any kind of pointer is an accident
> > waiting do happen.
> > It also makes it difficult to typecheck the function calls.
> > Using 'void *' isn't any better.
> > Either a pointer to an undefined struct, or a struct containing
> > a single 'char' member, is likely to be safest.
>=20
> David, you might be right in most cases, but in this case I'd prefer
> unsigned long too. I think this will create the least amount of
> typecasts here.

I've not looked at the specifics case...

Another option is using a struct with a single member and
passing it by value.
This could be used for things like user-space pointers or
even errno values.
The only problem is old ABI where even small structures are
always passed by reference.

	David
