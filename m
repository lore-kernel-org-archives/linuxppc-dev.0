Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-01.ptn.no (pt20-qms-01.ptn.no [64.28.25.138])
	by ozlabs.org (Postfix) with SMTP id 1BDAD2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 03:22:29 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFF2B075ED.54B62D10-ONC1256F4F.0059DB3D-C1256F4F.0059F240@axxessit.no>
From: morten.banzon@axxessit.no
Date: Wed, 17 Nov 2004 17:22:27 +0100
Content-Type: text/plain; charset="us-ascii"
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

Andy Fleming <afleming@freescale.com>
17.11.2004 16:08

 
        To:     <morten.banzon@axxessit.no>
        cc: 
        Subject:        Re: MPC82xx -- DPRAM1



On Nov 17, 2004, at 06:11, <morten.banzon@axxessit.no> wrote:

>> No I still do not get this.
>>
>> The constant PROFF_SMC1_BASE is as far as I can see never used, only
>> defined. Hence, the cpm or the smc will never be told by the kernel 
>> that
>> there are pointers to the buffer descriptor tables located at 
>> PROFF_SMC1
>> (offset zero) and PROFF_SMC2 (offset 64). Either I am blind or the 
>> kernel
>> performs magic if this happens.

>Look in arch/ppc/boot/simple/m8260_tty.c

>This code, from what I can tell, is called early in boot to set up the 
>boot console.  I haven't read the file very carefully, but I suspect, 
>from what Dan Malek said, that this file sets up the CPM to point the 
>SMCs at that area of dpram.

Thanks for your reply.

I have seen the code you are refering to. After compiling the kernel
the arch/ppc/boot/simple directory contain no object files at all.
Hence, I assumed that none of these files were compiled.
To be asolutely sure I have removed the whole directory, and things
work just fine. Which I take as a proof that nothing in the simple
directory is involved in the configuration of smc1 as a console uart.

I believe that there are only two file involved in configuring the
cpm uart on a mpc82xx platform, namely:
drivers/serial/cpm_uart/cpm_uart_cpm2.c
drivers/serial/cpm_uart/cpm_uart_core.c

None of these files modify the offset addresses 0x87FC (smc1) and
0x88FC(smc2) in the dpram2. Well, at least as far as I can tell.
Hence, I believe the only reason why the cpm_uart driver in the kernel
works, is because the u-boot bootloader does such a fine job.

This might be intentional, I do not know but are seeking
enlightenment.

-- Morten
