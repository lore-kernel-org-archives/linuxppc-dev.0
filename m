Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9R566SSHzDt11
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 02:46:02 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id 62so13274397oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 08:46:02 -0700 (PDT)
Date: Sat, 5 Nov 2016 00:44:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@suse.de>, Petr Mladek <pmladek@suse.com>,
 Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
Message-ID: <20161104153852.GA422@swordfish>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <20161103125758.3415-1-paul.burton@imgtec.com>
 <20161103174040.GB423@swordfish> <2317993.vxfTP7Yo3N@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2317993.vxfTP7Yo3N@np-p-burton>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On (11/03/16 21:17), Paul Burton wrote:
> > [..]
> > > +			 * The device tree stdout-path chosen node property was
> > > +			 * specified so we don't want to enable the first
> > > +			 * registered console just now in order to give the
> > > +			 * device indicated by stdout-path a chance to be
> > > +			 * registered first. Do however keep track of the
> > > +			 * first console we see so that we can fall back to
> > > +			 * using it if we don't see the desired device, either
> > > +			 * because stdout-path isn't valid, or because we have
> > > +			 * no driver for the device or our driver doesn't call
> > > +			 * of_console_check(). See printk_late_init() for this
> > > +			 * fallback.
> > 
> > if the path is not valid then correct the path. no?
> 
> ...but what if the path is valid and we simply don't have a driver for the 
> device it references? As I said in that comment we may not have a driver at 
> all.

well, I suppose, in this case normally one would go and enable the
missing .config option. no?

	-ss
