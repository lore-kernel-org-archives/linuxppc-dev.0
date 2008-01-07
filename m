Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id EF40DDDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 08:02:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1539869anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Jan 2008 13:02:22 -0800 (PST)
Message-ID: <fa686aa40801071302u78d01f11y5c489553e06c0c01@mail.gmail.com>
Date: Mon, 7 Jan 2008 14:02:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>
Subject: Re: Linux for ml310
In-Reply-To: <520220685@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <520220685@web.de>
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

On 1/7/08, Joachim Meyer <Jogi95@web.de> wrote:
> Hi
>
> I'm trying to run a Linux System on a ml310
> I'm using the Kernel 2.4.26 from Bitkeeper und and EDK9.1 Sp2
> I can compile my Kernel without Errors, with a Crosscompiler made by crosstools, if I don't copy the BSP files in the Kernel Directory.
> If I do so, I can't compile. It aborts with the error:
> serial.c:4040: error: 'XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared (first use in this function)
> If I don't use the UART in my Kernel config I get other errors like:
> adapter.c:96: error: `XPAR_XEMAC_NUM_INSTANCES' undeclared (first use in this function)
> I don't really know what to do now. Where should I look for the solution?

Applying the BSP to the 2.4 kernel is a error prone process.  You need
to be using the *exact* version of the MontaVista kernel that EDK is
expecting, otherwise it breaks and you need to fix it up manually.
2.6 is much better and you don't need to copy over the whole BSP; just
the xparameters.h file.

> Did I something wrong by generating the BSP or do I have to use an older version of the edk/ise?
>
> When I was trying to find a solution I read some of the things in this mailing list, and now I'm concered about these 2 points
> -Board
> -Kernel Version
> Is it a good idea to use the ml310?
> I want a Linux, an ethernet device, a RS232 device and system-ace. Later I would try to patch the Linux with rtai for real-time-support.
> I read about troubles with the ethernet device on the ml310 because of troubles with the pci bus. Would it be much easier to use an XUP-Board?
> Would it be easier to use the kernel 2.6.x? Has anybody experience in running an rtai-patched Linux on an ml310 - bzw XUP Board?

I strongly recommend moving to 2.6.  I don't know if anyone has got
rtai going on it for the virtex, but your chances of getting help are
much higher because virtex 2.6 support is being actively developed.

As for the XUP board, I haven't had a chance to get mine running yet,
but I know others have had good success with it.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
