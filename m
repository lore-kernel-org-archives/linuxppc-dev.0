From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh in 2.4.0-test1
Date: Sun, 4 Jun 2000 14:29:05 +0200
Message-Id: <20000604122905.30293@192.168.1.10>
In-Reply-To: <Pine.LNX.4.05.10006041259560.514-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10006041259560.514-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 4, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>take into account that on CHRP boxes with both ISA and OpenPIC, the interrupt
>numbers have to be fixed up. Below is the patch that made it work for me.
>
>Before I check it in into bitkeeper: should I replace the test
>
>    _machine == _MACH_chrp
>
>by
>
>    !strncmp(model, "IBM,LongTrail", 13)
>
>or are there other CHRP models bitten by this as well?

Hum, that's a side effect of enabling the new interrupt tree parsing on
all machines. Well, that's more or less my fault: the pmac_newworld
variable gets set to 1 on CHRP, thus enabling the new interrupt tree
parsing on them.

A better fix would be to only enable pmac_newworld on pmacs. (But still
keep the interrupt tree parsing for chrp since it's basically a chrp
thing that Apple implemented in newworld machines).

Note that this problem may be present in recent 2.2.x kernels too.
However, a subtle difference in 2.2.x is that _machine may not be
initialized yet when finish_device_tree() is called.

I'll look into those today and push fixed to both bk trees.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
