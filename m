Date: Mon, 2 Aug 1999 19:42:08 -0700 (PDT)
From: Jeffrey Karl Lassahn <jkl@teleport.com>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org, linux-pmac@samba.anu.edu.au
Subject: Re: OF booting of G3-upgraded 7600?
In-Reply-To: <199908021746.TAA00306@piglet.cpu.lu>
Message-ID: <Pine.GSO.4.10.9908021936020.3756-100000@user2.teleport.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


One simple thing that bit me is that the machine can try to boot before
the hard drive hs spun up.  This gives the default catch you're seeing,
and it depends on CPU speed.

I fixed it with an OpenFirmware change that I haven't bothered to fully
understand, but which seems to work great.  That is:
set 
boot-command
to
begin ['] boot catch 1000 ms cr again

(I got this from some unremembered place on the Web that discusses Open
Firmware boot problems...)

-JKL


On Mon, 2 Aug 1999, Michel Lanners wrote:

> 
> Hi there,
> 
> Anybody have any idea why a 7600 upgraded with a littleJoe G3 card
> can't boot through OF? I always get a 'Default Catch'.
> 
> I didn't have the leasure to analyze this further, but anyway
> FAQ-o-Matic didn't offer any advice.
> 
> So far, I've been forced to boot with BootX, which works well, but is a
> pain in the rear when testing new kernels (through the fact it forces me
> to copy the new kernel over to MacOS).
> 
> As has been reported before, mounting HFS partitions directly can
> lead to massive filesystem corruption (it happened to me as well...
> while accidentaly overwriting an existing file), so I'm now moving my
> kernels through a second machine via FTP....
> 
> Thanks
> 
> Michel
> 
> -------------------------------------------------------------------------
> Michel Lanners                 |  " Read Philosophy.  Study Art.
> 23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
> L-1710 Luxembourg              |
> email   mlan@cpu.lu            |
> http://www.cpu.lu/~mlan        |                     Learn Always. "
> 
> 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
