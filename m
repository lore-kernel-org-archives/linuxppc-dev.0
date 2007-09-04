Return-Path: <list.mail.for.bill@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 37DEBDDE16
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 14:07:19 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id h3so1429031nfh
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 03 Sep 2007 21:07:16 -0700 (PDT)
Message-ID: <7c1681440709032107u3feb0684x34dcf44b5e43616@mail.gmail.com>
Date: Tue, 4 Sep 2007 14:07:10 +1000
From: "Bill F" <list.mail.for.bill@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Breakpoint is not hitting for Kernel Debugging
In-Reply-To: <F3D55679E1DCFF49A57570501B70475F070D83BC@CL5EXBE04.ad2.softcom.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <F3D55679E1DCFF49A57570501B70475F070D83BC@CL5EXBE04.ad2.softcom.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/4/07, dnl <ssaravanan@mail2web.com> wrote:
>  I enabled the following options in Kernel for kernel Debugging,
> CONFIG_BDI_SWITCH=y CONFIG_DEBUG_INFO=y under kernel hacking and MMU XALT in
> BDI config file. After uboot initialization I fixed break point at
> start_kernel(0xc02784bc), and then I booted the kernel. Without breaking  at
> start_kernel, it came to login prompt. Please find attached config file with
> this mail. Could anybody help me to solve this problem?

Hi Saravanan,
Try adding this line to your BDI config to clear/invalidate the page
table base address so that the MMU translation works before the MMU
has been initialised.

  ;; Following is to clear the page table base address
  WM32    0x000000f0      0x00000000

Make sure that you reload the BDI config, I use the  the BDI "BOOT"
command to do this.

Are you obtaining the start_kernel address from your kernel System.map
file and setting the breakpoint using the BDI command "BI 0xc02784bc"
or are you using a gdb debugger frontend ?

Bill
