From: John Steele Scott <toojays@toojays.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A cpu
Date: Mon, 31 May 2004 10:02:53 +0930
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
References: <200405302331.35357.toojays@toojays.net> <1085956980.9638.17.camel@gaston>
In-Reply-To: <1085956980.9638.17.camel@gaston>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200405311003.21439.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Mon, 31 May 2004 08:13 am, Benjamin Herrenschmidt wrote:
> OF is probably not reporting wrong frrequency, check your bogomips. I
> suspect your clock chip isn't configured properly at boot, like with
> other newer models. I need to hack the proper bits in. I'll have a look
> at this asap.

Here's a few bits and pieces taken from an unpatched kernel:

bash-2.05b$ cat /proc/cpuinfo
processor       : 0
cpu             : 7447A, altivec supported
clock           : 1066MHz
revision        : 1.1 (pvr 8003 0101)
bogomips        : 530.43
machine         : PowerBook6,5
motherboard     : PowerBook6,5 MacRISC3 Power Macintosh
detected as     : 287 (iBook G4)
pmac flags      : 0000000a
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld

bash-2.05b$ ls /proc/device-tree/cpus/PowerPC,G4/
altivec               device_type          PowerPC,G4
available             dynamic-power-step   processor-to-bus-ratio*2
bus-frequency         existing             recalced-clock-frequency
clock-frequency       graphics             reg
config-bus-frequency  i-cache-block-size   reservation-granule-size
cpu-info              i-cache-sets         rounded-clock-frequency
cpu-version           i-cache-size         state
data-streams          l2-cache             timebase-frequency
d-cache-block-size    l2cr                 tlb-sets
d-cache-sets          linux,phandle        tlb-size
d-cache-size          name                 translations
dcba                  needs-delayAACK
dcbz                  performance-monito

(Notice there is no min/max-clock-frequency.)

bash-2.05b$ cat /proc/device-tree/cpus/PowerPC,G4/clock-frequency | xxd
0000000: 3f94 0aa8                                ?...
bash-2.05b$ python -c 'print "%d" % 0x3f940aa8'
1066666664

> You might need the proper clock chip tweaks.

Is there any datasheet or similar which describes this chip?

thanks,

John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
