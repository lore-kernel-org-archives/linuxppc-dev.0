Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miche Baker-Harvey <miche@google.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH v3 1/3] virtio_console:  Fix locking of vtermno.
In-Reply-To: <20111108214458.28884.86759.stgit@miche.sea.corp.google.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214458.28884.86759.stgit@miche.sea.corp.google.com>
Date: Fri, 11 Nov 2011 14:57:20 +1030
Message-ID: <877h37qo5z.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>,
 Amit Shah <amit.shah@redhat.com>, Mike Waychison <mikew@google.com>,
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

On Tue, 08 Nov 2011 13:44:58 -0800, Miche Baker-Harvey <miche@google.com> wrote:
> Some modifications of vtermno were not done under the spinlock.
> 
> Moved assignment from vtermno and increment of vtermno together,
> putting both under the spinlock.  Revert vtermno on failure.
> 
> Signed-off-by: Miche Baker-Harvey <miche@google.com>

Does it matter?  It's normal not to lock in a function called
"init_XXX", since it's not exposed yet.

Or is it?

Thanks,
Rusty.
