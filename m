Return-Path: <jwboyer@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 6E1D3B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 03:35:11 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 28so1231492wff.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 10:35:08 -0700 (PDT)
Date: Wed, 19 Aug 2009 13:35:05 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: Sumesh Kaana <sumeshkkn@hotmail.com>
Subject: Re: Linux booting problem on powerpc 440
Message-ID: <20090819173505.GM3095@hansolo.jdub.homelinux.org>
References: <BLU124-W26979C48CA968E784AEA0CB4FE0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLU124-W26979C48CA968E784AEA0CB4FE0@phx.gbl>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 19, 2009 at 01:01:16PM +0000, Sumesh Kaana wrote:
>
>
>
>Hi all,
>I am trying to boot linux kernel (2.6.30) on a custom built board.I am using simple ppc platform and attached are my dts file and boot log..
>I've 16Mb of RAM,UART and UIC with powerpc 440x5 processor.Kernel Image size is less than 1 mb.
>i am not using any bootloaders such as U-boot
>i have a small program on reset vector which will copy linux bin image from flash to 4mb (Link Address as per wrapper script), after that execution starts from link address.

How large of an initial TLB are you setting up for all of this in your simple
bootloader?

>the problem that i face is kernel crashes in different places while booting for different linux images, but always mentioned that 
>TASK = 'swapper'
>
>Can anyone tell what would be the problem..?

I won't quote the file itself since your email is terribly word-wrapped, but
the #address-cells = <1> in the root node looks incorrect for a 440 based CPU.
It should be 2, as 440 does 36-bit addressing.  Similarly for the PLB node.
You would need to fix the memory reg property for this.

The CPU node should probably have #size-cells = <0>, though I don't think that
matters much.

The serial port appears to be at an odd address for a 440 based SoC, but I
have no idea if that is correct or not.

Outside of those issues, I can't think of anything off the top of my head that
would cause the panic you are seeing.

josh
