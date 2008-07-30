Return-Path: <BenGardiner@nanometrics.ca>
Received: from nmxmail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with ESMTP id B92DFDDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 23:35:22 +1000 (EST)
Message-ID: <48906E4E.5060701@nanometrics.ca>
Date: Wed, 30 Jul 2008 09:36:14 -0400
From: Ben Gardiner <BenGardiner@nanometrics.ca>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
	<20080729193630.GB8051@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080729193630.GB8051@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Scott Wood wrote:
> On Tue, Jul 29, 2008 at 11:33:47AM -0400, Ben Gardiner wrote:
>> CPU clock-frequency <- 0x3f940aa (67MHz)
>> CPU timebase-frequency <- 0x1fce17 (2MHz)
>> CPU bus-frequency <- 0x1fce170 (33MHz)
>>     
>
> Try commenting out calls to cpm_setbrg(), to see if the frequency is bad.
>
> -Scott
>   

Thank you, Scott. You spotted it: my bootloader (an old uboot) is 
passing not only the wrong clock freq (66.7 instead of 66 MHz) but 
because 66.7 > 66.0 it is also passing the clock freq / 2 as the bus 
freq. I got that last leap from the commit message of 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=50530378161fa8d7837243119ed9140ee65e55d4. 
Thanks to cuboot I had an obvious place to do the fixup of the 
clock-freq but I hadn't realized that the bus-freq was wrong.

As you suggested, commenting out the call to cpm_setbrg() did the trick 
for me:
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h 
b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index ddf46d3..c14a5f1 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -24,7 +24,7 @@ #endif
 
 static inline void cpm_set_brg(int brg, int baud)
 {
-       cpm_setbrg(brg, baud);
+       //cpm_setbrg(brg, baud);
 }

Of course I won't run with that patch. We are using cuboot, so I put 
some fixup code in our copy of cuboot-8xx.c, cuboot-nmx-taurus.c:
diff --git a/arch/powerpc/boot/cuboot-nmx-taurusc 
b/arch/powerpc/boot/cuboot-nmx-taurus.c
index c202c88..5ab2ff3 100644
--- a/arch/powerpc/boot/cuboot-nmx-taurus.c
+++ b/arch/powerpc/boot/cuboot-nmx-taurus.c
@@ -26,6 +26,12 @@ static void platform_fixups(void)
 
        dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
        dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+       /* NMX workaround: fix board reporting wrong freq */
+       if(bd.bi_intfreq == 66700000) {
+               bd.bi_intfreq = 66666666UL;
+               bd.bi_busfreq = bd.bi_intfreq;
+       }
+       /* end NMX workaround.*/
        dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 16, 
bd.bi_busfreq);
 
        node = finddevice("/soc/cpm");

NB: I realize 66666666 may be wrong. It is what was set in our 2.4 
kernel so I'm going to leave it as is for now. If I can show that it is 
causing clock drift or someone can give me a reason why it should be 
66000000 I'll change it then.

Which fixes up the values passed by Uboot:
<snip console>
...
CPU clock-frequency <- 0x3f940aa (67MHz)
CPU timebase-frequency <- 0x3f940a (4MHz)
CPU bus-frequency <- 0x3f940aa (67MHz)
...
<snip>

Thanks for your help and for cuboot.
I'm sorry to have confused this issue. It appears that Matvejchikov and 
I are having a different problem.

,Ben
