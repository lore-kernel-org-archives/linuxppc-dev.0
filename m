Date: Thu, 18 Feb 1999 15:00:17 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jesper Skov <jskov@cygnus.co.uk>
cc: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <oovhh0w16z.fsf@lassi.cygnus.co.uk>
Message-ID: <Pine.HPP.3.96.990218144506.482S-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On 18 Feb 1999, Jesper Skov wrote:

> >>>>> "Gabriel" == Gabriel Paubert <paubert@iram.es> writes:
> Gabriel> I had the impression that the APUS I/O accesses had to use
> Gabriel> non byte swapped instruction, so that merging the APUS with
> Gabriel> the other would be hard. Is there something I missed ?
> 
> True, APUS doesn't require byte swapping. But I don't see how this
> makes it hard to integrate APUS.

It means that you can't run the same kernel image, it would require
deciding between a byte swapping and non-byte swapping instruction on each
and every in[wl] and out[wl] instruction. It is possible to build a
CHRP/PreP/Pmac kernel and then only select the right drivers, but I can't
see how you can merge CONFIG_APUS in it without a huge performance and/or
size penalty (and do it in an acceptably clean way, I have some ideas
about dirty trick solutions).

> Gabriel> I don't want the kernel to execute conditional code or to
> Gabriel> call a subroutine for every I/O access, this is bloat and/or
> Gabriel> inefficiency for the sake of it.
> 
> This is a valid concern. I don't know if it's possible to do anything
> about this. 
> 
> It may be the case that none of the Amiga drivers use the same IO
> macros as other drivers use. As I remember it, there are two set of
> macros. But it's a long time since I looked at that, I could be wrong.

No they don't, have a look at include/asm-ppc/io.h, there is a lot of
ifdef on CONFIG_APUS. This can't reasonably be made into a run time
option IMHO.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
