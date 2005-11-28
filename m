Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 0843E68833
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 00:10:01 +1100 (EST)
Message-ID: <438B01A7.5020509@ru.mvista.com>
Date: Mon, 28 Nov 2005 16:09:59 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: ihornberger@sysgo.com
References: <02AA386EB831044F8537A696BA785C7807645A@ILEX5.IL.NDS.COM>
	<1133175485.30984.1.camel@iho.sysgo.com>
In-Reply-To: <1133175485.30984.1.camel@iho.sysgo.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.14 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ingo Hornberger wrote:
> Hi Bracha,
> 
> I assume that you're using an 8xx!?
> 
> This code isn't completely updated yet, but here is a small patch which
> should be more or less working...
> 
There is a patch, that did what you are attempting to do below correct way.
mfspr(SPRN_IMMR) does not correctly identify the board, you need to define BOARD_CHIP_NAME 
somewhere in board-specific code to get it defined. The <>_device.c and <>_sys.c pair is 
in the linus git tree currently, and error message below will not appear even if 
BOARD_CHIP_NAME is undefined.

You might want to try more recent kernel.
> regards,
> 	Ingo
> 
> On Sun, 2005-11-27 at 12:22 +0200, Landau, Bracha wrote:
>> I'm trying to move to the latest kernel release from linux 2.6.13.4 on the MPC8272ADS board.
>> 2.6.13.4 works, but from 2.6.14 and up (I don't know where from 2.6.13.4 to 2.6.14 the problem starts) the kernel crashes on bootup with the message 
>> "Kernel BUG in ppc_sys_init at arch/ppc/syslib/ppc_sys_init.c:131"
>> Anyone know how to fix this problem?
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>> ------------------------------------------------------------------------
>>
>> diff -Nurb a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
>> --- a/arch/ppc/syslib/m8xx_setup.c   2005-10-28 02:02:08.000000000 +0200
>> +++ b/arch/ppc/syslib/m8xx_setup.c  2005-11-25 11:11:03.000000000 +0100
>> @@ -82,7 +82,7 @@
>>         ROOT_DEV = Root_HDA1; /* hda1 */
>>  #endif
>>  
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> +#if defined(CONFIG_BLK_DEV_INITRD) || defined(CONFIG_EXTRACT_ROOTFS)
>>  #if 0
>>         ROOT_DEV = Root_FD0; /* floppy */
>>         rd_prompt = 1;
>> @@ -389,7 +389,7 @@
>>         m8xx_setup_pci_ptrs();
>>  #endif
>>  
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> +#if defined(CONFIG_BLK_DEV_INITRD) || defined(CONFIG_EXTRACT_ROOTFS)
>>         /* take care of initrd if we have one */
>>         if ( r4 )
>>         {
>> @@ -404,6 +404,15 @@
>>                 strcpy(cmd_line, (char *)(r6+KERNELBASE));
>>         }
>>  
>> +       /* 
>> +        * Check if we are really on a Power QUICC CPU.
>> +        * Note, that we do not halt the Kernel at this point, 
>> +        * because we won't get any output here otherwise.
>> +        */
>> +       if( (mfspr(SPRN_PVR) >> 16) != 0x0050 )
>> +         printk( KERN_ERR "ERROR: %s: %d: Wrong CPU Type! (We assumed a Power QUICC CPU)\n" );
>> +       identify_ppc_sys_by_id(mfspr(SPRN_IMMR));
>> +
>>         ppc_md.setup_arch               = m8xx_setup_arch;
>>         ppc_md.show_percpuinfo          = m8xx_show_percpuinfo;
>>         ppc_md.irq_canonicalize = NULL;
>> diff -Nurb a/arch/ppc/syslib/mpc8xx_sys.c b/arch/ppc/syslib/mpc8xx_sys.c
>> --- a/arch/ppc/syslib/mpc8xx_sys.c   2005-10-28 02:02:08.000000000 +0200
>> +++ b/arch/ppc/syslib/mpc8xx_sys.c  2005-11-25 11:11:03.000000000 +0100
>> @@ -20,9 +20,16 @@
>>  
>>  struct ppc_sys_spec *cur_ppc_sys_spec; 
>>  struct ppc_sys_spec ppc_sys_specs[] = {
>> +  /* The mpc85x and 86x, all have the system ID 0x00.
>> +   * And as it seems that even the 885 has the ID 0x00,
>> +   * I assume 0x00 for all MPC8XX systems. 
>> +   * For other cases, you should add a new entry above the
>> +   * MPC8XX. You could use the first 8 bits to make
>> +   * a more specific match for your system.
>> +   */
>>         {
>> -               .ppc_sys_name   = "MPC86X",
>> -               .mask           = 0xFFFFFFFF,
>> +               .ppc_sys_name   = "MPC8XX",
>> +               .mask           = 0x00FF0000,
>>                 .value          = 0x00000000,
>>                 .num_devices    = 2,
>>                 .device_list    = (enum ppc_sys_devices[])
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Sincerely,
Vitaly
