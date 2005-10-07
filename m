Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 9B2D6684D1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 01:12:54 +1000 (EST)
Message-ID: <43469074.9050303@ru.mvista.com>
Date: Fri, 07 Oct 2005 19:12:52 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Studencki Pawel <pawel.studencki@siemens.com>
References: <253377027D27DA11B7010002A5AE5CFE0B72B6@nbgh103a.nbg6.siemens.de>
In-Reply-To: <253377027D27DA11B7010002A5AE5CFE0B72B6@nbgh103a.nbg6.siemens.de>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: TQM8260 and linux-2.6.14-rc3
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Studencki Pawel wrote:
> hello,
> 
> Trying to boot linux-2.6.14-rc3 on TQM8260 I found,
> that following line is missing in file arch/ppc/syslib/m8260_setup.c:
> 
> -----------------------------------------------------------------------
> --- m8260_setup.c.org   2005-10-07 16:42:41.420238000 +0200
> +++ m8260_setup.c       2005-10-07 16:41:58.811408400 +0200
> @@ -249,6 +249,8 @@
>                 strcpy(cmd_line, (char *)(r6+KERNELBASE));
>         }
>  
> +        identify_ppc_sys_by_id(mfspr(SPRN_SVR));
> +

This is not quite right. For these types of boards (at least, most of), 
the soc id is stored in the immr register. But yes, that's definitely a 
problem, I'll take a look at this asap.

>         ppc_md.setup_arch               = m8260_setup_arch;
>         ppc_md.show_cpuinfo             = m8260_show_cpuinfo;
>         ppc_md.init_IRQ                 = m8260_init_IRQ;
> ---------------------------------------------------------------------
> 
> 
> if not set, we get problem here:
> 
> static int __init ppc_sys_init(void) 
> {
>         unsigned int i, dev_id, ret = 0;
> 
>         BUG_ON(cur_ppc_sys_spec == NULL);   <--------------------------
> 
> 
> Moreover the default configuration found in
> arch/ppc/configs/TQM8260_defconfig
> doesn't work or I do something wrong.
> for example configuration of serial port:
> 
> #
> # Serial drivers
> # 
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> # 
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=32
> 
> inspite of this I use following(SMC1):
> 
> #
> # Serial drivers
> #
> # CONFIG_SERIAL_8250 is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_CPM=y
> CONFIG_SERIAL_CPM_CONSOLE=y
> # CONFIG_SERIAL_CPM_SCC1 is not set
> # CONFIG_SERIAL_CPM_SCC2 is not set
> # CONFIG_SERIAL_CPM_SCC3 is not set
> # CONFIG_SERIAL_CPM_SCC4 is not set
> CONFIG_SERIAL_CPM_SMC1=y
> # CONFIG_SERIAL_CPM_SMC2 is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> 
> 
> best regards
> Pawel
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly
