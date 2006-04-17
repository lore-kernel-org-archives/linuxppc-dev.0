Return-Path: <ALEBAS@televes.com>
Received: from televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with SMTP id A6DFE67B1B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Apr 2006 18:31:30 +1000 (EST)
Message-ID: <51DB8827D393D411BB69003048003F4601B1C2D0@tvesntr>
From: Bastos Fernandez  Alexandre <ALEBAS@televes.com>
To: 'Mike Rapoport' <mike@compulab.co.il>, Bastos Fernandez  Alexandre
	<ALEBAS@televes.com>
Subject: RE: Watchdog on MPC82xx
Date: Mon, 17 Apr 2006 10:31:12 +0200
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike,

I tested several times last week but it didn't work for me.
I had made the changes in U-boot as you say, but it keeped
reseting at the time. In fact, in the log_buf I can see
several printk's after setup_arch (where ppc_md.heartbeat)
is assigned, but the watchdog counter is not reloaded.

Which could be the difference? I am using ramdisk,
and a MPC8248 clocked at 100MHz, but I don't think
this will be the reason.

Now, someone has proposed me to try reloading WDT in
printk calls. I will test.

Best regards,

Alex



> Bastos Fernandez Alexandre wrote:
> 
> >
> >So, any other idea? Is the WDT on MPC8248 usable at all?
> >  
> >
> I used the watchdog timer on mpc8247 and mpc8271. The mpc8248 watchdog 
> should be the same. I used ppc_md.heartbeat to write to the watchdog 
> registers and it worked fine. Also, I've added WATCHDOG_RESET()  to 
> common/cmd_bootm.c in U-Boot just before the jump to kernel.
> 
> >Thanks,
> >
> >Alex
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> >
> >  
> >
> 
> 
> -- 
> Sincerely yours,
> Mike Rapoport
> -----------------------------------------------------------------
> CompuLab Ltd.
> Web: http://www.compulab.co.il
