Return-Path: <hollisb@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3559667A3D
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 10:38:07 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k770c481026145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Aug 2006 20:38:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k770c4M1284202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Aug 2006 18:38:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k770c4OA024898
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Aug 2006 18:38:04 -0600
Subject: Re: [PATCH 3/6] bootwrapper: Add device tree ops for flattened
	device tree
From: Hollis Blanchard <hollisb@us.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060719230544.GD3887@mag.az.mvista.com>
References: <20060719230544.GD3887@mag.az.mvista.com>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 19:38:02 -0500
Message-Id: <1154911082.27074.104.camel@diesel>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-07-19 at 16:05 -0700, an unknown sender wrote:
> --- /dev/null
> +++ b/arch/powerpc/boot/fdt.c
> @@ -0,0 +1,525 @@
> +/*
> + * Simple dtb (binary flattened device tree) search/manipulation routines.
> + *
> + * Author: Mark A. Greer <mgreer at mvista.com>
> + * 	- The code for strrchr() was copied from lib/string.c and is
> + * 	copyrighted by Linus Torvalds.
> + * 	- The smarts for fdt_finddevice() were copied with the author's
> + * 	permission from u-boot:common/ft_build.c which was written by
> + * 	Pantelis Antoniou <pantelis at embeddedalley.com>.

Hmm, so we'll have at least three copies of this code: uboot, kernel,
and Xen. Would it make sense to put this stuff into a libdt.a?
Technically, dtc has a "libdt" already, but it's absurdly incomplete (I
don't even know why it's there), so we could just replace it.

Xen needs all the finddevice and setprop functionality here, which looks
like it's about 2/3rds of this code.

> +static void *dtb_start;
> +static void *dtb_end;

I'd like to avoid the use of globals here. I know it's fine when you're
running in early boot, but as I mentioned I'd like to copy this code
elsewhere. Could these be moved into a structure that's passed as a
function parameter?

> +static void
> +fdt_modify_prop(u32 *dp, char *datap, u32 *old_prop_sizep, char *buf,
> +		int buflen)
> +{
> +	u32 old_prop_data_len, new_prop_data_len;
> +
> +	old_prop_data_len = _ALIGN_UP(*old_prop_sizep, 4);
> +	new_prop_data_len = _ALIGN_UP(buflen, 4);
> +
> +	/* Check if new prop data fits in old prop data area */
> +	if (new_prop_data_len == old_prop_data_len) {
> +		memcpy(datap, buf, buflen);
> +		*old_prop_sizep = buflen;
> +	}
> +	else { /* Need to alloc new area to put larger or smaller fdt */
> +		struct boot_param_header *old_bph, *new_bph;
> +		u32 *old_tailp, *new_tailp, *new_datap;
> +		u32 old_total_size, new_total_size, head_len, tail_len, diff;
> +		void *new_dtb_start, *new_dtb_end;
> +
> +		old_bph = fdt_get_bph(dtb_start),
> +		old_total_size = old_bph->totalsize;
> +		head_len = (u32)datap - (u32)dtb_start;
> +		tail_len = old_total_size - (head_len + old_prop_data_len);
> +		old_tailp = (u32 *)((u32)dtb_end - tail_len);
> +		new_total_size = head_len + new_prop_data_len + tail_len;
> +
> +		if (!(new_dtb_start = malloc(new_total_size))) {
> +			printf("Can't alloc space for new fdt\n\r");
> +			exit();
> +		}
> +
> +		new_dtb_end = (void *)((u32)new_dtb_start + new_total_size);
> +		new_datap = (u32 *)((u32)new_dtb_start + head_len);
> +		new_tailp = (u32 *)((u32)new_dtb_end - tail_len);
> +
> +		memcpy(new_dtb_start, dtb_start, head_len);
> +		memcpy(new_datap, buf, buflen);
> +		memcpy(new_tailp, old_tailp, tail_len);
> +		*(new_datap - 2) = buflen;
> +
> +		new_bph = fdt_get_bph(new_dtb_start),
> +		new_bph->totalsize = new_total_size;
> +
> +		diff = new_prop_data_len - old_prop_data_len;
> +
> +		/* Adjust offsets of other sections, if necessary */
> +		if (new_bph->off_dt_strings > new_bph->off_dt_struct)
> +			new_bph->off_dt_strings += diff;
> +
> +		if (new_bph->off_mem_rsvmap > new_bph->off_dt_struct)
> +			new_bph->off_mem_rsvmap += diff;
> +
> +		free(dtb_start, old_total_size);
> +
> +		dtb_start = new_dtb_start;
> +		dtb_end = new_dtb_end;
> +	}
> +}

I didn't realize the boot wrapper had a full malloc() to work with. I
was actually planning to only allow overwriting properties with values
of the same size, since for the most part I just need to modify some
small fixed-size data. Do you need more? I guess if the code already
works...

-- 
Hollis Blanchard
IBM Linux Technology Center
