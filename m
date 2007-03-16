Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A4F23DDF3E
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 03:24:12 +1100 (EST)
Message-ID: <45FAC4A2.4060207@am.sony.com>
Date: Fri, 16 Mar 2007 09:24:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 6/15] zImage: Add more flexible gunzip convenience
	functions
References: <20070305032452.4DCDBDDF1B@ozlabs.org>
In-Reply-To: <20070305032452.4DCDBDDF1B@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> This patch adds a new set of more flexible convenience wrappers around
> zlib, moving them to their own file, gunzip_util.c, in the process.
> These wrappers allow decompressing sections of the compressed image to
> different locations.  In addition, they transparently handle
> uncompressed data, avoiding special case code to handle uncompressed
> vmlinux images.

Hi.

I was waiting for the zimage churn to settle before looking into this
change, but I though I would let you know so you can keep it in mind
if you do any work here.

As I mentioned in another mail, the PS3's 1st stage loader (in the
hypervisor) supports loading a gzipped binary memory image from flash.
So for Linux, that would be a gzipped zImage.  Since the entire zImage
is uncompressed by the loader, there is no need to have the kernel image
compressed on its own, nor to include the zlib code in the wrapper.

Here is a functional expression of what we have now, and what would
be ideal:

zImage.gz = gzip(wrapper bits + zlib + gzip(vmlinx) + dtb)

zImage.gz = gzip(wrapper bits + vmlinx + dtb)

-Geoff
