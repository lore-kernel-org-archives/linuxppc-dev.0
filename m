Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 021A41A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 09:46:11 +1000 (AEST)
Message-ID: <1432165570.27130.5.camel@neuling.org>
Subject: Re: [PATCH v3] cxl: Export AFU error buffer via sysfs
From: Michael Neuling <mikey@neuling.org>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>, Michael
 Ellerman <michael@ellerman.id.au>
Date: Thu, 21 May 2015 09:46:10 +1000
In-Reply-To: <1432142313-7741-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1432142313-7741-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+ */
> +ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
> +				loff_t off, size_t count)
> +{
> +	loff_t aligned_off;
> +	size_t aligned_count;
> +	const void __iomem *ebuf =3D afu->afu_desc_mmio + afu->eb_offset;
> +
> +	if (!afu->eb_len || count =3D=3D 0 || off < 0)

if eb_len =3D=3D 0 we don't even create the sysfs file.  So is this check
needed?

> +		return 0;
> +
> +	/* calculate aligned read window */
> +	count =3D min((size_t)(afu->eb_len - off), count);

What if count ends up being negative because off > afu->eb_len??

> +	aligned_off =3D round_down(off, 8);
> +	aligned_count =3D round_up(off + count, 8) - aligned_off;

I kinda preferred the start end variables, and length was just end -
start.

I though it was more readable. IMHO

How about:

	aligned_start =3D round_down(off, 8);
	aligned_end =3D round_up(off + count, 8);
	aligned_length =3D aligned_end - aligned_start;

> +
> +	/* fast path */
> +	if ((aligned_off =3D=3D off) && (aligned_count =3D=3D count)) {
> +		/* no need to use the bounce buffer */
> +		_memcpy_fromio(buf, ebuf + off, count);

I would drop this, as the other code path should work fine.
Premature optimisation.....

> +
> +	} else {
> +		/* use bounce buffer for copy */
> +		void *tbuf =3D (void *)__get_free_page(GFP_TEMPORARY);
> +
> +		if (!tbuf)
> +			return -ENOMEM;
> +
> +		/* max we can copy in one read is PAGE_SIZE */
> +		aligned_count =3D min(aligned_count, PAGE_SIZE);
> +		_memcpy_fromio(tbuf, ebuf + aligned_off, aligned_count);
> +
> +		count =3D min(count, aligned_count);

This doesn't seem right.  count will equal PAGE_SIZE if it's too big but
it has to be smaller by (off & 7) in this case.

How about this?

        #define MAX_COPY_SIZE PAGE_SIZE
	...

	void *bbuf;

	/* Bounds check count with err buf length */
	count =3D min((size_t)(afu->eb_len - off), count);
	if ((off < 0) || (count < 0))
		return 0;

	/* Create aligned bounce buffer to copy into */
	aligned_start =3D round_down(off, 8);
	aligned_end =3D round_up(off + count, 8);
	aligned_length =3D aligned_end - aligned_start;

	if (aligned_length > MAX_COPY_SIZE) {
		aligned_length =3D MAX_COPY_SIZE;
		count =3D MAX_COPY_SIZE - (off & 0x7);
        }

	bbuf =3D (void *)__get_free_page(GFP_TEMPORARY);
 	if (!bbuf)
		return -ENOMEM;

	/* Use _memcpy_fromio() so the reads are aligned */
	_memcpy_fromio(bbuf, ebuf + aligned_start, aligned_length);
	memcpy(buf, bbuf + (off & 0x7), count);

	free_page(bbuf);


> +		memcpy(buf, tbuf + (off & 0x7), count);
> +
> +		free_page((unsigned long)tbuf);
> +	}
> +
> +	return count;
