Return-Path: <olson@cumulusnetworks.com>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 355B31A00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 10:43:57 +1100 (AEDT)
Received: by pdbnh10 with SMTP id nh10so32062652pdb.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2015 15:43:55 -0800 (PST)
Date: Mon, 9 Feb 2015 15:43:51 -0800
From: Dave Olson <olson@cumulusnetworks.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc: fix missing L2 cache size in
 /sys/devices/system/cpu
Message-ID: <20150209234351.GC22286@cumulusnetworks.com>
References: <20150209221421.GA22286@cumulusnetworks.com>
 <1423524827.19657.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423524827.19657.1.camel@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Mon, 2015-02-09 at 14:14 -0800, Dave Olson wrote:
> > From: Dave Olson <olson@cumulusnetworks.com>
> > 
> > Fix missing L2 cache size in /sys/devices/system/cpu/cpu0/cache/index2/size
> > This bug appears to be introduced in 2.6.29 by 93197a36a9c16a85fb24cf5a8639f7bf9af838a3.
> > The missing entry caused lscpu to error out on e500v2 devices, and probably others
> >  error: cannot open /sys/devices/system/cpu/cpu0/cache/index2/size: No such file or directory
> > The DTS files we see use cache-size for the unified L2 cache size, not d-cache-size
> 
> Can you convince me that this is not going to break other machines that have
> "d-cache-size" but not "cache-size"?

I'm unable to find any dts file that uses d-cache-size for the L2
unified cache.  All in the powerpc tree in arch/powerpc/boot/dts/*
are using cache-size in the L2 description for the cache size.

As best as I can tell from looking around, this is universal.

Dave Olson
olson@cumulusnetworks.com
