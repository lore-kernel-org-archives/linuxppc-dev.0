Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 23 Jul 2004 08:34:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: random ramblings on 8xx patches (long and tedious :-)
In-Reply-To: <20040722104621.B17686@home.com>
Message-ID: <Pine.LNX.4.60.0407230821050.4487@localhost.localdomain>
References: <Pine.LNX.4.60.0407220638390.3652@localhost.localdomain>
 <20040722104621.B17686@home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 22 Jul 2004, Matt Porter wrote:

> On Thu, Jul 22, 2004 at 08:00:01AM -0400, Robert P. J. Day wrote:
>
> [Remove long explanation]
>
>>    thoughts?  i'm willing to help with menu reorg -- my only
>> contribution to the 2.6 kernel was to thoroughly restructure the
>> "Filesystems" menu.  which means i like it, and i don't care what
>> *you* think. ;-)
>
> You raise a lot of interesting concerns on usability for a newbie.
> Descriptive menu options with useful help info are a good thing.
> Please send a patch with your proposed changes so it can be reviewed.

the first addition i'd like to see is a set of extra conditionals
added to arch/ppc/config.in, to refine the type of processor.  in some
cases, it's not enough to know that you have an 8xx, and it's *too*
refined to know that you have, say, a TDM850M.  sometimes, you need to
know only that you have an 823, or 850, or whatever.

perhaps variables:

   CONFIG_8xx_823
   CONFIG_8xx_850
   CONFIG_8xx_860

or alternatively named

   CONFIG_PPC_823
   CONFIG_PPC_850

and so on.  i've already seen code in the kernel tree (can't remember
where, sadly) that goes through a tedious preprocessor check when all
it wanted to know was the actual processor.  and all of this extra
checking and setting could be done entirely within the
arch/ppc/config.in file, with no harm to other files or small animals.
(i suspect the same might hold true for 4xx, 6xx and others, but i
haven't looked at those yet.)

i can't design this patch just yet, as i'm not sure how many different
variants are worth keeping track of.  if there's a list someone could
point me at, that would be just ducky.

rday

p.s.  sadly, there's some inconsistency in the way the current
variable names were chosen.  in that same file, we have both of
CONFIG_8xx and CONFIG_PPC_5xxx.  even thought it's more verbose, it
might have been safer to keep that "PPC" internal string to avoid
potential conflicts.  so it's a tossup as to what variable name would
be the best choice to identify an 850:

   CONFIG_850
   CONFIG_PPC_850
   CONFIG_8xx_850

thoughts?  yes, this is just me being pedantic.  it gets worse. :-)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
