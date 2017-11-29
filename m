Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x230.google.com (mail-pg0-x230.google.com
 [IPv6:2607:f8b0:400e:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymnVF4ShkzDrcW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 15:24:05 +1100 (AEDT)
Received: by mail-pg0-x230.google.com with SMTP id f12so955065pgo.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 20:24:05 -0800 (PST)
Date: Wed, 29 Nov 2017 14:23:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
In-Reply-To: <20171129040652.GF3023@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Nov 2017 15:06:52 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifier"
> purports to fix a problem when the kernel panics with fadump not
> registered, but it breaks something else instead.  I _think_ it was
> working on the incorrect assumption that ppc_md.panic was (or should
> be) only used with fadump, but I'm not really sure.
> 
> Panic works with kdump enabled, and (I think) with fadump enabled).
> However, with neither of these enabled, we always go to the generic
> panic logic.

Yeah thanks, I can't remember what assumption I was working on tbh.
 
> That's incorrect for PAPR guests - they should call ibm,os-term via
> RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notification
> which higher-level management pays attention to.  Since a3b2cb30 we
> now reboot instead of reporting that.
> 
> I believe it will also break panic for PS3 machines, but since that
> platform basically no longer exists, we probably don't care.

I (hope) it should just go down to the normal panic path and not do
much worse than it already does -- although it won't print out that
message.

> I'm not entirely sure how to fix this.  I _think_ what we want is to
> call ppc_md.panic from a late panic notifier, the way this patch does
> for fadump_panic_event() if fadump is registered.

The problem I had there is that some of the printk and console stuff
wasn't getting flushed out, so I was getting a blank screen. This was
probably in conjunction with panicing from NMI context that we're now
starting to introduce.

So it's a bit annoying. There's other ugliness we have for being unable
to control panic code well enough from arch code
(arch/powerpc/platforms/powernv/opal.c)

I guess a really minimal fix is to put an #ifdef powerpc down the bottom
there (/me *cries*).
