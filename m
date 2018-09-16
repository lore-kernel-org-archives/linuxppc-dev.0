Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42D3Yn6fFDzF22s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 08:18:30 +1000 (AEST)
Date: Mon, 17 Sep 2018 08:18:22 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Jason Wessel <jason.wessel@windriver.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net,
 stable@vger.kernel.org
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
Message-ID: <20180916221822.GO11198@eros>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 16, 2018 at 12:06:10PM -0700, Daniel Thompson wrote:
> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
> > On a powerpc 8xx, 'btc' fails as follows:
> > 
> > Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
> > kdb> btc
> > btc: cpu status: Currently on cpu 0
> > Available cpus: 0
> > kdb_getarea: Bad address 0x0
> > 
> > when booting the kernel with 'debug_boot_weak_hash', it fails as well
> > 
> > Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
> > kdb> btc
> > btc: cpu status: Currently on cpu 0
> > Available cpus: 0
> > kdb_getarea: Bad address 0xba99ad80
> > 
> > On other platforms, Oopses have been observed too, see
> > https://github.com/linuxppc/linux/issues/139
> > 
> > This is due to btc calling 'btt' with %p pointer as an argument.
> > 
> > This patch replaces %p by %px to get the real pointer value as
> > expected by 'btt'
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Cc: <stable@vger.kernel.org> # 4.15+
> 
> Would a Fixes: be better here?
> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
> 
> No blame attached to Tobin, but the fixes makes it super clear what

:)

> changed and why this breaks kdb (which was not explicitly called out
> the patch description).
> 
> 
> Daniel.
