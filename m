Date: Thu, 12 Oct 2000 19:44:24 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <19340906084536.29942@192.168.1.2>
Message-ID: <Pine.LNX.4.21.0010121922330.977-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Benjamin Herrenschmidt wrote:

> Unfortunately, there's no simple way to allow two busses to have the
> legacy IOs. That means on UniN machines that they'll be available either
> on the AGP bus, or the external PCI bus, but not both.

That wont help much for the xfree side, we need legacy IO/mem access
to both busses.

> What you might do is to consider the ISA io base to be the IO base of the
> bus that holds the card for which you are trying to run the BIOS. (By
> using the syscall to retreive this IO base for the VGA card) instead of
> asking the kernel for the "legacy" IO base.

Thats what i am trying to do at the moment, unfortunately its not very
easy there are many places that legacy IO is used and for most of them
the calls are inside generic modules that usually have no idea about
which card they use.

If as Gabriel suggested is possible to redirect the VGA part of the
IO space then we could talk to all cards which will simplify things.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
