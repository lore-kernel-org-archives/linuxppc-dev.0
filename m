Return-Path: <dgibson@ozlabs.org>
Date: Mon, 16 Apr 2007 16:30:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH dtc take 2] Fix reserve map output for asm format.
Message-ID: <20070416063034.GB20363@localhost.localdomain>
References: <aa6a7bd73be20ea11e3e98f87a66e478@bga.com>
	<4622C226.1070304@gmail.com>
	<20070416005145.GA19270@localhost.localdomain>
	<ae5a6dc4dd96c8459b58b4916e35f7f7@bga.com>
	<20070416041651.GA20274@localhost.localdomain>
	<9979571f0828369de99700eb80c91bee@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9979571f0828369de99700eb80c91bee@bga.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 16, 2007 at 12:08:37AM -0500, Milton Miller wrote:
> On Apr 15, 2007, at 11:16 PM, David Gibson wrote:
> > On Sun, Apr 15, 2007 at 10:49:57PM -0500, Milton Miller wrote:
> >> On Apr 15, 2007, at 7:51 PM, David Gibson wrote:
> >>> On Sun, Apr 15, 2007 at 08:24:06PM -0400, Jerry Van Baren wrote:
> >>>> Milton Miller wrote:
> >>>>> Sometime around Sun Apr 15 12:29:14 EST 2007, Jerry Van Baren 
> >>>>> wrote:
> >>>>>> Add extra reserve map slots output for asm format (previously done
> >>>>>> for
> >>>>>> dtb
> >>>>>>   output).
> 
> >>>>>> and handle dtb (binary)
> >>>>>>   input being shorter than the total blob length (result of 
> >>>>>> putting
> >>>>>>   extra space in the blob).
> >>
> >> That part is still in this patch.
> >>
> >> And I think it should be a separate patch.  Its unrelated to filling
> >> in .long 0 for the memory reserve map.
> >
> > Yes.
> 
> 
> >> That said, one could use .space there I suppose.  Its fine the way it
> >> is.
> >
> > I think .space would be the preferred method for adding the padding
> > space at the end in asm format.
> 
> For the space at the end, I agree.  Or use .org 99b+size with 99: at the
> begining of the struct.   The .long 0 was more for memory reserve, where
> the entries might be replaced before assembly.
> 
> >>>>> The total_size says how much data should be copied.  Anything
> >>>>> less and there is data missing.   Assuming zeros is wrong for
> >>>>> most sections (the exception being the memory reserve list
> >>>>> that had a terminating 0 entry within the read portion).
> >>>>>
> >>>>> milton
> >>>>
> >>>> The reason total_size is bigger than the actual size is because I
> >>>> created the blob with extra space using the -S parameter.  It is
> >>>> intentionally bigger.  The extra space is ignored by dtc when
> >>>> creating a
> >>>> dts/asm format output which is why cmalloc() is unnecessary.
> >>
> >> If this is a case of reading in the files it creates, then its wrong
> >> to have the size created less than total_size.  The space needs to be
> >> in the output file.  To have it not be in the output is wrong. For
> >> instance it will not be allocated by objcopy nor the linker when its
> >> inserted into the dtb section of the zImage wrapper, which would lead 
> >> to
> >> scribbling on memory belonging to something else, or at least
> >> unallocated.
> >> Similar for a firmware that treats the dt_struct as binary data.  It
> >> might be loaded just before the initrd for instance.
> >
> > Well, I can see specialized case uses for totalsize greater than
> > stored size: where you know the blob is going to be copied into
> > another staging area with more space, for example.
> 
> That can either be done with your embedding script processing and 
> noticing
> the zeros at the end or by a special option I guess.

Such a possible future special option was all I had in mind when I
said emitting the zeroes should be default rather than only behaviour.

> >>>> I suppose we could require a -f force but I'm not wild about 
> >>>> creating
> >>>> a
> >>>> nanny program.  There is nothing wrong with the blob - it parses 
> >>>> just
> >>>> fine.  If there were problems with the blob contents, other errors
> >>>> would
> >>>> be raised.
> 
> You mean like not creating output for -I fs -O dts when there are
> expected properties (files) missing?  :-)  The kernel booted just
> fine, it was processing /proc/device-tree after all.

> Its probably wrong to check for expected properties when the output
> is dts.  At least the checks should not be more than a warning (that
> you may have selected a subtree).

Yes, yes, I know.  This all comes back to the need for a substantially
reworked warning/error system.

> >>> I think the warning is fine, but not for exactly the reasons you
> >>> state.  Several points:
> >>>
> >>> - At least with v17 input, where it's possible, we probably *should*
> >>> check that an input blob isn't truncated in the middle of the strings
> >>> or structure sections.  That should be more than a warning.
> >>
> >> Or check that (1) the memory reserve list is terminated before this
> >> point, (2) the dt_struct has matching node begin and end count and
> >> ends with tree end, and (3) all strings referenced by dt_struct are
> >> before the read size.
> >
> > I think just checking the header lengths of the sub-blocks should be
> > sufficient at this point.  Checking that the begin/end count matches
> > in the structure block and that all the string references are valid
> > can, I think, be correctly delayed until we actually parse the
> > structure block.
> 
> Checking the sublock lengths is sufficient, but actually more
> restrictive that what I said.   And mine works on older formats
> without the size fields.  But yes, yours is simpler when the fields
> exist.
> 
> Or just leave it an error, fix the output, and make the user fix the
> input.   If you took off the zeros, you can add padding from /dev/zero
> or /dev/random or /etc/motd, as you said the data should not be used.
> 
> milton

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
