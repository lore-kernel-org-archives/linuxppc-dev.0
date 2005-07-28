Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15805.mail.cnb.yahoo.com (web15805.mail.cnb.yahoo.com
	[202.165.102.85]) by ozlabs.org (Postfix) with SMTP id 3679767D9D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 18:57:14 +1000 (EST)
Message-ID: <20050728085706.74550.qmail@web15805.mail.cnb.yahoo.com>
Date: Thu, 28 Jul 2005 16:57:06 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20050727135233.7367.qmail@web15803.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: Re : custom ads8272 board PCI interrupt no response
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam Song <samlinuxppc@yahoo.com.cn> wrote:
> Hi all,
> 
> A PCI interrupt probelm confused me when porting
> 2.6.13-rc3 on a custom 8248 board. There was a 
> Gb ethernet RTL8110S on board with IDSEL AD25 and
> IRQ3. So I made some changes as follows:
> 
> --- linux-2.6.13-rc3/arch/ppc/platforms/pq2ads.h
> +++ linux-2.6.13-rc3-sam/arch/ppc/platforms/pq2ads.h
> @@ -74,11 +78,11 @@
> -#define PCI_INT_TO_SIU 	SIU_INT_IRQ2
> +#define PCI_INT_TO_SIU 	SIU_INT_IRQ3

Ummm, not the case. ADS8272 uses a CPLD PCI interrupt
controller which takes up IRQ2. No need to me:-)

> --- linux-2.6.13-rc3/arch/ppc/syslib/m82xx_pci.c
> +++ linux-2.6.13-rc3-sam/arch/ppc/syslib/m82xx_pci.c
> @@ -60,12 +60,20 @@
>       * 	  A      B      C      D
>       */
>       {
> +#if 0
>     { PIRQA, PIRQB, PIRQC, PIRQD },/* IDSEL 22 - PCI
> 
> slot 0 */
>     { PIRQD, PIRQA, PIRQB, PIRQC }, /* IDSEL 23 -
> PCI 
> slot 1 */
>     { PIRQC, PIRQD, PIRQA, PIRQB }, /* IDSEL 24 -
> PCI 
> slot 2 */
> +#else  
> + {22, 22, 22, 22},/* IDSEL 22/IRQ4-PCI slot 0-USB
> */
> + {23, 23, 23, 23},/* IDSEL 23/IRQ5-PCI slot 1-IDE
> */
> + {24, 24, 0,   0},/* IDSEL 24 - PCI slot # - NULL
> */
> + {25, 25, 25, 25},/* IDSEL 25/IRQ3-PCI slot 2- Gb
> */

Set IRQ3 in the last line as 21 to assign the IRQ3
to Gb ethernet.

> Gb interrupt remained unchangable in the whole test
> process. I could ping target itself but not for 
> outside machine. So I suspect this result was due to
> PCI interrupt setting but don't know where the
> probelm is. Any idea?

Well, I finally masked pq2ads interrupt irq init and
adjusted SIUMCR IRQ3 setting correctly. Then 
everything went as smoothly as clockwork.

Sorry to bother here:-)

Sam

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
