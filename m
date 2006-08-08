Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id A32C2679F0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 10:26:23 +1000 (EST)
Date: Mon, 7 Aug 2006 17:30:13 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 3/6] bootwrapper: Add device tree ops for flattened device
	tree
Message-ID: <20060808003013.GE4582@mag.az.mvista.com>
References: <20060719230544.GD3887@mag.az.mvista.com>
	<1154911082.27074.104.camel@diesel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154911082.27074.104.camel@diesel>
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

On Sun, Aug 06, 2006 at 07:38:02PM -0500, Hollis Blanchard wrote:
> On Wed, 2006-07-19 at 16:05 -0700, an unknown sender wrote:
> > --- /dev/null
> > +++ b/arch/powerpc/boot/fdt.c
> > @@ -0,0 +1,525 @@
> > +/*
> > + * Simple dtb (binary flattened device tree) search/manipulation routines.
> > + *
> > + * Author: Mark A. Greer <mgreer at mvista.com>
> > + * 	- The code for strrchr() was copied from lib/string.c and is
> > + * 	copyrighted by Linus Torvalds.
> > + * 	- The smarts for fdt_finddevice() were copied with the author's
> > + * 	permission from u-boot:common/ft_build.c which was written by
> > + * 	Pantelis Antoniou <pantelis at embeddedalley.com>.
> 
> Hmm, so we'll have at least three copies of this code: uboot, kernel,
> and Xen. Would it make sense to put this stuff into a libdt.a?

Yes, it would.

> Technically, dtc has a "libdt" already, but it's absurdly incomplete (I
> don't even know why it's there), so we could just replace it.

Sounds like a plan!

> Xen needs all the finddevice and setprop functionality here, which looks
> like it's about 2/3rds of this code.

Yeah, pretty much.

> > +static void *dtb_start;
> > +static void *dtb_end;
> 
> I'd like to avoid the use of globals here. I know it's fine when you're
> running in early boot, but as I mentioned I'd like to copy this code
> elsewhere. Could these be moved into a structure that's passed as a
> function parameter?

Sure.

> > +static void
> > +fdt_modify_prop(u32 *dp, char *datap, u32 *old_prop_sizep, char *buf,
> > +		int buflen)
> > +{
> > +	u32 old_prop_data_len, new_prop_data_len;
> > +
> > +	old_prop_data_len = _ALIGN_UP(*old_prop_sizep, 4);
> > +	new_prop_data_len = _ALIGN_UP(buflen, 4);
> > +
> > +	/* Check if new prop data fits in old prop data area */
> > +	if (new_prop_data_len == old_prop_data_len) {
> > +		memcpy(datap, buf, buflen);
> > +		*old_prop_sizep = buflen;
> > +	}
> > +	else { /* Need to alloc new area to put larger or smaller fdt */
> > +		struct boot_param_header *old_bph, *new_bph;
> > +		u32 *old_tailp, *new_tailp, *new_datap;
> > +		u32 old_total_size, new_total_size, head_len, tail_len, diff;
> > +		void *new_dtb_start, *new_dtb_end;
> > +
> > +		old_bph = fdt_get_bph(dtb_start),
> > +		old_total_size = old_bph->totalsize;
> > +		head_len = (u32)datap - (u32)dtb_start;
> > +		tail_len = old_total_size - (head_len + old_prop_data_len);
> > +		old_tailp = (u32 *)((u32)dtb_end - tail_len);
> > +		new_total_size = head_len + new_prop_data_len + tail_len;
> > +
> > +		if (!(new_dtb_start = malloc(new_total_size))) {
> > +			printf("Can't alloc space for new fdt\n\r");
> > +			exit();
> > +		}
> > +
> > +		new_dtb_end = (void *)((u32)new_dtb_start + new_total_size);
> > +		new_datap = (u32 *)((u32)new_dtb_start + head_len);
> > +		new_tailp = (u32 *)((u32)new_dtb_end - tail_len);
> > +
> > +		memcpy(new_dtb_start, dtb_start, head_len);
> > +		memcpy(new_datap, buf, buflen);
> > +		memcpy(new_tailp, old_tailp, tail_len);
> > +		*(new_datap - 2) = buflen;
> > +
> > +		new_bph = fdt_get_bph(new_dtb_start),
> > +		new_bph->totalsize = new_total_size;
> > +
> > +		diff = new_prop_data_len - old_prop_data_len;
> > +
> > +		/* Adjust offsets of other sections, if necessary */
> > +		if (new_bph->off_dt_strings > new_bph->off_dt_struct)
> > +			new_bph->off_dt_strings += diff;
> > +
> > +		if (new_bph->off_mem_rsvmap > new_bph->off_dt_struct)
> > +			new_bph->off_mem_rsvmap += diff;
> > +
> > +		free(dtb_start, old_total_size);
> > +
> > +		dtb_start = new_dtb_start;
> > +		dtb_end = new_dtb_end;
> > +	}
> > +}
> 
> I didn't realize the boot wrapper had a full malloc() to work with.

It doesn't (really).  I made a standard interface to what may
someday be a real memory allocator.  If you look in dink.c,
you'll see I just have a hack malloc() and no free() at all.

Its one of those things that I was hoping someone would chip in
and help with.  IIRC, Matt McClintock was looking at that but I'm
not sure how far he got.

> I
> was actually planning to only allow overwriting properties with values
> of the same size, since for the most part I just need to modify some
> small fixed-size data. Do you need more? I guess if the code already
> works...

I know that we need to extend the size of a property because
/chosen/bootargs can be edited and potentially extended.

Mark
