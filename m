Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miche Baker-Harvey <miche@google.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH v3 2/3] hvc_init():  Enforce one-time initialization.
In-Reply-To: <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
Date: Fri, 11 Nov 2011 15:00:31 +1030
Message-ID: <874nybqo0o.fsf@rustcorp.com.au>
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

On Tue, 08 Nov 2011 13:45:04 -0800, Miche Baker-Harvey <miche@google.com> wrote:
> hvc_init() must only be called once, and no thread should continue with hvc_alloc()
> until after initialization is complete.  The original code does not enforce either
> of these requirements.  A new mutex limits entry to hvc_init() to a single thread,
> and blocks all later comers until it has completed.
> 
> This patch fixes multiple crash symptoms.

No, it doesn't: not now your previous double-hvc_init patch has been
reverted.

It's easy to show this is the case though: replace mutex_lock() with:

        if (!mutex_trylock()) {
                WARN(1, "hvc_console: mutex is stopping us!\n");
                mutex_lock();
        }

If you get that warning, then your mutex is doing something.

Thanks,
Rusty.
