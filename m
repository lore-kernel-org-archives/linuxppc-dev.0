Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 926F92C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 04:12:13 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so5221593pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 11:12:12 -0700 (PDT)
Date: Fri, 27 Jul 2012 11:12:08 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: sandeep@freescale.com
Subject: Re: [2/3][PATCH][v2] TDM Framework
Message-ID: <20120727181208.GC23105@kroah.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep@freescale.com wrote:
> +static struct kobj_type tdm_type = {
> +	.sysfs_ops = &tdm_ops,
> +	.default_attrs = tdm_attr,
> +};

Ah, also, as per the documentation in the kernel (go look, it's there),
I now get to publicly mock you for ignoring the error messages that
the kernel is giving you when you try to shut down your code path.

Well, to be fair, you are leaking memory like a sieve, so I doubt you
ever saw those error messages because you never cleaned up after
yourself, so perhaps I can forgive you, but your users can't, sorry.
They like to rely on the fact that Linux is a reliable operating system,
don't cause them to doubt that.

Please fix this code, it's horribly broken.  Read
Documentation/kobject.txt for why.  That file was written for a reason,
and not just because we like writing documentation (hint, we hate to...)

Ugh,

greg k-h
