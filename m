Date: Fri, 23 Jul 2004 10:09:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: random ramblings on 8xx patches (long and tedious :-) 
In-Reply-To: <20040723133703.1A753C109F@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0407230947570.5108@localhost.localdomain>
References: <20040723133703.1A753C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 23 Jul 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0407230821050.4487@localhost.localdomain> you wrote:
>>
>>    CONFIG_850
>>    CONFIG_PPC_850
>>    CONFIG_8xx_850
>>
>> thoughts?  yes, this is just me being pedantic.  it gets worse. :-)
>
> How far do you want to take this?
>
> "850" may not  be  detailed  enough  -  is  it  a  MPC850,  MPC850DE,
> MPC850DSL, or a MPC850SR ?
>
>
> There is at least 40 differnt models of 8xx processors.  Go  and  add
> 82xx  and  85xx  and  52xx  and than start working down the 4xx, 7xx,
> 74xx, ... lines? I think this gives a LONG list...

possibly, but there's no need for it to be infinitely detailed.  if
you look at arch/ppc/config.in, there's obviously a coarse
categorization with things like CONFIG_6xx, CONFIG_8xx and so on.
at the other extreme, there's specific models like CONFIG_ARCTIC2,
etc.

there's also *some* current refinement somewhere in the middle with
conditionals like:

if [ "$CONFIG_TQM823M" = "y" -o \
        "$CONFIG_TQM850M" = "y" -o \
        "$CONFIG_TQM855M" = "y" -o \
        "$CONFIG_TQM860M" = "y" -o \
        "$CONFIG_TQM862M" = "y" -o \
        "$CONFIG_NSCU"    = "y" ]; then
         define_bool     CONFIG_TQM8xxM  y

so *someone* must have thought this approach was a good idea at some
point. :-)

so the obvious question is, is there any value for more of this
mid-level categorization?  if not, then we can just forget the idea
and move on.

but if there is, no one says it has to be patched in all at once.
different people who work with different processors can submit patches
relative to their area to make future work easier.  if someone works
primarily with, say, 4xx processors, they can submit a patch to add to
the config.in file for that family refining the 4xx family.  whatever
makes their life easier. if no one cares about a particular family, no
big deal.

as a thought, what about additional variables of the form CONFIG_850,
CONFIG_7xx, CONFIG_74xx, etc.  (sadly, as i mentioned earlier, there's
already some inconsistency between names like CONFIG_8xx and
CONFIG_PPC_5xxx with that internal "PPC_".  technically, i would have
preferred variables of the form CONFIG_PPC_????, but i think the trend
has already been established.)

so, to start things off, here's a proposal.  if this kind of
refinement would have made/will make your life easier, email me
directly with the patch you'd like to see added.  i'll collect them
all, paste them together, make sure they're aesthetically consistent,
examine the final result as if i know what i'm doing, and submit the
whole thing as one big patch.  you don't need to be perfect with the
first attempt, you can always save further, more detailed refinement
for a later patch.

thoughts?

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
