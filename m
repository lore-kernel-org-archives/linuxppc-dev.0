Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-02.ptn.no (pt20-qms-02.ptn.no [64.28.25.139])
	by ozlabs.org (Postfix) with SMTP id 8AD402BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 07:08:46 +1100 (EST)
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Message-ID: <OF39E98ED9.64FBC87A-ONC1256F50.006BC66A-C1256F50.006EA31B@axxessit.no>
From: morten.banzon@axxessit.no
Date: Thu, 18 Nov 2004 21:08:26 +0100
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

By modifying the kernel I meant modifying the cpm uart driver. If that was 
not clear I appologise.
I do not how much of this thread you have been reading, but if you know of 
a way to relocate the resources in the dpram1 used by the cpm uart (smc1 
in this case) other than what is suggested in the previous mail I am eager 
to hear from you.

 Since the contents of the arch/ppc/boot are not compiled, and certainly 
not the arch/ppc/boot/simple/m8260_tty.c, then there is absolutely no code 
in cpm_uart_core.c or cpm_uart_cpm2.c that configure the SMC1_BASE 
register, or the SMC2_BASE register for that matter,  found at offset 
0x87FC and 0x88FC respectively. Hence, there is no way for the cpm/smc 
hardware to know were to look for the buffer descriptor tables, hence 
there is no wayt to get a working console on the smc1 unless the 
bootloader configure this identical to what the cpm uart driver within the 
kernel expect. I think I have proven that too by first changing the 
necessary constants in arch/asm-ppc/cpm2.h, which causes the console to 
die as soon as the linux kernel take over control after the bootloader. 
Modifying the u-boot to reflect the modifications done in cpm2.h make the 
whole thing work nicely again.

I agree with you that each driver is supposed to perform all required 
initialization steps itself, but that is not the case for the cpm_uart smc 
driver. This driver consists as far as I can see of two files; 
cpm_uart_cpm2.c and cpm_uart_core.c, and the header files. I might be 
wrong ofcourse claiming that this driver is not able to get off the ground 
without help from a bootloader, and any such explaninations are most 
welcome. I sincerely want to understand this.

Your "Read the code" commet is the best answer to these queries I have 
seen so far. I guess you and Dan Malek understand something that is not 
possible to read from the code. Well, I have relocated both the first 128 
bytes of the dpram1 and the buffer descriptors for the smc1 driver. 
Similar thing is done wiht the i2c driver and so far, just for a few hours 
though, they are working happily.

If you know the reason to why it is "a very bad idea" to relocate these 
resources within dpram1 I am very curious to learn. On the other hand if 
you do not know, then please refrain from giving such a stupid answer.

-- Morten






Wolfgang Denk <wd@denx.de>
Sent by: wd@denx.de
18.11.2004 18:38

 
        To:     morten.banzon@axxessit.no
        cc:     linuxppc-embedded@ozlabs.org
        Subject:        Re: MPC82xx -- DPRAM1


In message 
<OFD0B78DE0.9222EE0F-ONC1256F50.003811B2-C1256F50.003B80FF@axxessit.no> 
you wrote:
> 
> I do not understand all the intricacies of what happens regarding 
hardware 
> configuration during the eraly stages of booting linux, but I conclude 
> that when making a uImage one have to modify u-boot and the kernel if 
one 
> want to relocate the usage of dpram1 by the cpm uart driver. This might 
> have been obvious to most of you, but I was lost on this issue.

There is no need to modify U-Boot nor  the  kernel.  Each  driver  is
supposed to perform all required initialization steps itself. It must
not  make  any assumptions about it's previous state except that it's
"harmless", i. e. interrupts are disabled etc.  when  the  driver  is
starting.

> A mystery is why Dan Malek said it was a "very bad idea" to relocate the 

> smc buffer descriptors to anohter part of dpram1.
> Maybe I will understand that one day too.

Read the code.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Vulcans believe peace should not depend on force.
                 -- Amanda, "Journey to Babel", stardate 3842.3
