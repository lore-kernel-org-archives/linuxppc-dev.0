Return-Path: <gjalt007@chello.nl>
Received: from viefep16-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id C6144DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 19:45:11 +1100 (EST)
Message-ID: <475512F2.6040503@chello.nl>
Date: Tue, 04 Dec 2007 09:42:26 +0100
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: lobo fan <lobofan@gmail.com>
Subject: Re: reboot of mpc8270 sometimes fails
References: <d111b2340711212024o2c261b6bn790edf4b4b9f9d50@mail.gmail.com>
In-Reply-To: <d111b2340711212024o2c261b6bn790edf4b4b9f9d50@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Index: m8260_setup.c
===================================================================
RCS file: /home/.dbCVS_linux/kernel_2_4_25/arch/ppc/kernel/m8260_setup.c,v
retrieving revision 1.1.1.2
retrieving revision 1.2
diff -c -r1.1.1.2 -r1.2
*** m8260_setup.c	2006/11/17 07:58:49	1.1.1.2
--- m8260_setup.c	2007/10/08 07:53:54	1.2
***************
*** 148,154 ****
--- 148,164 ----
  		if (!strncmp(cmd, "startaddr=", 10))
  			startaddr = simple_strtoul(&cmd[10], NULL, 0);
  	}
+ #if defined (CONFIG_8260)
+ 	{
+ #include <asm-ppc/cpm_8260.h>
+ 	    volatile	cpm8260_t	*cp = &((immap_t *)IMAP_ADDR)->im_cpm;
  
+ 	    cp->cp_cpcr = (CPM_CR_RST | CPM_CR_FLG);   /* see page 14.17 $14.4.2 of the CPM manual */
+ 	    
+ 	    while (cp->cp_cpcr & CPM_CR_FLG);          /* Wait for it (should be 2 clocks). */
+ 
+ 	}
+ #endif
  	m8260_gorom((unsigned int)__pa(__res), startaddr);
  }
  




lobo fan schreef:
> Hi Theo,
> Could you please give me the patch? I am very interested in your patch.
>
> -- 
> Thanks.
>
> Best Regards,
> Lobo
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
