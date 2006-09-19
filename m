Return-Path: <rimas@cnmat.berkeley.edu>
Received: from cnmat.berkeley.edu (cnmat.CNMAT.Berkeley.EDU [128.32.122.12])
	by ozlabs.org (Postfix) with ESMTP id 7B4D667B53
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 02:47:53 +1000 (EST)
Received: from [128.32.122.171] (account rimas [128.32.122.171] verified)
	by cnmat.berkeley.edu (CommuniGate Pro SMTP 5.0.4)
	with ESMTPA id 2000218 for linuxppc-embedded@ozlabs.org;
	Tue, 19 Sep 2006 09:47:52 -0700
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <450F8062.1000606@dlasys.net>
References: <web-1997652@cnmat.berkeley.edu> <450F8062.1000606@dlasys.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ED70B981-AC4F-4703-9C50-4B36C2FF8045@cnmat.berkeley.edu>
From: rimas <rimas@cnmat.berkeley.edu>
Subject: Re: problems with PLB_TEMAC & xilinx_gige driver under linux 2.4 ...
Date: Tue, 19 Sep 2006 09:48:02 -0700
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


well i'm not sure what the gemac is but the plb_temac and hard_temac  
are the blocks you're supposed to use to utilize the tri-mode MAC  
built into the virtex 4 parts and the xilinx_gige driver is the one  
the EDK tools generate to go with those blocks

in any case i think i've found a way to solve my problem and thought  
i would share it with the list (and perhaps someone who understands  
the issues involved better than i do could shed some light on the  
subject)

its seems that some time between 2.4.20 and 2.4.26 the assembly  
language that is used to implement the inb/inw/inl instructions changed

in 2.4.20 it was lwz; eieio; as seen here (from include/asm-ppc/io.h)

extern inline unsigned in_be32(volatile unsigned *addr)
{
         unsigned ret;

         __asm__ __volatile__("lwz%U1%X1 %0,%1; eieio" : "=r" (ret) :  
"m" (*addr));
         return ret;
}

and in 2.4.26  the sequence is lwz, twi, isync

i changed it back to lwz; eieio; and my problems have gone away (whew!)

does anyone know why that change was made and why it would be causing  
a trap and crashing my ppc ?

thanks

-rimas


On Sep 18, 2006, at 10:30 PM, David H. Lynch Jr. wrote:

>    I do nto know much about Xilinx under 2.4 but I am pretty sure  
> the gemac and the plb temac are similar but different
> NIC's.
>
> rimas wrote:
>> Greetings,
>>
>> i am having problems using the xilinx_gige driver under linux  
>> 2.4.26 running on  a Virtex-4 FX12 Mini Module board (from  
>> avnet).  I am using the plb_temac and hard_temac blocks under ISE/ 
>> EDK 8.1.02.
>>
>> the machine boots fine and the network interface seems to work  
>> okay but it randomly panics sometimes (rather quickly if i'm  
>> generating network traffic):
>>
>> Oops: Exception in kernel mode, sig: 4
>> NIP: C00DA340 XER: 20000000 LR: C00D34F8 SP: C3945B20 REGS:  
>> c3945a70 TRAP: 0700
>>     Not tainted
>> MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>> TASK = c3944000[52] 'telnetd' Last syscall: 4
>> last math 00000000 last altivec 00000000
>> GPR00: 00000004 C3945B20 C3944000 C02E49F4 C02E4800 00000004  
>> 00000001 C0456260
>> GPR08: C0177424 00000031 C50D8000 00021F03 0008C8E4 10122AA8  
>> 00000000 C01A0000
>> GPR16: 00000000 0000001A 00000000 C3945F18 00001032 03945BA0  
>> 00000000 C00038E0
>> GPR24: C0004800 00000020 C04C06E0 C01864E0 C3945BB0 0000001F  
>> 00000000 C02E49F4
>> Call backtrace:
>> C0190000 C00D34F8 C0004748 C000483C C00038E0 C00D398C C00F8094
>> C00EE04C C01039B0 C0104D70 C0115570 C01163A8 C010A600 C012A61C
>> C00E52F4 C00E5574 C003AB2C C000369C 100572BC 10005064 10005108
>> 0FD9221C 00000000
>> Kernel panic: Aiee, killing interrupt handler!
>> In interrupt handler - not syncing
>>   <0>Rebooting in 180 seconds..
>>
>> it always causes a trap on the same instruction (c00da340) which  
>> is inside of
>> XTemac_IntrFifoHandler()
>>
>> c00da330:       81 6a 00 28     lwz     r11,40(r10)
>> c00da334:       0c 0b 00 00     twi     0,r11,0
>> c00da338:       4c 00 01 2c     isync
>> c00da33c:       81 2a 00 20     lwz     r9,32(r10)
>> c00da340:       0c 09 00 00     twi     0,r9,0
>> c00da344:       4c 00 01 2c     isync
>>
>> this code corresponds to two consecutive in_be32() calls
>>
>> extern inline unsigned in_be32(volatile unsigned *addr)
>> {
>> 	unsigned ret;
>>
>> 	__asm__ __volatile__("lwz%U1%X1 %0,%1;\n"
>> 			     "twi 0,%0,0;\n"
>> 			     "isync" : "=r" (ret) : "m" (*addr));
>> 	return ret;
>> }
