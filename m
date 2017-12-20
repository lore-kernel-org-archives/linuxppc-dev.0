Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z25Dp57v3zDrWs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 06:58:34 +1100 (AEDT)
Subject: Re: [PATCH 2/2] ps3: Improve a size determination in five functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
 <7aed1208-aa55-edb6-54be-f47fb1498bfd@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <cd0c8519-85d0-0ce5-14a1-54a573234a98@infradead.org>
Date: Wed, 20 Dec 2017 11:58:27 -0800
MIME-Version: 1.0
In-Reply-To: <7aed1208-aa55-edb6-54be-f47fb1498bfd@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 12/16/2017 05:54 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 16 Dec 2017 14:21:04 +0100
> 
> Replace the specification of data structures by variable references
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.

After some thought, I've decided to reject this patch and others like
it because I feel it will make long term maintenance of the PS3 code
more difficult.

Some observations:

 o Your patch fixes no bug nor replaces any depreciated feature.
 o There will be no functional change; the generated binary
   will be nearly identical.
 o The PS3 kernel support is now over 10 years old.
 o I need to continue support for a few old kernel versions,
   specifically linux-3.15 and linux-2.6.30.  That includes
   keeping them working with new toolchain versions.  I need
   to back port fixes to these old kernels.
 o When problems arise I sometimes need to use git bisect
   back to old kernel versions.  When I do the bisect I often
   have fixes and local debug patches that I apply to the
   bisected tree before building.
 o Source code changes between versions causes patch conflicts
   that need to be manually resolved.  This can be error prone
   and very time consuming on a long bisect session.

My decision to reject this patch and others like it is in
attempt to minimize the code maintenance effort.  If you have
patches that fix bugs, upgrade depreciated features, or
generally improve functionality please submit them for
review.

-Geoff
