Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4ABF92C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 00:05:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 00/10] uaccess: better might_sleep/might_fault behavior
Date: Wed, 22 May 2013 16:04:48 +0200
References: <cover.1368702323.git.mst@redhat.com>
 <201305221125.36284.arnd@arndb.de>
 <20130522134124.GD18614@n2100.arm.linux.org.uk>
In-Reply-To: <20130522134124.GD18614@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201305221604.49185.arnd@arndb.de>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
 linux-am33-list@redhat.com, Hirokazu Takata <takata@linux-m32r.org>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, microblaze-uclinux@itee.uq.edu.au,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 22 May 2013, Russell King - ARM Linux wrote:
> On Wed, May 22, 2013 at 11:25:36AM +0200, Arnd Bergmann wrote:
> > Given the most commonly used functions and a couple of architectures
> > I'm familiar with, these are the ones that currently call might_fault()
> > 
> >                       x86-32  x86-64  arm     arm64   powerpc s390    generic
> > copy_to_user          -       x       -       -       -       x       x
> > copy_from_user        -       x       -       -       -       x       x
> > put_user              x       x       x       x       x       x       x
> > get_user              x       x       x       x       x       x       x
> > __copy_to_user        x       x       -       -       x       -       -
> > __copy_from_user      x       x       -       -       x       -       -
> > __put_user            -       -       x       -       x       -       -
> > __get_user            -       -       x       -       x       -       -
> > 
> > WTF?
> 
> I think your table is rather screwed - especially on ARM.  Tell me -
> how can __copy_to_user() use might_fault() but copy_to_user() not when
> copy_to_user() is implemented using __copy_to_user() ?  Same for
> copy_from_user() but the reverse argument - there's nothing special
> in our copy_from_user() which would make it do might_fault() when
> __copy_from_user() wouldn't.

I think something went wrong with formatting of the tabstobs in
the table. I've tried to correct it above to the same version I
see on the mailing list.

> The correct position for ARM is: our (__)?(pu|ge)t_user all use
> might_fault(), but (__)?copy_(to|from)_user do not.  Neither does
> (__)?clear_user.  We might want to fix those to use might_fault().

Yes, that sounds like a good idea, especially since they are all
implemented out-of-line.

For __get_user()/__put_user(), I would probably do the reverse and make
them not call might_fault() though, like we do on most other architectures:

Look at the object code produced for setup_sigframe for instance, it calls
might_fault() around 25 times where one should really be enough. Using
__put_user() instead of put_user() is normally an indication that the
author of that function has made performance considerations and move the
(trivial) access_ok() call out, but now we add a more expensive
call instead.

	Arnd
