Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A
	cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
In-Reply-To: <200405302331.35357.toojays@toojays.net>
References: <200405302331.35357.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1085956980.9638.17.camel@gaston>
Mime-Version: 1.0
Date: Mon, 31 May 2004 08:43:00 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-05-31 at 00:01, John Steele Scott wrote:
> Hi all,
>
> I have written a patch against kernel 2.6.6 which lets the pmac cpufreq driver
> support dynamic frequency scaling on the 7447A cpu in my new iBook. It also
> fixes the incorrect clock speed reporting (i.e. on boot 2.6.6 reports cpu is
> running at 1066 MHz when really it is 533 MHz).

OF is probably not reporting wrong frrequency, check your bogomips. I
suspect your clock chip isn't configured properly at boot, like with
other newer models. I need to hack the proper bits in. I'll have a look
at this asap.

> Unfortunately, if I use this to set my cpu frequency up to 1 GHz, my system
> locks up hard when I try and do something cpu-intensive. Christiaan Welvaart
> has tested the previous version of this patch (functionally the same, but a
> bit messier), and on his system it works fine. Yet even if I use the exact
> same kernel as him, my system locks up. Both systems are 1 GHz, 12" iBooks.
>
> Does anyone have any ideas on why this might not work on my system? Is there
> something else that needs to be looked at when increasing the frequency after
> booting?

You might need the proper clock chip tweaks.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
