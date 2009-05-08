Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id DD477DDF8A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:27:03 +1000 (EST)
Date: Fri, 8 May 2009 16:27:02 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: initramfs with lzma compression
In-Reply-To: <23446869.post@talk.nabble.com>
Message-ID: <alpine.LRH.2.00.0905081625580.7964@vixen.sonytel.be>
References: <23446869.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 8 May 2009, Mirek23 wrote:
> I am looking for a patch which introduces lzma compression or suppresses the
> standard gzip compression for the initramfs.

It's already in the mainline kernel, e.g.:

commit 30d65dbfe3add7f010a075991dc0bfeaebb7d9e1
Author: Alain Knaff <alain@knaff.lu>
Date:   Sun Jan 4 22:46:17 2009 +0100

    bzip2/lzma: config and initramfs support for bzip2/lzma decompression
    
    Impact: New code for initramfs decompression, new features
    
    This is the second part of the bzip2/lzma patch
    
    The bzip patch is based on an idea by Christian Ludwig, includes support for
    compressing the kernel with bzip2 or lzma rather than gzip. Both
    compressors give smaller sizes than gzip.  Lzma's decompresses faster
    than bzip2.
    
    It also supports ramdisks and initramfs' compressed using these two
    compressors.
    
    The functionality has been successfully used for a couple of years by
    the udpcast project
    
    This version applies to "tip" kernel 2.6.28
    
    This part contains:
    - support for new compressions (bzip2 and lzma) in initramfs and
    old-style ramdisk
    - config dialog for kernel compression (but new kernel compressions
    not yet supported)
    
    Signed-off-by: Alain Knaff <alain@knaff.lu>
    Signed-off-by: H. Peter Anvin <hpa@zytor.com>

For older kernel versions, you can backport it by git cherry-picking the
commits you need.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
