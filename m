Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain
Message-Id: <1121271391.21013.4.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 13 Jul 2005 11:16:32 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: DTC: write_dt_blob() question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David,

Over in flattree.c's write_dt_blob() there is this code:

	make_bph(&bph, vi, reservenum, dtbuf.len, strbuf.len);

	/* Align the reserve map to an 8 byte boundary */
	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++)
		fputc(0, f);

	fwrite(&bph, vi->hdr_size, 1, f);
	for (i = 0; i < reservenum+1; i++)
		fwrite(&re, sizeof(re), 1, f);

However, I think the boot_param_header should be emitted
first, before the alignment:

	make_bph(&bph, vi, reservenum, dtbuf.len, strbuf.len);

	fwrite(&bph, vi->hdr_size, 1, f);

	/* Align the reserve map to an 8 byte boundary */
	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++)
		fputc(0, f);

	for (i = 0; i < reservenum+1; i++)
		fwrite(&re, sizeof(re), 1, f);

Thoughts?

Thanks,
jdl
