Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (news.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9325967A86
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 01:02:12 +1100 (EST)
Date: Fri, 28 Jan 2005 15:02:07 +0100
From: Olaf Hering <olh@suse.de>
To: dtor_core@ameritech.net
Message-ID: <20050128140207.GB28784@suse.de>
References: <20050128132202.GA27323@suse.de>
	<d120d500050128055837df3a93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d120d500050128055837df3a93@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Jan 28, Dmitry Torokhov wrote:

> It looks like it is hanging in checking AUX, while writing data into
> controller. It is simple outb but it is stuck... Could you please
> reboot with i8042.debug boot option and resend the log. Also, you may
> try booting with i8042.noaux to check if keyboard alone works.

It looks like this:
Kernel command line: root=/dev/sda3 selinux=0 elevator=cfq debug initcall_debug panic=1 i8042.nomux=1 console=ttyS0 i8042.debug i8042.noaux
...
Calling initcall 0xc03a3a14: atkbd_init+0x0/0x38()
ps2_init(224) swapper(1):c0,j4294681251 enter
atkbd_connect(793) swapper(1):c0,j4294681305 type 6000000
serio_open(606) swapper(1):c0,j4294681372 enter
serio_set_drv(594) swapper(1):c0,j4294681428 enter
serio_set_drv(600) swapper(1):c0,j4294681488 leave
/home/olaf/kernel/b50/linux-2.6.11-rc2-olh/drivers/input/serio/i8042.c: 60 -> i8042 (command) [3767]
i8042_write_command(69) swapper(1):c0,j4294681548 enter
/home/olaf/kernel/b50/linux-2.6.11-rc2-olh/drivers/input/serio/i8042.c: 61 -> i8042 (parameter) [3767]
i8042_write_data(62) swapper(1):c0,j4294681548 enter
serio_open(614) swapper(1):c0,j4294681911 leave0
atkbd_probe(497) swapper(1):c0,j4294681968 enter
ps2_command(91) swapper(1):c0,j4294682026 enter
ps2_sendbyte(57) swapper(1):c0,j4294682082 enter
serio_write(95) swapper(1):c0,j4294682139 write c01b9d48
/home/olaf/kernel/b50/linux-2.6.11-rc2-olh/drivers/input/serio/i8042.c: ff -> i8042 (kbd-data) [4424]
i8042_write_data(62) swapper(1):c0,j4294682205 enter
