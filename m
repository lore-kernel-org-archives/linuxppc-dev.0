Return-Path: <gjalt007@chello.nl>
Received: from viefep14-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id BB52EDDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 05:05:28 +1100 (EST)
Message-ID: <472A14D3.30500@chello.nl>
Date: Thu, 01 Nov 2007 19:02:59 +0100
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: matvejchikov@gmail.com
Subject: Re: reboot of mpc8270 sometimes fails
References: <8496f91a0710311314k3dd90e12t670e2405fcaa0725@mail.gmail.com>
In-Reply-To: <8496f91a0710311314k3dd90e12t670e2405fcaa0725@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I solved our problem a different way: I added a reset of the CPM just 
before calling te m8260_gorom().
The effect is that the message "rebooting" which was often followed by a 
strange character is now cut short ("reboo"), but uboot is always 
comming up afterwards. I've tested this by adding a "reboot" command in 
an S script in rc3.d. The system with the unpatched kernel failed 
aboutonce every 30 times it rebooted, with the patch it continued 
rebooting correctly for 3 days (then I stopped the tests by hand).

The code for rebooting the CPM was obtained from the freescale manuals 
of the mpc8270.
Anyone interested in the actual patch?

Theo.

Matvejchikov Ilya schreef:
> Hi!
>
> I thik that m8260_restart in 2.4 kernel is broken. Try to get it from
> the 2.6 kernel, or look at this.
>
>  /* The 8260 has an internal 1-second timer update register that
> @@ -112,21 +123,16 @@ m8260_get_rtc_time(void)
>  static void
>  m8260_restart(char *cmd)
>  {
> -	extern void m8260_gorom(bd_t *bi, uint addr);
> -	uint	startaddr;
> -
> -	/* Most boot roms have a warmstart as the second instruction
> -	 * of the reset vector.  If that doesn't work for you, change this
> -	 * or the reboot program to send a proper address.
> -	 */
> -	startaddr = 0xff000104;
> -
> -	if (cmd != NULL) {
> -		if (!strncmp(cmd, "startaddr=", 10))
> -			startaddr = simple_strtoul(&cmd[10], NULL, 0);
> -	}
> -
> -	m8260_gorom((unsigned int)__pa(__res), startaddr);
> +	__volatile__ unsigned char dummy;
> +	
> +	local_irq_disable();
> +	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= 0x00000001;
> +
> +	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
> +	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
> +	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
> +	printk("Restart failed\n");
> +	while (1) ;
>  }
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
