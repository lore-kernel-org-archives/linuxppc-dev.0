Return-Path: <dgibson@ozlabs.org>
Date: Mon, 16 Apr 2007 14:16:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH dtc take 2] Fix reserve map output for asm format.
Message-ID: <20070416041651.GA20274@localhost.localdomain>
References: <aa6a7bd73be20ea11e3e98f87a66e478@bga.com>
	<4622C226.1070304@gmail.com>
	<20070416005145.GA19270@localhost.localdomain>
	<ae5a6dc4dd96c8459b58b4916e35f7f7@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ae5a6dc4dd96c8459b58b4916e35f7f7@bga.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 15, 2007 at 10:49:57PM -0500, Milton Miller wrote:
> On Apr 15, 2007, at 7:51 PM, David Gibson wrote:
> > On Sun, Apr 15, 2007 at 08:24:06PM -0400, Jerry Van Baren wrote:
> >> Milton Miller wrote:
> >>> Sometime around Sun Apr 15 12:29:14 EST 2007, Jerry Van Baren wrote:
> >>>> Add extra reserve map slots output for asm format (previously done 
> >>>> for
> >>>> dtb
> >>>>   output).
> >>>>
> >>>> Signed-off-by: Gerald Van Baren <vanbaren at cideas.com>
> >>>> ---
> >>>>
> >>>> Hi Jon, David,
> >>>>
> >>>> Here is a patch that fixes the asm output without the (unnecessary)
> >>>> calloc change.
> >>>>
> >>>> Best regards,
> >>>> gvb
> >>>
> >>>
> >>> The previous description had
> >>>> Use cmalloc to pre-zero memory (for dtb input) and handle dtb 
> >>>> (binary)
> >>>>   input being shorter than the total blob length (result of putting
> >>>>   extra space in the blob).
> >>>
> >>>
> >>> Which at least said in the description the unrelated things it was
> >>> doing.
> >>
> >> That was my added comment WRT the change from malloc to cmalloc.  
> >> David
> >> wasn't wild about using cmalloc, so I removed it.  Using cmalloc is 
> >> not
> >> necessary.
> 
> Jerry,
> 
> >>>> and handle dtb (binary)
> >>>>   input being shorter than the total blob length (result of putting
> >>>>   extra space in the blob).
> 
> That part is still in this patch.
> 
> And I think it should be a separate patch.  Its unrelated to filling
> in .long 0 for the memory reserve map.

Yes.

> That said, one could use .space there I suppose.  Its fine the way it 
> is.

I think .space would be the preferred method for adding the padding
space at the end in asm format.

> >>>>         while (sizeleft) {
> >>>> -               if (feof(f))
> >>>> -                       die("EOF before reading %d bytes of DT 
> >>>> blob\n",
> >>>> -                           totalsize);
> >>>> +               if (feof(f)) {
> >>>> +                       WARNMSG("EOF after reading %d of %d bytes of
> >>>> DT blob, assuming there is extra space in the blob.\n",
> >>>> +                           totalsize - sizeleft, totalsize);
> >>>> +                       break;
> >>>> +               }
> >>>
> >>> I thnk the above should be an ERROR and cause failure without
> >>> the -f (force) option.
> >>>
> >>> The total_size says how much data should be copied.  Anything
> >>> less and there is data missing.   Assuming zeros is wrong for
> >>> most sections (the exception being the memory reserve list
> >>> that had a terminating 0 entry within the read portion).
> >>>
> >>> milton
> >>
> >> The reason total_size is bigger than the actual size is because I
> >> created the blob with extra space using the -S parameter.  It is
> >> intentionally bigger.  The extra space is ignored by dtc when 
> >> creating a
> >> dts/asm format output which is why cmalloc() is unnecessary.
> 
> If this is a case of reading in the files it creates, then its wrong
> to have the size created less than total_size.  The space needs to be
> in the output file.  To have it not be in the output is wrong. For
> instance it will not be allocated by objcopy nor the linker when its
> inserted into the dtb section of the zImage wrapper, which would lead to
> scribbling on memory belonging to something else, or at least 
> unallocated.
> Similar for a firmware that treats the dt_struct as binary data.  It
> might be loaded just before the initrd for instance.

Well, I can see specialized case uses for totalsize greater than
stored size: where you know the blob is going to be copied into
another staging area with more space, for example.

> >> I suppose we could require a -f force but I'm not wild about creating 
> >> a
> >> nanny program.  There is nothing wrong with the blob - it parses just
> >> fine.  If there were problems with the blob contents, other errors 
> >> would
> >> be raised.
> >
> > I think the warning is fine, but not for exactly the reasons you
> > state.  Several points:
> >
> > - At least with v17 input, where it's possible, we probably *should*
> > check that an input blob isn't truncated in the middle of the strings
> > or structure sections.  That should be more than a warning.
> 
> Or check that (1) the memory reserve list is terminated before this
> point, (2) the dt_struct has matching node begin and end count and
> ends with tree end, and (3) all strings referenced by dt_struct are
> before the read size.

I think just checking the header lengths of the sub-blocks should be
sufficient at this point.  Checking that the begin/end count matches
in the structure block and that all the string references are valid
can, I think, be correctly delayed until we actually parse the
structure block.

> > - Milton, saying totalsize indicates the amount of data to be copied
> > is misleading in this context.  That's a good philosphy for things
> > that just read and/or slightly tweak the tree - data outside the known
> > sections which it can't interpret should be left unaltered wherever
> > possible.
> 
> Actually, I think anything modifiny a tree with a higher revision
> than it understands, that has to move sections to increase the
> space, must downgrade the tree to the revision that it understands.
> It just doesn't know what the new structure revison means, and that
> its safe to claim it still meets the new revision.

Oh, absolutely the version should be downgraded on writes.  I wasn't
really thinking of new format revisions adding extra data - I was
thinking of hacks like programs stuffing some extra, runtime-use data
into the "gaps" in the device tree blob.  Clearly any such approach is
always going to be risky to combine with r/w tree access, but it could
be useful in some circumstances, so it doesn't hurt to be robust
against it when we can.

> > dtc, however, *always* fully interprets and re-emits the
> > tree.  Any data outside the known and understood sections is *always*
> > discarded, so I don't think there's any problem assuming it to be
> > zero.
> 
> I haven't looked at the code, but it appears that this is just reading
> the blob into memory.  I'd be fine with short file handling if it was
> parsing the structure as it was reading.
> 
> If you want to make it not an error, then it should be confirmed that
> the missing information is not accessed.   That can be done by parsing
> the structure and verifying one doesn't read beyond what was read, or
> by moving it to but up against unmapped pages for all I care.  For
> that matter, I don't care if any section is truncated as long
> as the parse shows all data was read before the end.

Again just checking that the truncation doesn't occur in the middle of
one of the data blocks as described by the header I think is
sufficient here.  More detailed checks happen when we parse the
subsections.

> Regardless, this is unrelated to properly allocating the requested
> space for extra memory reserve slots in asm output, which is the
> subject of this patch.
> 
> > - That said, I think when using -S, at least the default behaviour
> > should emit extra zero bytes in addition to changing the totalsize
> > header.  Then at least in the simplest case of feeding dtc's dtb
> > output back into dtc, the warning will not occur.
> 
> Change default behavior to only behavior and I agree.  And its
> the real fix for the problem.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
