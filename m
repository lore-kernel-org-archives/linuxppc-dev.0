Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E13B1007D7
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 04:58:53 +1000 (EST)
Date: Fri, 30 Jul 2010 20:57:04 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?Q?Micha=C5=82?= Nazarewicz <m.nazarewicz@samsung.com>
Subject: Re: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
Message-ID: <20100730185704.GB25446@pengutronix.de>
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<op.vgnwp8107p4s8u@pikus> <20100730152602.GA28042@pengutronix.de>
	<op.vgny39097p4s8u@pikus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <op.vgny39097p4s8u@pikus>
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
	=?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
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
	=?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>,
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

On Fri, Jul 30, 2010 at 06:08:23PM +0200, Michał Nazarewicz wrote:
> On Fri, 30 Jul 2010 17:26:02 +0200, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>> On Fri, Jul 30, 2010 at 05:16:46PM +0200, Michał Nazarewicz wrote:
>>> On Fri, 30 Jul 2010 16:49:14 +0200, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>>
>>>> This is like usb_gadget_register_driver with the only difference that it
>>>> gets the bind function as parameter instead of using driver->bind.  This
>>>> allows fixing section mismatches like
>>>>
>>>> 	WARNING: drivers/usb/gadget/g_printer.o(.data+0xc): Section mismatch in
>>>> 	reference from the variable printer_driver to the function
>>>> 	.init.text:printer_bind()
>>>> 	The variable printer_driver references
>>>> 	the function __init printer_bind()
>>>>
>>>> by using usb_gadget_probe_driver with driver->bind = NULL.  When all
>>>> drivers are fixed to use the new function the bind member of struct
>>>> usb_gadget_driver can go away.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> Cc: Michal Nazarewicz <m.nazarewicz@samsung.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@suse.de>
>
> BTW. Dunno if there is a reason to put me on Cc and Greg will be in
> Signed-off-by anyway.
>
>>>> ---
>>>> Hello,
>>>>
>>>> there is an alternative patch in Greg's tree [1], but IMHO mine is
>>>> better as it doesn't need __ref.
>>>>
>>>> Thoughts?
>>>
>>> Personally I don't see advantage of this over changing the __init to __ref.
>>> Or am I missing something?  I see your patch as an unnecessary API change.
>>> The way I understand it, __ref was introduced exactly for cases like this
>>> one where function is referenced from "normal" data but used only during
>>> init.  Could you try to clarify for me why you think your solution is
>>> better then mine?
>
>> - Using __ref instead of __init moves all bind functions from .init.text
>>   to .text and so the code isn't freed after booting or module loading.
>>   (OK, you could fix this by marking the driver structs as __ref and
>>   keep __init for the bind functions.)
>
> I believe this to be untrue.  __ref puts code in .ref.text which AFAIK is
> freed.
I'm pretty sure it's not freed.  .ref.text is of course correct.

>> - Using __ref might hide section mismatches.  (Your patch hasn't this
>>   problem as the bind functions used to live in .init.text, so any
>>   reference to .init should be OK assuming that it was OK to live in
>>   .init.text in the first place.  But when marking the driver structs
>>   this is an issue.)  That's why I don't like __ref and said my patch
>>   were better as it doesn't make use of it.
>>
>> - The bind functions are only called at init time, so there is no need
>>   to save a pointer to it.
>
> OK, I see some merit in this approach.  However, the same issue is with
> usb_configuration and ?usb_composite_driver -- those should be changed
> in the same way or it would defeat the purpose of the patch.
I didn't skip these on purpose.  I just stumbled over the gadget drivers
first.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
