Return-Path: <wilbur512@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 28624B6F11
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jun 2010 03:27:32 +1000 (EST)
Received: by vws16 with SMTP id 16so468586vws.15
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Jun 2010 10:27:30 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 21 Jun 2010 01:27:30 +0800
Message-ID: <AANLkTil2XkHxcryRNcnUDgYv5iZJD76GCUcvHOYe9l9O@mail.gmail.com>
Subject: where do 8250 serial port initialize its mapbase and membase when
	booting?
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: chelly wilbur <wilbur512@gmail.com>, "chen.yu10" <chen.yu10@zte.com.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

linux 2.6.21.7

where do serial 8250 port fill its membase and mapbase  fileds  in
system initializing ?



I found that , when calling do_initcalls--->  serial8250_init ---->
platform_driver_register--->bus_for_each_dev,  system found

an device of serial 8250, which has already fill the membase and mapbase fileds.

That is to say,  before serial8250_init ---->
platform_driver_register, system has create a serial device with
membase and mapbase initialized.

 do_initcalls--->  serial8250_init ----> platform_driver_register--->
dev = bus_for_each_dev


             --->  struct plat_serial8250_port *p = dev->platform_data;

                    /*  at this point , p->membase and p->mapbase are
all assigned with proper value by system */




I searched the whole source code with keyword 'membase' , and found
the following code :


serial8250_request_std_resource:

case UPIO_MEM:
	if (!up->port.mapbase)
		break;

	if (!request_mem_region(up->port.mapbase, size, "serial")) {
		ret = -EBUSY;
		break;
	}
  /*I guess membase is generated according to mapbase ,*
    so I add some debug print  here.
    However, I found membase and mapbase are already initialized
before these codes. */


                if (up->port.flags & UPF_IOREMAP) {
	                 up->port.membase = ioremap(up->port.mapbase, size);
	                 if (!up->port.membase) {
		          release_mem_region(up->port.mapbase, size);
		          ret = -ENOMEM;
	                 }
                 }


So I am really confused with serial 8250
initializing----------------where do kernel apply membase and mapbase
filed to  8250 port?

Thx
