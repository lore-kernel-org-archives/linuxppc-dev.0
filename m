Return-Path: <temerkhanov@yandex.ru>
Received: from forward3.mail.yandex.net (forward3.mail.yandex.net [77.88.46.8])
	by ozlabs.org (Postfix) with ESMTP id 2661CB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 04:17:54 +1100 (EST)
Received: from smtp3.mail.yandex.net (smtp3.mail.yandex.net [77.88.46.103])
	by forward3.mail.yandex.net (Yandex) with ESMTP id A1C021190906
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 20:09:42 +0300 (MSK)
Received: from satanklaus.localnet (cifronik.21th.com [62.16.86.116])
	by smtp3.mail.yandex.net (Yandex) with ESMTPSA id 41D7B8B8138
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 20:09:41 +0300 (MSK)
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: DMA to User-Space
Date: Mon, 23 Nov 2009 20:11:09 +0300
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911232011.09654.temerkhanov@yandex.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 04 November 2009 02:37:38 Jonathan Haws wrote:
> All,
> 
> I have what may be an unconventional question:
> 
> Our application consists of data being captured by an FPGA, processed, and
>  transferred to SDRAM.  I simply give the FPGA an address of where I want
>  it stored in SDRAM and it simply DMAs the data over and interrupts me when
>  finished.  I then take that data and store it to disk.
> 
> I have code in user space that handles all of the writing to disk nicely
>  and fast enough for my application (I am capturing data at about 35-40
>  Mbytes/sec).
> 
> My question is this:  is it possible to give a user-space pointer to the
>  FPGA to DMA to?  It seems like I would have problems with alignment,
>  address manipulation, and a whole slew of other issues.

Well, it's possible: you'll have to use zero-copy I/O. Here's an article on 
this subject: http://lwn.net/Articles/28548/.
Have a look at drivers/scsi/st.c at sgl_get_user_pages() or 
drivers/infiniband/hw/ipath/ipath_user_pages.c for example of how to use that.

Regards, Sergey Temerkhanov.
