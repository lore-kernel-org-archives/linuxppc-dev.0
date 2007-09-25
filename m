Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Sep 2007 13:46:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/15] bootwrapper: convert flatdevtree to version 16
Message-ID: <20070925034616.GB2525@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-08.miltonm@bga.com>
	<20070924033612.GI8058@localhost.localdomain>
	<5e71423247aef068d82b84166102fd7d@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5e71423247aef068d82b84166102fd7d@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 01:54:32AM -0500, Milton Miller wrote:
> 
> On Sep 23, 2007, at 10:36 PM, David Gibson wrote:
> 
> > On Fri, Sep 21, 2007 at 06:05:06PM -0500, Milton Miller wrote:
[snip]
> >> +#define MIN_VERSION 2
> >> +#define OUT_VERSION 16
> >
> > Should output version 17.  In any case, don't try to be so general -
> > just convert v123 (all basically the same) to latest (i.e. v17)
> > without all the #if nonsense.
> 
> Outputing v17 instead of 16 requires more words to be added to the 
> header, and the library does fine with v16.

For now.  libfdt will want v17.  Although it will (eventually) have
it's own v16->v17 conversion code.

>  Actually the v1 trees has 
> some other differences such as initrd addresses were kernel linear not 
> real, cpus were assigned logical numbers  ... so while the structure 
> didn't change except for the header field, the contents did.

!? what's your source for this.  v2 and v3 were absolutely supposed to
be backwards compatible with v1 which would not be the case with
silent semantic changes such as this.

>  Actually, 
> when converting v3 to v16 some of the code issn't needed, the ifs allow 
> the code size to be reduced.

Yes, but it never will be, because the only reason we'd include this
file is for converting old kexec-tools device trees which are v2 not
v3.

> >> +#define OUT_COMPAT 16
> >> +
> >> +#ifdef NO_CHECK
> >> +static int check_v123_tree(u32 *start, u32 *limit)
> >> +{
> >> +	return 0;
> >> +}
> >> +#else
> >> +/**
> >> + * check_v123_tree - check integrety of a version 1, 2, or 3 tree
> >> + * @start: the start of the device tree struct
> >> + * @limit: the end of the region for the struct
> >> + * structural checks on device_tree
> >> + */
> >> +static int check_v123_tree(u32 *start, u32 *limit)
> >
> > What is the point of this check?  If the device tree is corrupt, we're
> > stuffed anyway, so why bother?
> 
> Hence the ifdef NO_CHECK.   When developing, sometimes its nice to know 
> if its your input or your program.  These functions are destructive to 
> an improperlly formed tree, and in non-obvious ways.  When debugging, 
> it's not hard to hardcode console write or read the printf string 
> buffer with a hardware debugger to see error messages.  That said, it 
> could be removed.

Right.  Debugging code shouldn't pollute final patches.

[snip]
> >> +#if MIN_VERSION < 3 || OUT_VERSION > 16
> >> +/**
> >> + * move_nops_fwd - move nops in a v16 dt_struct to the beginning
> >> + * @start - device tree starting address
> >> + * @count - number of %OF_DT_NOP cells to move
> >> + */
> >> +static void move_nops_fwd(u32 *start, int count)
> >
> > What on earth is the point of this.  The NOPs are perfectly valid
> > scattered within the tree, why go to all this trouble to shuffle them
> > about.
> 
> And if you notice, there is a "how many to move" argument.  The point 
> of moving them to the front of the tree is the v17 device tree header 
> takes more space than the v3 one, and the v2 header is smaller than 
> both v17 and v16 header.  Since I am converting the tree in place, the 
> space has to come from somewhere.  Since we are pretty much guaranteed 
> to get several nops, this function moves them forward so they can be 
> overwritten.  In practice we move 1-3 NOPS from the early properties > 
> 8 bytes and early grandchild nodes (eg /cpus/PowerPC,xxx).

This is a hell of a lot of bother to go to for a few bytes.
Allocating a big-enough buffer for any reasonable devtree in BSS and
memmove()ing into there would be far simpler.

Remember this is a hack for horrid old device trees produced by
kexec-tools.  It simply doesn't justify large amounts of code to work
around.

[snip]
> >> +	if (tree->last_comp_version > 3)
> >> +		return;			/* don't know what to do */
> >
> > Rather, don't need to do anything.
> 
> If the tree is >= 16 then we don't presently need to do anything.   If 
> there is a theoritical v4 tree we don't know what to do.  And if output 
> version is 17 but input is 16 we don't know what to do either, because 
> there likely aren't nops in the tree to consume.  I suppose we could 
> preceed it with a check for version == OUTPUT_VERSION, but then I'm 
> sure I'd get pointless differentation :-).

There will never be a v4.  Or anything between v3 and v16.

Again this is far too general.  It's a hack to deal with kexec-tools
old trees.  Therefore it doesn't need to deal with any general old
tree, just the minimum to deal with trees as produced by old
kexec-tools.

[snip]
> >> +	/*
> >> +	 * move mem_rsvmap and dt_strings if they are before dt_struct
> >> +	 * onto our nops .  Adjust start addresses for the 3 sections.
> >> +	 */
> >
> > Hrm.  Do we really need to worry about this case.  You may be
> > producing v2 trees in kexec-tools, but do they actually have the
> > blocks out of order?  dtc certainly never produced them that way.
> 
> Out of order?  There has never been a spec as to the order of the 
> blocks, only the implicit assumption that they follow the device tree 
> header in a reasonably packed sequence.  booting-without-of says it 
> must be in ram,; the offsets are unsigned 32 bit quantities.

> As to the order, used, the first implemntation was the kernel which 
> writes memreserve, strings, then struct (both the openfirmware client 
> in prom_init and the iSeries procedural library in dt.c).  The second 
> implentation written is a procedural based library (similar to iseries, 
> never published, but still used internally) that starts with a 
> pre-built header and string table, builds the dt_struct as the 
> functions are called, and when finished copies the memreserve table and 
> fills in the dt_size, total size, and memreserve offset.

Hrm.  Yes, well, the iSeries tree is weird in a bunch of ways.

> fs2dt writes memreserve, struct, then strings.  Aparently the same as 
> dtc.  But yes, the strings can be before the struct, and the mem 
> reserve may or may not be when the strings are before the struct.

Again.  We don't need to deal with the general case here - just the
real case of trees produced by old kexec-tools.

[snip]

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
