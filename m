Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-01.ptn.no (pt20-qms-01.ptn.no [64.28.25.138])
	by ozlabs.org (Postfix) with SMTP id 85CB32BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 21:50:25 +1100 (EST)
To: "Mark Chambers" <markc@mail.com>
MIME-Version: 1.0
Message-ID: <OFD0B78DE0.9222EE0F-ONC1256F50.003811B2-C1256F50.003B80FF@axxessit.no>
From: morten.banzon@axxessit.no
Date: Thu, 18 Nov 2004 11:49:59 +0100
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks again for your reply to my queries.

I did not know that arch/ppc/boot stuff and u-boot were mutually 
exclusive. Thanks for clarifying that.
In fact I have not been considering what is left out when you make a 
uImage as opposed to zImage, obviously I have som styding to do here.

I do not understand all the intricacies of what happens regarding hardware 
configuration during the eraly stages of booting linux, but I conclude 
that when making a uImage one have to modify u-boot and the kernel if one 
want to relocate the usage of dpram1 by the cpm uart driver. This might 
have been obvious to most of you, but I was lost on this issue.

A mystery is why Dan Malek said it was a "very bad idea" to relocate the 
smc buffer descriptors to anohter part of dpram1.
Maybe I will understand that one day too.

Thanks again for your help Mark.

-- Morten






"Mark Chambers" <markc@mail.com>
17.11.2004 17:37

 
        To:     <morten.banzon@axxessit.no>
        cc: 
        Subject:        Re: MPC82xx -- DPRAM1


Well, but the arch/ppc/boot stuff and u-boot are mutually exclusive, 
right?
The arch/ppc/boot takes the kernel binary and wraps it in a very simple
bootloader.  So it depends on your make options whether that code gets
compiled or not.  So I think you've solved the mystery, that indeed the
bootloader sets up the SMCs to use that dpram memory.  I guess the
philosophical question is, should it be left that way or not.

Mark Chambers

>
> >> No I still do not get this.
> >>
> >> The constant PROFF_SMC1_BASE is as far as I can see never used, only
> >> defined. Hence, the cpm or the smc will never be told by the kernel
> >> that
> >> there are pointers to the buffer descriptor tables located at
> >> PROFF_SMC1
> >> (offset zero) and PROFF_SMC2 (offset 64). Either I am blind or the
> >> kernel
> >> performs magic if this happens.
>
> >Look in arch/ppc/boot/simple/m8260_tty.c
>
> >This code, from what I can tell, is called early in boot to set up the
> >boot console.  I haven't read the file very carefully, but I suspect,
> >from what Dan Malek said, that this file sets up the CPM to point the
> >SMCs at that area of dpram.
>
> Thanks for your reply.
>
> I have seen the code you are refering to. After compiling the kernel
> the arch/ppc/boot/simple directory contain no object files at all.
> Hence, I assumed that none of these files were compiled.
> To be asolutely sure I have removed the whole directory, and things
> work just fine. Which I take as a proof that nothing in the simple
> directory is involved in the configuration of smc1 as a console uart.
>
> I believe that there are only two file involved in configuring the
> cpm uart on a mpc82xx platform, namely:
> drivers/serial/cpm_uart/cpm_uart_cpm2.c
> drivers/serial/cpm_uart/cpm_uart_core.c
>
> None of these files modify the offset addresses 0x87FC (smc1) and
> 0x88FC(smc2) in the dpram2. Well, at least as far as I can tell.
> Hence, I believe the only reason why the cpm_uart driver in the kernel
> works, is because the u-boot bootloader does such a fine job.
>
> This might be intentional, I do not know but are seeking
> enlightenment.
>
> -- Morten
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
