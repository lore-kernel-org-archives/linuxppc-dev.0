Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Mar 2007 13:46:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/7] boot: use a common zImage rule
Message-ID: <20070321024601.GE27969@localhost.localdomain>
References: <boot-00.miltonm@bga.com> <boot-01.miltonm@bga.com>
	<20070320033039.GA21124@localhost.localdomain>
	<f7b20d0a2660652ca1ddbb69eb41feb5@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7b20d0a2660652ca1ddbb69eb41feb5@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 08:47:20AM -0500, Milton Miller wrote:
> 
> On Mar 19, 2007, at 10:30 PM, David Gibson wrote:
> 
> > On Mon, Mar 19, 2007 at 02:58:07PM -0600, Milton Miller wrote:
> >> Before the plethora of platforms gets any worse, establish a common
> >> rule to invoke the wrapper for any platform.  Add arguments to
> >> the rule for initrd, dts, dtb, etc.   Show example usage with initrd.
> >
> > The problem with this patch is that while the wrap command can take a
> > dts or dtb, there's no way to specify which should be used with each
> > target.
> 
> I thought a bit about that before I posted, but didn't write anything.
> We could add standard varable names dts-$(platform) dtb-$(platform),
> since make would default such names as unset.

Well, that works until we have a platform that can operate with
several different dtbs.  I believe Scott's cuboot stuff will have this
property.

> But this does raise the point, instead of listing the image names, 
> should
> we be seelcting the platforms and generating the image names with the
> expansion.   That would save us stripping of zImage to get the platform
> name in the rule.

That sounds like a good idea.  $(platform-y) instead of $(image-y).

> I'll try to test this later.
> 
> Should I respin patch 3, add FORCE, without this so we can merge that
> first?   I put this one first so there would be less adding rules that
> would be removed later, but the other is really a bugfix and this is
> a cleanup.

Yes, I think that's a good idea.  Apart from the textual conflicts 2-7
look sensible.  I like the idea of patch 1, but it heads into some
complications that need more thought.

So, some more thought...

I don't like the idea of a per-platform dts variable (as above),
because there will be platforms which can support more than one device
tree.  I also don't like the idea of a single variable giving the dts,
since that takes us back to one-board-per-config, even when the actual
zImage code is common across multiple boards.

There are actually three parameters (apart from the vmlinux itself)
which determine the final bootable binary:
	1) what code to include in the zImage
	2) the included device tree (if any)
	3) exectable packaging (ELF, uImage, etc.)

These are certainly not orthogonal; most combinations of the 3 won't
make sense.  But, the parameters are independent in the sense that for
any 2 of them, there are situations in which there are multiple values
that could make sense for the other one.  For example:
	- if (1) = Ebony wrapper and (2) = Ebony device tree, the
binary can be pacakged either for cuboot or for treeboot
	- if (1) = Open Firmware wrapper and (2) = no device tree,
then (3) can be ELF or COFF, depending on the format supported by the
OF version in question.
	- if (1) = wrapper for cuboot on mpc83xx and (3) = uImage,
then there are several device trees which could be used, since there
are several mpc83xx boards
	- it's not hard to image a board that has two firmware
versions with incompatible properties such that if (2) = SomeBoard's
device tree and (3) = whatever then (1) could sensibly be either be
"SomeBoard old firmware wrapper" or "SomeBoard new firmware wrapper".

Then there's the possibility of a similar firmware running on several
different boards, and having a zImage which incorporates several
device trees, picking the right one based on a firmware-supplied board
ID of some sort.

Right now the Makefile targets can select both "platform", which picks
both (1) and (3) and, seperately, the device tree, (2).

So, thinking about it in this framework.  It's the job of the wrapper
script to take (in whatever form) the values of (1), (2) and (3) and
produce an image.  It's the job of the Kconfig and Makefile between
them to generate, based on the kernel config, a list of (1)-(2)-(3)
triples and invoke the wrapper for all of them.

Quite how best to achieve this is not yet obvious to me.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
