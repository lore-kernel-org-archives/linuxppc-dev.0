Return-Path: <m.nazarewicz@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
	[210.118.77.12]) by ozlabs.org (Postfix) with ESMTP id 86E3B1007D1
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 19:38:18 +1000 (EST)
Received: from eu_spt2 (mailout2.w1.samsung.com [210.118.77.12])
	by mailout2.w1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L6I00H0IQRMJ3@mailout2.w1.samsung.com> for
	linuxppc-dev@ozlabs.org; Mon, 02 Aug 2010 10:38:10 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
	by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul
	14 2004)) with ESMTPA id <0L6I001PIQRJGK@spt2.w1.samsung.com> for
	linuxppc-dev@ozlabs.org; Mon, 02 Aug 2010 10:38:09 +0100 (BST)
Date: Mon, 02 Aug 2010 11:39:39 +0200
From: =?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?= <m.nazarewicz@samsung.com>
Subject: Re: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-reply-to: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-usb@vger.kernel.org,
	=?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-id: <op.vgs04dub7p4s8u@pikus>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8; format=flowed; delsp=yes
References: <1280501361-13410-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: Cliff Cai <cliff.cai@analog.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Dan Carpenter <error27@gmail.com>, Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Julia Lawall <julia@diku.dk>, Philipp Zabel <philipp.zabel@gmail.com>,
	Felipe Balbi <felipe.balbi@nokia.com>,
	Andrea Gelmini <andrea.gelmini@gelma.net>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Fabien Chouteau <fabien.chouteau@barco.com>,
	Dinh Nguyen <Dinh.Nguyen@freescale.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Vladimir Zapolskiy <vzapolskiy@gmail.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vincent Sanders <support@simtec.co.uk>, Marc Singer <elf@buici.com>,
	=?utf-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Tobias Klauser <tklauser@distanz.ch>, Anatolij Gustschin <agust@denx.de>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>,
	Eirik Aanonsen <eaa@wprmedical.com>, Mike Frysinger <vapier@gentoo.org>,
	Thomas Dahlmann <dahlmann.thomas@arcor.de>,
	linux-geode@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	Magnus Damm <damm@igel.co.jp>, Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org,
	Eric Miao <eric.y.miao@gmail.com>,
	=?utf-8?Q?N=C3=A9meth_M=C3=A1rton?= <nm127@freemail.hu>,
	Jiri Kosina <jkosina@suse.cz>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Harro Haan <hrhaan@gmail.com>,
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

On Fri, 30 Jul 2010 16:49:14 +0200, Uwe Kleine-K=C3=B6nig <u.kleine-koen=
ig@pengutronix.de> wrote:
> by using usb_gadget_probe_driver with driver->bind =3D NULL.  When all=

> drivers are fixed to use the new function the bind member of struct
> usb_gadget_driver can go away.

On second thought, would it be hard to just fix all the gadgets?  It's n=
ot like there
are thousands of them so it shouldn't take that long.  Moreover, since y=
ou'd remove
the bind field and change the prototype of the usb_gadget_register() all=
 instances
would be found at compile time.

With that and the other functions which use bind callbacks (usb_add_conf=
iguration(),
usb_composite_register()) the patch would be much better in my opinion a=
nd also
much better then my approach with __ref.

-- =

Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=3D./ `o
| Computer Science,  Micha=C5=82 "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
