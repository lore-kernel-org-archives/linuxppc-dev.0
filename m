Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqczp6P2RzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 09:10:14 +1100 (AEDT)
Message-ID: <1490393405.2944.53.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Giuseppe Lippolis <giu.lippolis@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 24 Mar 2017 17:10:05 -0500
In-Reply-To: <006101d2a4e5$82bebcd0$883c3670$@gmail.com>
References: <004201d1b85c$75353ba0$5f9fb2e0$@gmail.com>
 <1464998513.22191.38.camel@buserror.net>
 <006101d2a4e5$82bebcd0$883c3670$@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: AW: problem with cuImage.mpc834x_mds image
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-24 at 22:27 +0100, Giuseppe Lippolis wrote:
> > 
> Therefore the code crash during the call in:
>         bl      setup_common_caches
> 
> 
> I'm using the iomega_150d based on the MPC8347.
> 
> Do you have some tips about the setup_common_caches?

Once caching is enabled[1] you won't be able to do I/O until the MMU is set up
for an uncached I/O mapping.

-Scott

[1] Or at some similar point during early init.  It's been a while since I
worked on chips like this, so I don't recall the details of which caches are
enabled on kernel entry and whether there's some magic to exempt I/O, but I do
remember there being a stretch of time during init where doing I/O was a
problem.
