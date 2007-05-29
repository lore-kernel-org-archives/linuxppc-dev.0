Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id CDFF1DDFD6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:11:42 +1000 (EST)
Date: Tue, 29 May 2007 13:11:41 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
In-Reply-To: <20070529104948.GC29351@lst.de>
Message-ID: <Pine.LNX.4.62.0705291308280.7698@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
	<20070529104948.GC29351@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 May 2007, Christoph Hellwig wrote:
> [Note that all scsi lldds should go to linux-scsi]

I'll Cc linux-scsi next time.

> > +	sgpnt = cmd->request_buffer;
> > +	active = 1;
> > +	for (k = 0, req_len = 0, act_len = 0; k < cmd->use_sg; ++k, ++sgpnt) {
> > +		if (active) {
> > +			kaddr = kmap_atomic(sgpnt->page, KM_USER0);
> > +			if (!kaddr)
> > +				return DID_ERROR << 16;
> > +			len = sgpnt->length;
> > +			if ((req_len + len) > buflen) {
> > +				active = 0;
> > +				len = buflen - req_len;
> > +			}
> > +			memcpy(kaddr + sgpnt->offset, buf + req_len, len);
> > +			kunmap_atomic(kaddr, KM_USER0);
> > +			act_len += len;
> > +		}
> > +		req_len += sgpnt->length;
> > +	}
> > +	cmd->resid = req_len - act_len;
> 
> This looks very inefficient.  Just set sg_tablesize of your driver
> to 1 to avoid getting mutiple segments.

The disadvantage of setting sg_tablesize = 1 is that the driver will get small
requests (PAGE_SIZE) most of the time, which is very bad for performance.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
