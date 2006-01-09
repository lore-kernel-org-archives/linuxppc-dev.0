Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 1D38E68789
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 05:09:35 +1100 (EST)
Message-ID: <43C2A6DD.5020202@ru.mvista.com>
Date: Mon, 09 Jan 2006 21:09:33 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Lo Chun Chung <lcsquare2@yahoo.com.hk>
References: <20060109164942.62300.qmail@web53713.mail.yahoo.com>
In-Reply-To: <20060109164942.62300.qmail@web53713.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Enable a PCMCIA Bluetooth card in custom MPC860 system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Lo Chun Chung wrote:
> Dear all,
>  
> I am a student from Hong Kong. Now I am doing a project about enabling a 
> Bluetooth PCMCIA card (Billionton PCBTC1A-B) in a custom MPC860PC.
>  
> (The custom MPC860 system is constructed by a MPC860 Processor Card and 
> a custom made PCB to adding a PCMCIA interface to the processor Card.)
>  
> Now my stage is: the LINUX (Linux Kernel 2.4.25 from ELDK 3.1 for 
> powerpc) can recognise the card by cardctl, and here are the screen dump:
>  
> / # cardctl ident
> Socket 0:
>   product info: "PCMCIA", "Bluetooth Card", "", ""
>   manfid: 0x0279, 0x950b
>   function: 2 (serial)
> / # cardctl status
> Socket 0:
>   5V 16-bit PC Card
>   function 0: [ready], [bat dead], [bat low]
> / # cardctl info
> PRODID_1="PCMCIA"
> PRODID_2="Bluetooth Card"
> PRODID_3=""
> PRODID_4=""
> MANFID=0279,950b
> FUNCID=2
> / # cardct! l config
> Socket 0:
>   Vcc 5.0V  Vpp1 5.0V  Vpp2 5.0V
>  
> but after I load all the modules needed (should be these?)
>  
> / # lsmod
> Module                  Size  Used by    Not tainted
> hci_uart               14836   0 (unused)
> l2cap                  22956   0 (unused)
> bluez                  43856   0 [hci_uart l2cap]
> ds                      8060   0
> m8xx_pcmcia             5164   1
> pcmcia_core            39520   0 [ds m8xx_pcmcia]
>  
> my bluetooth still cannot get working ...
>  
> then I try to insert "serial_cs" as my bluetooth card is a uart base 
> card. but some message given out:
>  
> / # insmod serial_cs
> Using /lib/modules/2.4.25/serial_cs.o
> insmod: unresolved symbol unregister_serial
> insmod: unresolved symbol register_serial
>  
> so I realize that I should also insert "serial.o" into the linux, but 
> crashes ...
>  
> / # insmod serial
> Using /lib/modules/2.4.25/serial.o
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ enabled
> Machine check in kernel mode.
> Caused by (from SRR1=1032): Transfer error ack signal
> ! Oops: machine check, sig: 7
> NIP: C3040078 XER: 00000000 LR: C3044724 SP: C1CC1D60 REGS: c1cc1cb0 
> TRAP: 0200    No
> t tainted
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c1cc0000[33] 'busybox' Last syscall: 128
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C1CC1D60 C1CC0000 C1CC1D70 00000004 00000001 00000B4B 
> C015378B
> GPR08: 00000000 800003FC 00000003 C1CC1C70 C0170000 10084438 00000000 
> 00000000
> GPR16: 00000000 00000000 00000000 00000000 00009032 1016EDB0 C1D3A000 
> C1CC1EA0
> GPR24: C1F6B760 00000006 C304973C C1CC1D70 C3040000 00000000 00000000 
> C3046348
> Call backtrace:
> C3044718 C3045188 C0012440 C00043BC 10080000 10021DF0 100238CC
> 1000457C 100041A0 1000436C 1000457C 100041A0 0FE70EF4 00000000
>  
> I only knows when i insert the serial.o, this driver will try to access 
> the standard uart which is not available in my system (my system only 
> has one uart by SMC1), then the system will crash eac! h time the 
> driver wants to access the registers does not available ...
>  
> The project deadline is near ... so I ask here ...
>  
> can anyone helps me or give me some clues?
>  
You should take a look for instance how 8349 does this job (arch/ppc/syslib/ppc83xx_setup.c) - it also has "standard" UART, but some stuff needs to be set up
prior to serial.o. Of course that is not complete solution for your case, just a hint...
> Thanks all
>  
>  
> 
> 
> Best regards,
> Chung
> 
> _______________________________________
> YM - 離線訊息
> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何 
> 說話都冇走失。
> http://messenger.yahoo.com.hk
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Sincerely, 
Vitaly
