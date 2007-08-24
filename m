Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id E798FDDED8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 04:21:09 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so578196nzf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 11:21:08 -0700 (PDT)
Message-ID: <fa686aa40708241121s359fbaf2r7adb8886a2d3ff65@mail.gmail.com>
Date: Fri, 24 Aug 2007 12:21:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: woyuzhilei <woyuzhilei@163.com>
Subject: Re: Problems on porting linux 2.6 to xilinx ML410
In-Reply-To: <200708241111513591137@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200708241111513591137@163.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/23/07, woyuzhilei <woyuzhilei@163.com> wrote:
>
>
> Hey:
>     Recently I'm doing some project on Xilinx Ml410 evaluation board.The
> first step is porting linux 2.6 to ml410,but I got some problems on this,and
> my project cann't proceed,so I come to you for some help.
>     I use the linux kernel source tree download from
> http://git.secretlab.ca/git/linux-2.6-virtex.git  (The
> latest one).Add the file the xparameters.h,xparameter_ml40x.h.  Then add
> arch/ppc/platforms/4xx/xilinx_generic_ppc.c(Use the patch I
> get here),and change it's name to ml40x.c,then I make some necessay change
> of the configuration files to accept selecting a Ml40x type board.

You shouldn't need to do all of this; only the xparameters_ml40x.h
file is needed.  To get started, I'd just use replace
xparameters_ml403.h with your custom xparameters_ml40x.h and use the
ml403 board port.  Once you've got it booting, you can get more fancy.

> Then
> compile the kernel,and get the image file from arch/ppc/boot/images, (On
> kernel compiling,the only device driver  I sellect is " 8250/16550 and
> compatible serial support ").After that  I download the zImage.elf file to
> the target board,and run it.But there is no output from the serial port at
> all.Am I doing somthing wrong?I really don't know goes wrong.
>     Can anyone here help me with this?Any help from you is appreciated.Thank
> you very much!

Make sure you've got 16550 console support enabled and
'console=/dev/ttyS0' in your kernel command line.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
