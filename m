Message-Id: <5.1.0.14.2.20010717110248.03890268@mail.netsurf.de>
Date: Tue, 17 Jul 2001 11:11:34 +0200
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: 2.4 - buttons, temperature, ictc
Cc: linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20010717004540.255d1b2c.jpgarcia@execpc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 07:45 17.07.2001, Joseph P. Garcia wrote:
>mostly a rehash of patches from the past, and mostly not mine originally,
>attached is a patch.gz against the latest BenH 2.4 kernel.  It adds
>support for:
>- repeating brightness buttons
>- volume buttons (using kernel space volume control interface)  supported
>sound cards only (screamer, burgundy?)
>- temperature support for my wallstreet 750CX, which doesn't use TAU. (not
>sure what CPUs support this coding.  no checks yet)
>- ICTC proc support  (I still have this in my kernel.  might use it one day)
>- small ATY resource tweak in pmac_pci.c (I like it at 0x830--.  not sure
>if 0x800-- is best or not.  ignore if you like.)
>
>I'm willing to help see some of these get into a public tree.  BenH showed
>interest in the repeating and volume buttons, but with the noted exception
>of providing user space an interface to use them.  This coding has a
>broken new input layer volume key support, which if completed, and
>supported by a daemon, could lighten the code bulk extensively. (links
>between adbhid - pmacfeatures - dmasound[module] aren't pretty)
>
>figured now was a good time to remind people these things still exist.

I object to putting anything you marked with CONFIG_PMAC_VOLUME into the
kernel, it's worse enough we have CONFIG_PMAC_BACKLIGHT in there. I'll
merge your "input_report_key" into my 2.5 adbhid.c source though, thx.

With 2.5 even CONFIG_PMAC_BACKLIGHT in adbhid.c will go away and you _have_
to use the event devices then, so you better start using them _now_. Taking
kernel bloating shortcuts is not the way to go IMHO.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
