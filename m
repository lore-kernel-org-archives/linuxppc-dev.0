Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cgl71CQRzF1Q1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 15:37:38 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id j5so16581040pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2018 22:37:38 -0700 (PDT)
Date: Fri, 4 May 2018 15:37:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jslaby@suse.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback
 from console code
Message-ID: <20180504153717.4806d9c4@roar.ozlabs.ibm.com>
In-Reply-To: <87muxg80ga.fsf@concordia.ellerman.id.au>
References: <20180430145558.4308-1-npiggin@gmail.com>
 <20180430145558.4308-5-npiggin@gmail.com>
 <87muxg80ga.fsf@concordia.ellerman.id.au>
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

On Fri, 04 May 2018 15:16:37 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Use the more refined and tested event polling loop from opal_put_chars
> > as the fallback console flush in the opal-kmsg path. This loop is used
> > by the console driver today, whereas the opal-kmsg fallback is not
> > likely to have been used for years.
> >
> > Use WARN_ONCE rather than a printk when the fallback is invoked to
> > prepare for moving the console flush into a common function.  
> 
> Do we want to add a WARN in that path? If we're panicking things might
> get worse if we WARN (which takes a trap).

True, probably a good idea not to... oh there's a printk_once so
that'll work nicely.

Thanks,
Nick
