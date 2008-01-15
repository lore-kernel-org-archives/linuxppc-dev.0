Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id F1353DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 14:22:19 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1323120anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Jan 2008 19:22:18 -0800 (PST)
Message-ID: <fa686aa40801141922m5da5682dm7173356e60548638@mail.gmail.com>
Date: Mon, 14 Jan 2008 20:22:17 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Yedu Jathavedan" <yeduj@ece.pdx.edu>
Subject: Re: Using USB on ML403
In-Reply-To: <20080114183942.un31p1u02s4s8www@webmail.cecs.pdx.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080114183942.un31p1u02s4s8www@webmail.cecs.pdx.edu>
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

On 1/14/08, Yedu Jathavedan <yeduj@ece.pdx.edu> wrote:
> Hi,
>
> I am a beginner to FPGA programming. I want to use the USB Host on
> ML403 in a PowerPC processor reference system to store some data on a
> Thumb Drive.
>
> Currently, I've configured the BSP(OS support) as standalone. There is
> the OPB USB2 IP core with drivers which I want to use. But, not sure

The opb_usb2_device ip core is a USB device, not a host.  It will not
work for reading a thumb drive.

You want to configure your BSP as linux_v2_6 so you can get a
xparameter_ml40x.h file which will work with linux.

> which port connections to use & if that will configure the Cypress
> CY7C67300 USB controller. The Application Note Xapp925 for ML403 uses
> OPB EPC core to configure the Cypress controller. If that is the case,
> is there any driver for the cypress controller?

opb_epc is the right thing to use to get the cypress c67300 working.
I've got a driver for the c67x00 in my git tree:

http://git.secretlab.ca/git/linux-2.6-virtex.git  in the virtex-c67x00 branch.

Go here for my notes on Linux on the Virtex:

http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

>
> If I use Linux kernel 2.6, how would it help me? Are there any drivers
> for the USB that I can use for kernel 2.6? If anyone has worked on
> this problem before, I would greatly appreciate their help.

All my work is targeted for 2.6.  It will be difficult to get support
if you use 2.4

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
