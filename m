Date: Tue, 22 Feb 2000 15:24:43 +0100
To: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: eieio & ld_le, ld_be
Message-Id: <20000222152443.010969@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 22, 2000, FASSINO Jean-Philippe
<jeanphilippe.fassino@cnet.francetelecom.fr> wrote:

>Just a question about ld_le* and ld_be*.
>This function do a io read and enforce in-order execution with eieio.
>
>Does eieio is really necessary when load value from IO ??
>Maybe some computer (SMP, pci, ...) require that !
>But, i try ld_* without eieio on my computer (G4) and that work well.

Neither ld_le* nor ld_be* should do any eieio (and they don't in the
kernel sources I just checked).

Howeverm in_le*/out_le* etc... do it. Those are necessary to enforce
ordering of accesses when manipulating a hardware device. It's possible
that the non-cachable & guarded state of io pages make it less important
on G3, but it's definitely necessary to be completely safe.

If you are maniuplating in-memory datas that are not related to any io
hardware device, then you don't need eieio.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
