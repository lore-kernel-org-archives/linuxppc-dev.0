Return-Path: <James.Bottomley@SteelEye.com>
Received: from hancock.sc.steeleye.com (hancock.steeleye.com [71.30.118.248])
	by ozlabs.org (Postfix) with ESMTP id 2026EDDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 23:02:25 +1000 (EST)
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <20070704132346.591348000@pademelon.sonytel.be>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<20070704132346.591348000@pademelon.sonytel.be>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 09:02:21 -0400
Message-Id: <1184331741.3402.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-04 at 15:22 +0200, Geert Uytterhoeven wrote:
> +                       kaddr = kmap_atomic(sgpnt->page, KM_USER0);
> +                       if (!kaddr)
> +                               return -1;
> +                       len = sgpnt->length;
> +                       if ((req_len + len) > buflen) {
> +                               active = 0;
> +                               len = buflen - req_len;
> +                       }
> +                       memcpy(kaddr + sgpnt->offset, buf + req_len,
> len);
> +                       kunmap_atomic(kaddr, KM_USER0);

This isn't a SCSI objection, but this sequence appears several times in
this driver.  It's wrong for a non-PIPT architecture (and I believe the
PS3 is VIPT) because you copy into the kernel alias for the page, which
dirties the line in the cache of that alias (the user alias cache line
was already invalidated).  However, unless you flush the kernel alias to
main memory, the user could read stale data.  The way this is supposed
to be done is to do a 

flush_kernel_dcache_page(kaddr)

before doing the kunmap.

Otherwise it looks OK from the SCSI point of view.

James
