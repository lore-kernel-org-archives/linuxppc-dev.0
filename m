Return-Path: <m.nazarewicz@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
	[210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id 6392AB6EF7
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 02:06:56 +1000 (EST)
MIME-version: 1.0
Content-type: text/plain; charset=utf-8; format=flowed; delsp=yes
Received: from eu_spt2 ([210.118.77.14]) by mailout4.w1.samsung.com
	(Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009;
	32bit)) with ESMTP id <0L6D00M4EORI0K80@mailout4.w1.samsung.com> for
	linuxppc-dev@ozlabs.org; Fri, 30 Jul 2010 17:06:54 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
	by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul
	14 2004)) with ESMTPA id <0L6D009WLORGQF@spt2.w1.samsung.com> for
	linuxppc-dev@ozlabs.org; Fri, 30 Jul 2010 17:06:54 +0100 (BST)
Date: Fri, 30 Jul 2010 18:08:23 +0200
From: =?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?= <m.nazarewicz@samsung.com>
Subject: Re: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-reply-to: <20100730152602.GA28042@pengutronix.de>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-id: <op.vgny39097p4s8u@pikus>
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<op.vgnwp8107p4s8u@pikus> <20100730152602.GA28042@pengutronix.de>
Cc: Cliff Cai <cliff.cai@analog.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>, Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>, Philipp Zabel <philipp.zabel@gmail.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Felipe Balbi <felipe.balbi@nokia.com>,
	Andrea Gelmini <andrea.gelmini@gelma.net>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Fabien Chouteau <fabien.chouteau@barco.com>,
	Dan Carpenter <error27@gmail.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Vladimir Zapolskiy <vzapolskiy@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vincent Sanders <support@simtec.co.uk>, Marc Singer <elf@buici.com>,
	=?utf-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Tobias Klauser <tklauser@distanz.ch>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	Eirik Aanonsen <eaa@wprmedical.com>, Mike Frysinger <vapier@gentoo.org>,
	Thomas Dahlmann <dahlmann.thomas@arcor.de>,
	linux-geode@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	Magnus Damm <damm@igel.co.jp>, Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org,
	Anatolij Gustschin <agust@denx.de>, Eric Miao <eric.y.miao@gmail.com>,
	=?utf-8?Q?N=C3=A9meth_M=C3=A1rton?= <nm127@freemail.hu>,
	Jiri Kosina <jkosina@suse.cz>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-usb@vger.kernel.org, Harro Haan <hrhaan@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cory Maccarrone <darkstar6262@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 30 Jul 2010 17:26:02 +0200, Uwe Kleine-K=C3=B6nig <u.kleine-koen=
ig@pengutronix.de> wrote:
> On Fri, Jul 30, 2010 at 05:16:46PM +0200, Micha=C5=82 Nazarewicz wrote=
:
>> On Fri, 30 Jul 2010 16:49:14 +0200, Uwe Kleine-K=C3=B6nig <u.kleine-k=
oenig@pengutronix.de> wrote:
>>
>>> This is like usb_gadget_register_driver with the only difference tha=
t it
>>> gets the bind function as parameter instead of using driver->bind.  =
This
>>> allows fixing section mismatches like
>>>
>>> 	WARNING: drivers/usb/gadget/g_printer.o(.data+0xc): Section mismatc=
h in
>>> 	reference from the variable printer_driver to the function
>>> 	.init.text:printer_bind()
>>> 	The variable printer_driver references
>>> 	the function __init printer_bind()
>>>
>>> by using usb_gadget_probe_driver with driver->bind =3D NULL.  When a=
ll
>>> drivers are fixed to use the new function the bind member of struct
>>> usb_gadget_driver can go away.
>>>
>>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de=
>
>>> Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
>>> Cc: Greg Kroah-Hartman <gregkh@suse.de>

BTW. Dunno if there is a reason to put me on Cc and Greg will be in
Signed-off-by anyway.

>>> ---
>>> Hello,
>>>
>>> there is an alternative patch in Greg's tree [1], but IMHO mine is
>>> better as it doesn't need __ref.
>>>
>>> Thoughts?
>>
>> Personally I don't see advantage of this over changing the __init to =
__ref.
>> Or am I missing something?  I see your patch as an unnecessary API ch=
ange.
>> The way I understand it, __ref was introduced exactly for cases like =
this
>> one where function is referenced from "normal" data but used only dur=
ing
>> init.  Could you try to clarify for me why you think your solution is=

>> better then mine?

> - Using __ref instead of __init moves all bind functions from .init.te=
xt
>   to .text and so the code isn't freed after booting or module loading=
.
>   (OK, you could fix this by marking the driver structs as __ref and
>   keep __init for the bind functions.)

I believe this to be untrue.  __ref puts code in .ref.text which AFAIK i=
s
freed.

> - Using __ref might hide section mismatches.  (Your patch hasn't this
>   problem as the bind functions used to live in .init.text, so any
>   reference to .init should be OK assuming that it was OK to live in
>   .init.text in the first place.  But when marking the driver structs
>   this is an issue.)  That's why I don't like __ref and said my patch
>   were better as it doesn't make use of it.
>
> - The bind functions are only called at init time, so there is no need=

>   to save a pointer to it.

OK, I see some merit in this approach.  However, the same issue is with
usb_configuration and ?usb_composite_driver -- those should be changed
in the same way or it would defeat the purpose of the patch.

-- =

Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=3D./ `o
| Computer Science,  Micha=C5=82 "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
