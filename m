Date: Fri, 29 Sep 2000 20:12:01 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, Michel Lanners <mlan@cpu.lu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <Pine.LNX.4.10.10009291319510.383-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0009292001490.1214-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Sep 2000, Geert Uytterhoeven wrote:

> On a PC, the PCI bus (with ISA) is bus 0, while AGP is on bus 1.
>
> Hmm, I'm starting to wonder how legacy VGA works then, since the primary video
> card these days is usually on the AGP bus, i.e. bus 1. But it's quite possible
> this is some weird legacy quirk again...


>From the RAC.Notes in the xf4 docs:
...
 Systems that host  more than one bus system  link these together using
 bridges. Bridges  are a  concern to  RAC as they  might block  or pass
 specific  resources.  PCI-PCI  bridges  may  be set  up  to  pass  VGA
 resources to the  secondary bus. PCI-ISA buses pass  any resources not
 decoded on the primary PCI bus  to the ISA bus. This way VGA resources
 (although  exclusive on  the ISA  bus) can  be shared  by ISA  and PCI
 cards.  Currently HOST-PCI bridges are not yet handled by RACY as they
 require specific drivers.
...

xf4 plays a lot with this (enabling/disabling cards/bridges) to get
multihead support with cards that use VGA resources.

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
