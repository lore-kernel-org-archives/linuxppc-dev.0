Message-ID: <408CC769.2050107@intracom.gr>
Date: Mon, 26 Apr 2004 11:25:13 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marius Groeger <mgroeger@sysgo.com>
Cc: jeffy <leo_guo@jisung.cn>,
	"linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PPC Linux painic problem!
References: <200404260127.UAA32565@lists.linuxppc.org> <Pine.LNX.4.56.0404260913440.2550@mag.sysgo.com>
In-Reply-To: <Pine.LNX.4.56.0404260913440.2550@mag.sysgo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marius Groeger wrote:

>Jeffy,
>
>On Mon, 26 Apr 2004, jeffy wrote:
>
>
>>Hi all,
>>	I hit on a problem about PPC Linux version 2.4.4 on a MPC855T board.
>>    The kernel can start up ok normally, but when another PC
>>continous sending UDP packets to it(about 8Mbps) when kernel is
>>starting up, the kernel failed start up and printf the following
>>messages:
>>
>
>This is just a VERY wild guess: check the driver source
>(arch/ppc/8xx_io/fec.c in your case) and make sure the driver only forwards
>received packets to the IP stack when the interface is configured "UP".
>There once was a similar problem with the 826x driver.
>
>Another reason could be that the FEC channel is not properly shut down by
>the firmware/bootloader before entering the kernel.
>
>Next time try to add more information about your system, especially about
>the kernel and bootloader version you are using.
>
>Regards,
>Marius
>
>--
>Marius Groeger <mgroeger@sysgo.com>           Project Manager
>SYSGO AG                      Embedded and Real-Time Software
>Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
>www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
>
>
>
>
>
>
If you use u-boot make sure you update to the latest version.

There was a bug with the fec not properly halting and then
crashing the kernel when network traffic was present very early.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
