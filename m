Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjrjf48qdzDrMX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 16:37:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/6] powerpc/boot: add xz support to the wrapper script
In-Reply-To: <1474527274-10897-6-git-send-email-oohall@gmail.com>
References: <1474527274-10897-1-git-send-email-oohall@gmail.com>
 <1474527274-10897-6-git-send-email-oohall@gmail.com>
Date: Tue, 27 Sep 2016 16:37:23 +1000
Message-ID: <87lgyd7srg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> This modifies the script so that the -Z option takes an argument to
> specify the compression type. It can either be 'gz', 'xz' or 'none'.
> The legazy --no-gzip and -z options are still supported and will set
> the compression to none and gzip respectively, but they are not
> documented.
>
> Only xz -6 is used for compression rather than xz -9. Using compression
> levels higher than 6 requires the decompressor to build a large (64MB)
> dictionary when decompressing and some environments cannot satisfy large
> allocations (e.g. POWER 6 LPAR partition firmware).

This isn't working for me on machines that use uImage.

That's the "uboot" case in wrapper, where we do:

    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
	$uboot_version -d "$vmz" "$ofile"

ie. we tell mkimage that we're using gzip compression, regardless of
whether we actually are.

That leads to something like:

  ## Booting kernel from Legacy Image at 01000000 ...
     Image Name:   Linux-4.8.0-rc5-compiler_gcc-6.2
     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
     Data Size:    3381044 Bytes = 3.2 MiB
     Load Address: 00000000
     Entry Point:  00000000
     Verifying Checksum ... OK
  ## Flattened Device Tree blob at 0c000000
     Booting using the fdt blob at 0xc000000
     Uncompressing Kernel Image ... Error: Bad gzipped data
  gzip compressed: uncompress error -1
  Must RESET board to recover


So you'll need to do some juggling so you can pass the right argument
for -C to mkimage.

cheers
