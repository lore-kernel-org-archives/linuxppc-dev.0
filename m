Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by ozlabs.org (Postfix) with ESMTP id A31062C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 01:06:06 +1000 (EST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MTY00LXV1Y3STZ0@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 01 Oct 2013 00:06:03 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] powerpc/8xx: tqm8xx: fix incorrect placement of __initdata
 tag
Date: Mon, 30 Sep 2013 17:05:51 +0200
Message-id: <9412116.FMJVEO7gkK@amdc1032>
In-reply-to: <AE90C24D6B3A694183C094C60CF0A2F6026B736B@saturn3.aculab.com>
References: <1589399.KSlGuZSdd2@amdc1032>
 <AE90C24D6B3A694183C094C60CF0A2F6026B736B@saturn3.aculab.com>
MIME-version: 1.0
Content-type: text/plain; charset=Windows-1252
Cc: Marcelo Tosatti <marcelo@kvack.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, September 30, 2013 03:20:29 PM David Laight wrote:
> > __initdata tag should be placed between the variable name and equal
> > sign for the variable to be placed in the intended .init.data section.
> ...
> > -static struct __initdata cpm_pin tqm8xx_pins[] = {
> > +static struct cpm_pin tqm8xx_pins[] __initdata = {
> 
> As far as gcc is concerned it can go almost anywhere before the '=',
> even before the 'static'.
> Splitting 'struct cpm_pin' does seem an odd choice.

It is not only an odd choice, it just doesn't work as it should in
the practice (as tested with gcc-4.6.3 from Ubuntu 12.04).

> The Linux coding standards might suggest a location.
> I'd have thought that either before or after the 'static' would be best
> (ie as a storage class qualifier).

The majority of the kernel code uses __initdata before equal sign
and the __initdata documentation in <linux/init.h> recommends such
usage:

"
 * For initialized data:
 * You should insert __initdata or __initconst between the variable name
 * and equal sign followed by value, e.g.:
 *
 * static int init_variable __initdata = 0;
 * static const char linux_logo[] __initconst = { 0x32, 0x36, ... };
"

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
