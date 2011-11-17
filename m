Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7FBB2B6FF5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 06:09:34 +1100 (EST)
Date: Fri, 18 Nov 2011 00:39:20 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 1/3] virtio_console:  Fix locking of vtermno.
Message-ID: <20111117190920.GD2873@amit-x200.redhat.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214458.28884.86759.stgit@miche.sea.corp.google.com>
 <877h37qo5z.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877h37qo5z.fsf@rustcorp.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, Miche Baker-Harvey <miche@google.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Anton Blanchard <anton@samba.org>, Mike Waychison <mikew@google.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Eric Northrup <digitaleric@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Fri) 11 Nov 2011 [14:57:20], Rusty Russell wrote:
> On Tue, 08 Nov 2011 13:44:58 -0800, Miche Baker-Harvey <miche@google.com> wrote:
> > Some modifications of vtermno were not done under the spinlock.
> > 
> > Moved assignment from vtermno and increment of vtermno together,
> > putting both under the spinlock.  Revert vtermno on failure.
> > 
> > Signed-off-by: Miche Baker-Harvey <miche@google.com>
> 
> Does it matter?  It's normal not to lock in a function called
> "init_XXX", since it's not exposed yet.
> 
> Or is it?

Slight misnomer, I suppose.

We do this init_console_port() as part of add_port() if the port is a
console port.  Should it be named 'mark_console_port()'?  Dunno,
doesn't sound like the right name.  init fits closest.

		Amit
