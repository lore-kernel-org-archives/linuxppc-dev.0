Date: Thu, 18 Nov 1999 11:01:19 +0100
To: "David N. Welton" <davidw@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: again 2.3.28
Message-Id: <19991118110119.020630@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 17, 1999, David N. Welton <davidw@linuxcare.com> wrote:

>So, we can't use prom_print to print checkpoints and we can't use
>printk yet.

if using BootX, you can use prom_print after mmu_init provided that you
make sure the fb is mapped (look at the function in prom.c for that, it's
called by xmon initialisation).

If you are not using BootX, then you can grab code that make prom_print
available the same way it does with BootX, but with OF. (Basically, it
fills a fake boot_info structure for use by the display code from infos
returned by OF). The code for that is in my iBook patches, look at the
prom.c patches.

In both case, you have to take care of mapping the fb.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
