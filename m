Date: Wed, 7 Nov 01 13:13:11 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111072113.AA06255@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: i8259.c cleanup
Cc: Sven.Dickert@planb.de, davidm@amberdata.demon.co.uk,
	hollis@austin.ibm.com, paubert@iram.es
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es> wrote:

> The address is not always 0xbffffff0, it is bridge dependent. However this
> address is normally found in OF device tree, in residual data and as a
> last resort could be made host bridge dependent. It has to be ioremapped
> anyway...

OF device tree, residual data, etc. all assume PREP/CHRP/PMAC mentality. There
are also other PPC boards supported in the tree. Those embody all machine
knowledge in the board port. They already have to have full knowledge of every
chip on the board, including the host bridge.

> I actually wonder
> whether it would be better to split it in two cases:
>
> - 8259 is the only interrupt controller in the system
>
> - 8259 is cascaded interrupt controller on an openpic

These are not the only possibilities. Adirondack, for example, has the PC-style
8259 pair cascaded to the Adirondack interrupt controller (completely original
design), which drives the INT# lines to the two CPUs.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
