Message-ID: <3BD68B50.8090904@elsoft.ch>
Date: Wed, 24 Oct 2001 11:35:12 +0200
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Registering RTC access methods in platform_init()
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I have a question regarding the registering of the RTC access methods in
platform_init() in ppc4xx_setup.c.
The problem is quite similar to the one i stated in
one of my previous e-mails "Additional IRQ handlers in ppc4xx_init_IRQ()".

Currently this is done in this way:

#ifdef CONFIG_PPC_RTC
/* new timer stuff */
	ppc_md.time_init = todc_time_init;
	ppc_md.set_rtc_time = todc_set_rtc_time;
	ppc_md.get_rtc_time = todc_get_rtc_time;

#if !defined(CONFIG_PIP405) && !defined(CONFIG_MIP405)
	ppc_md.nvram_read_val = todc_direct_read_val;
	ppc_md.nvram_write_val = todc_direct_write_val;
#else
	ppc_md.nvram_read_val = todc_mc146818_read_val;
	ppc_md.nvram_write_val = todc_mc146818_write_val;
#endif
#endif


All other ports using a MC146818 RTC have their own xxx_setup.c file
(Sandpoint, Adirondack, ...).

I suppose the preferred way to solve this is to replace this whole init
code by a call to a board specific init routine?




Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
