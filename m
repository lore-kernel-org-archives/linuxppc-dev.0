Date: Mon, 26 Nov 2001 22:24:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Message-ID: <20011126222449.E13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111262101.AA22136@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111262101.AA22136@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 26, 2001 at 01:01:49PM -0800, Michael Sokolov wrote:

> ChangeSet@1.666, 2001-11-19 09:10:26-07:00, trini@bill-the-cat.bloom.county
>   Remove register magic from platforms which use 'simple'.  A few
>   new platforms forgot parse_bootinfo(find_bootinfo()) as well.
>
>   arch/ppc/platforms/k2_setup.c
>     1.17 01/11/19 09:10:26 trini@bill-the-cat.bloom.county +0 -15
>     Remove cmd_line and initrd register magic.
>
> is a problem for me. On the K2 I do not use zImage or the braindead PeeMON
> firmware that it assumes, instead I load vmlinux directly by occult. I need to
> continue to able to do this, and I need to keep the interface to vmlinux
> register-based so that I can load vmlinux into memory by occult, put the right
> values in the right registers, and jump to it. A pointer to bi_recs in a
> register is fine, but looking for bi_recs in the magic location isn't. (The
> kernel has already been loaded into memory by occult when I get to it, and
> without the original ELF header or System.map I cannot determine where will it
> look for bi_recs in find_bootinfo.)

Er, why can't you find the magic location for the bi_recs and set that
as well as the other registers you need to?

> The patch below makes the K2 vmlinux expect a pointer to bi_recs in R3 like I
> do on the Adirondack and makes the "simple" zImage goo pass a pointer to its
> magic bi_recs in R3.

And breaks all of the other ports which use 'simple' and expect bi_recs
in the 'normal' place.  For now I'd much rather add back in the register
checks.  For 2.5 we can agree on a less magical and more predictable
location.  Would somewhere around the end of memory work for you?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
