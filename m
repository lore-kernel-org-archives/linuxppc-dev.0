Return-Path: <dgibson@ozlabs.org>
Date: Thu, 14 Jul 2005 11:28:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050714012833.GD15769@sneetch.ozlabs.ibm.com>
References: <1121271391.21013.4.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121271391.21013.4.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: DTC: write_dt_blob() question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2005 at 11:16:32AM -0500, Jon Loeliger wrote:
> David,
> 
> Over in flattree.c's write_dt_blob() there is this code:
> 
> 	make_bph(&bph, vi, reservenum, dtbuf.len, strbuf.len);
> 
> 	/* Align the reserve map to an 8 byte boundary */
> 	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++)
> 		fputc(0, f);
> 
> 	fwrite(&bph, vi->hdr_size, 1, f);
> 	for (i = 0; i < reservenum+1; i++)
> 		fwrite(&re, sizeof(re), 1, f);
> 
> However, I think the boot_param_header should be emitted
> first, before the alignment:
> 
> 	make_bph(&bph, vi, reservenum, dtbuf.len, strbuf.len);
> 
> 	fwrite(&bph, vi->hdr_size, 1, f);
> 
> 	/* Align the reserve map to an 8 byte boundary */
> 	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++)
> 		fputc(0, f);
> 
> 	for (i = 0; i < reservenum+1; i++)
> 		fwrite(&re, sizeof(re), 1, f);
> 
> Thoughts?

Oops, yes, stupid screwup on my part.  I've really got to get this
testsuite thing going...

I've committed a fix for this, but it won't go up on the site until
I'm able to fix my laptop, unfortunately (disk died the other day).

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
