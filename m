In-Reply-To: <19991123105212.F16540@hq.fsmlabs.com>
Date: Tue, 23 Nov 1999 19:08:01 +0100
To: Cort Dougan <cort@fsmlabs.com>
CC: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness (patch)
Message-Id: <19991123190801.029609@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 23, 1999, Cort Dougan <cort@fsmlabs.com> wrote:

>Have you tried the rs6000 quik on the g3's?  I've heard people have had
>success with the modifications I made but haven't been able to get ahold of
>a g3 for long-term tests.  I'd like to combine the two if we could.

rs6000 quik is quik2.0 in ELF package ? I think I tried it but i failed
finding the boot device. I'll look at it again tomorrow.

When I tried to do what quik does in my bootloader (memmove'ing the
kernel to 0 before booting it), I ended up in a default catch. On the new
Macs, OF doesn't seem to map all the memory by default and won't let you
claim low-memory vectors so easily. I managed to map them without doing a
claim, but I had then problems instanciating RTAS from the kernel then.
Also, quik lacks support for the initrd. Since BootX doesn't work on the
new iMac DV (and I may not find a fix soon, it's a weird problem with
MacOS shutdown), there is need for an OF bootloader with initrd support
for installing on those machines.
(kernel with piggyback initrd may work too, but I heard of several people
who failed building them, so I added an option to load it from a separate
file).

Basically, my bootloader contains bits of quik, bits of poof, and a
simple abstract mecanism for ading file systems to it (currently, only
ext2 is built-in, iso will come soon and I'm thinking about UFS for
netbsd for example). Once it works, I plan to make it graphical with some
way to "detect" the possible boot devices (I already have an almost
working algorithm for that).

>I think Yellowdog already has their cd bootable from macs.

I discussed with them about this and they didn't manage to make this
work. The mini-ISO filesystem I'll add to yaboot comes from them. I'll do
more tests with CDs later, when we have a definitive solution to those
kenrel entry problems.

>} Ultimately, this will allow bootable CDs for Macs (with the help of
>} miBoot for oldworld machines), and with a bit more GUI and the help of an
>} installer, we'll be, I hope, the primary bootloader for newworld Macs. I
>} plan to slowly abandon BootX support for those machines since it involves
>} too many hacks to work around various issues related to getting rid of
>} MacOS and problems with devices MacOS put in a non-reset state).

Did you had a chance to test my new head.S/prom.c patch ? 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
