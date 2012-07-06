Return-Path: <amodra@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA43A2C0203
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 16:08:43 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so16016721pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2012 23:08:42 -0700 (PDT)
Date: Fri, 6 Jul 2012 15:38:34 +0930
From: Alan Modra <amodra@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the final tree
Message-ID: <20120706060834.GC5805@bubble.grove.modra.org>
References: <20120705183345.ee84ec1048a19aa1c7129578@canb.auug.org.au>
 <20120705094348.GA5805@bubble.grove.modra.org>
 <20120706102151.fd4f769cf2aa3f753ad178bf@canb.auug.org.au>
 <20120706005709.GB5805@bubble.grove.modra.org>
 <20120706130137.6aae96c0072af1f330249c0d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120706130137.6aae96c0072af1f330249c0d@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 06, 2012 at 01:01:37PM +1000, Stephen Rothwell wrote:
> solos-pci.c:(.text+0x1ff923c): relocation truncated to fit: R_PPC64_REL24
                     ^^^^^^^^^

> I assume at this point, we are just too large.

Yeah, but not in total.  I didn't see any of these in the allyes
kernel I built with our proof of concept hack to avoid ld -r.  I think
you'll find that these are all from ld -r output, as I assume no one
in kernel land writes drivers or whatever with 33M of text in a single
file.  Branches in that monstrous section can't even reach the
trampolines that ld inserts to extend branch reach.  Did I mention
that ld -r is a bad idea?

One workaround might be to compile with -ffunction-sections.

-- 
Alan Modra
Australia Development Lab, IBM
