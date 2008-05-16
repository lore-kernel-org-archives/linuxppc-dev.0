Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 8C9DBDE168
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 00:26:50 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so269027anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 07:26:48 -0700 (PDT)
Message-ID: <fa686aa40805160726i59c3d88l99c12a130eb073e2@mail.gmail.com>
Date: Fri, 16 May 2008 08:26:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: mojtaba <kernelppc@gmail.com>
Subject: Re: Booting Linux from an ACE File
In-Reply-To: <007a01c8b74c$0ad9c2e0$208d48a0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <007a01c8b74c$0ad9c2e0$208d48a0$@com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 5:57 AM, mojtaba <kernelppc@gmail.com> wrote:
> Dear all,
>
> Could you please explain what happens exactly when Linux is booting from a
> compact flash?
>
> To my few knowledge, the Linux compressed image will be copied somewhere in
> memory, will be uncompressed and the control will jump to the beginning
> address of the Linux kernel.

There are several methods to do this.

Option 1 is to pass the kernel zImage.elf to genace so that it gets
wrapped up into the ace file itself and is loaded into RAM by the
SystemACE on FPGA initialization.  However, this requires that your
FPGA design gets RAM initialized before the SysACE starts squirting in
the Linux image (which isn't always the case).  This option is also
slow.

Option 2 is to use an small bootloader blob (I think Xilinx has a
technote with something suitable) loaded into BRAM that reads the CF
card and copies a Linux image (hint; build a simpleImage when using
arch/powerpc) off the CF and into RAM.  This method boots the system
faster, but requires a little bit more work.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
