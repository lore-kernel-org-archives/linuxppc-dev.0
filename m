Message-ID: <3925EBA0.ABFE1267@embeddededge.com>
Date: Fri, 19 May 2000 21:34:24 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 Linux memory mapping rules
References: <m12sxXK-001SyZC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

>         - The compressed Linux kernel (zImage) contains a bootstrap loader
>           that is position independent; you can load it into any RAM,
>           ROM or FLASH memory address >= 0x00200000 (above 2 MB).
>
>           Note: If zImage is loaded at its link address of 0x00400000 (4 MB),
>                 then zImage will skip the step of moving itself to
>                 its link address.

The zImage should be loaded above the link address by at least the
amount of memory required by the uncompress/setup functions.  If you
load it below the address, it could potentially relocate itself on
top of the kernel or ram disk image.  For example, the uncompress/setup
functions are linked to run at 0x00400000, based upon the current size
of the functions, you need to load above 0x00407000.  I would pick
0x00480000 or higher, just to not worry about it.


>           and I/O devices above phsical address 0x80000000.  The lowest

You could fix this typo....it should be 'physical'.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
