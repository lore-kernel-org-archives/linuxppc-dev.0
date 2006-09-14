Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 09C2067B56
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 11:52:18 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so19827ugc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 18:52:14 -0700 (PDT)
Message-ID: <528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
Date: Wed, 13 Sep 2006 19:52:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Aleck Lin" <aleck@gdatech.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <002501c6d79e$cca7ee40$800101df@monstertop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/13/06, Aleck Lin <aleck@gdatech.com> wrote:
> Hi,
>
> I'm able to boot Linux 2.6 on ML403 board (with a ramdisk file system).
>
> However, during the kernel booting, it complains that "No network devices
> available," So I figured I probably didn't enable the ethernet driver in the
> kernel.
>
> >From doing "make menuconfig", under "Device Drivers" --> "Network device
> support" --> "Ethernet(10 or 100Mbit)", I checked the box of both "Ethernet
> (10 or 100Mbit)" and "PowerPC 4xx on-chip Ethernet support." I then
> save/exit the menuconfig to compile the kernel again. I've attached the
> error output at the bottom.

The virtex eth device is not the same as 4xx on-chip Ethernet, so
CONFIG_IBM_EMAC will not work.  You need the xilinx_enet driver (which
is not in mainline).  It might be in MontaVista's 2.6 tree.

I think people have posted patches for it to this list, so try
searching the archives.  (I don't have a link off the top of my head.)

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
