Return-Path: <dmitry.torokhov@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.203])
	by ozlabs.org (Postfix) with ESMTP id 33A2667A89
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 01:04:52 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id a41so805300rng
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 06:04:50 -0800 (PST)
Message-ID: <d120d500050128055837df3a93@mail.gmail.com>
Date: Fri, 28 Jan 2005 08:58:10 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050128132202.GA27323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050128132202.GA27323@suse.de>
Cc: linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Jan 2005 14:22:02 +0100, Olaf Hering <olh@suse.de> wrote:
> 
> My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> 
> Calling initcall 0xc03c272c: atkbd_init+0x0/0x38()
> ps2_init(224) swapper(1):c0,j4294680939 enter
> atkbd_connect(793) swapper(1):c0,j4294680993 type 1000000
> serio_open(606) swapper(1):c0,j4294681061 enter
> serio_set_drv(594) swapper(1):c0,j4294681117 enter
> serio_set_drv(600) swapper(1):c0,j4294681176 leave
> i8042_write_command(69) swapper(1):c0,j4294681236 enter
> i8042_write_data(62) swapper(1):c0,j4294681236 enter
> serio_open(614) swapper(1):c0,j4294681363 leave0
> atkbd_probe(497) swapper(1):c0,j4294681421 enter
> ps2_command(91) swapper(1):c0,j4294681478 enter
> ps2_sendbyte(57) swapper(1):c0,j4294681534 enter
> serio_write(95) swapper(1):c0,j4294681591 write c01b65ac
> i8042_aux_write(253) swapper(1):c0,j4294681658 enter
> i8042_write_command(69) swapper(1):c0,j4294681720 enter
> i8042_write_data(62) swapper(1):c0,j4294681720 enter
> 
> Any idea how to fix it? There is no keyboard or mouse detected. I think
> it works ok on ppc64, Anton did not complain yet.
> 

Hi,

It looks like it is hanging in checking AUX, while writing data into
controller. It is simple outb but it is stuck... Could you please
reboot with i8042.debug boot option and resend the log. Also, you may
try booting with i8042.noaux to check if keyboard alone works.

-- 
Dmitry
