Date: Thu, 10 Dec 1998 12:13:23 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Alois Fertl <alois_fertl@TalkNet.de>
cc: Cort Dougan <cort@persephone.cs.nmt.edu>, Matt Porter <mmporter@home.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        VALETTE Eric <valette@crf.canon.fr>
Subject: Re: Linux-2.1.129 boot on MCP750 <fwd>
In-Reply-To: <366ED369.C34A8FE5@talknet.de>
Message-ID: <Pine.HPP.3.96.981210120229.17076x-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 9 Dec 1998, Alois Fertl wrote:

> 
> Yes its possible to change the locations where ppcbug loads via the net
> via the "niot" command. To my experience this address is only used if
> the "network prep mode" is switched off. If you switch this off the
> ppcbug
> does no longer prepare residual data (use "nbh" and you will see that R3
> is zero). No residual data means that the raven is not detected and the
> code uses direct access to scan for PCI devices. As this will not work
> on the raven and you end up with no PCI at all.

A solution would be to add code to check if the value returned from
reading at 0x80800008 returns something like a host bridge (0x0600????
little endian). 

Oe maybe the other way around: fall back to direct config method if
after writing 0x80000008 at 0x80000cf8, 0x80000cfc does not show to be a
host bridge.

The preceding assumes that host bridge is device 0 on the PCI bus (it
usually is). But in any case I prefer to rely on residual data if
available: residual data is necessary to use the OpenPIC which is inside
the Raven. 

> I do not know however which kernel version introduced this method of
> detecting the raven via the residual data. If I remember correctly it
> was possible to boot at least 2.0.32 with network prep mode switched
> off.

Note that this was because of netboot problems onn the MVME2600 that I
started wrting my bootloader. It self relocates according to the free
areas as given by the residual data and is compiled with -m relocatable
option to make it 100% position independant. But it has other problems
since it seems to only work on MVME2603 (nor even 2604). I would like to
put my hands on some other HW because trying to debug this low level code
through the net is not fun. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
