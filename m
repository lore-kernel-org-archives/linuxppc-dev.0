Message-ID: <366ED369.C34A8FE5@talknet.de>
Date: Wed, 09 Dec 1998 19:45:45 +0000
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: Matt Porter <mmporter@home.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        VALETTE Eric <valette@crf.canon.fr>
Subject: Re: Linux-2.1.129 boot on MCP750 <fwd>
References: <SIMEON.9812091612.C@g-mun-af.muenchen.europe.mcd.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yes its possible to change the locations where ppcbug loads via the net
via the "niot" command. To my experience this address is only used if
the "network prep mode" is switched off. If you switch this off the
ppcbug
does no longer prepare residual data (use "nbh" and you will see that R3
is zero). No residual data means that the raven is not detected and the
code uses direct access to scan for PCI devices. As this will not work
on the raven and you end up with no PCI at all.
I do not know however which kernel version introduced this method of
detecting the raven via the residual data. If I remember correctly it
was possible to boot at least 2.0.32 with network prep mode switched
off.

> 
> You can change the address that ppcbug loads the image to.  I pointed mine
> at the end of memory to keep it out of the way.  The boot code for prep is
> very delicate right now due to the many many addresses that boards load
> the image at so anything that can make it easier (such as moving the
> address the kernel is loaded at) I want to take advantage of.
> 
> }> There is a problem in boot/misc.c which manifests only
> }> if netboot is used. Current ppcbug netboots at 0x5000 and
> }> this forces decompress to overwrite its own source.
> }
> }Can you elaborate on which versions of ppcbug this is a problem with and
> }in what cases?  I have been booting the kernel on MVME23/26/27/36xx and an
> }MCP750 without seeing this problem...maybe cause my MCP750 has an older
> }rev of ppcbug.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
