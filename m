Message-ID: <3FC68039.4080206@jonmasters.org>
Date: Thu, 27 Nov 2003 22:52:41 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Peter Vandenabeele <peter.vandenabeele@mind.be>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: ppc4xx Ports]
References: <3FB416F9.7080303@jonmasters.org> <20031114002023.GA9509@gate.ebshome.net> <3FB423AB.80805@jonmasters.org> <20031114004805.GA9585@gate.ebshome.net> <20031126165238.O7373@mind.be>
In-Reply-To: <20031126165238.O7373@mind.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Peter Vandenabeele wrote:

| On Thu, Nov 13, 2003 at 04:48:05PM -0800, Eugene Surovegin wrote:
| [...]
|
|>I don't have any PTE/TLB related problems on 405GP/405GPr.
|
|
| On the PowerPC 405 in the Virtex-II Pro, we needed to turn off
| half of the TLB entries as per "Solution 12" on
|
http://support.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&iCountryID=1&getPagePath=14052
|
| "... Limit TLB depth to 32 entries by only using even entries in the
TLB ...."
|
| Peter
|

Hi there,

I think I mentioned before that I already fixed that for the port I am
working on by incrementing next TLB entry by 2 if on Virtex II Pro.
Actually if you check a post I made to comp.arch.fpga over the summer...
I call it CONFIG_BROKEN_XILINX_TLB or something like that (other ports
are now starting to fix that too) - several other errata too.

[ Like I said before we have two similar ports now so once I can release
the modifications then we should look at how this can help us. The stuff
I am working on at the moment is not going out yet and for various
commercial reasons I prefer not to disclose who it is for, etc. ]

The problem I currently have was traced when using the dynamic linker
library from my Powerbook Debian on my test NFS filesystem and then
running up something compiled against the main normal libc with floating
point register save restore context stuff. So this leads me on to...

...there is something wrong with the trapping and handling of stfd and
similar operations on my port when the kernel tries to do the
copy_to_user to actually change the saved floating point register set.
Now that I know where the bug is I can fix it next week[0].

Jon.

[0] I work a 3 day week but take work home with me too much so tracked
this down today when debugging in Starbucks without the hardware but
with my Powerbook and various printouts...using 9600bps dialup proxied
through my Zaurus wifi because no IR on Powerbook revision. ;-).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
