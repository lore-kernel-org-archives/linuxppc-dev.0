Return-Path: <yoni.l@slyde-tech.com>
Received: from smtpin.livedns.co.il (smtpin.livedns.co.il [62.219.78.209])
	by ozlabs.org (Postfix) with ESMTP id 73B47DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 18:37:31 +1000 (EST)
From: "Yoni Levin" <yoni.l@slyde-tech.com>
To: "'Scott Wood'" <scottwood@freescale.com>
Subject: RE: GPIO interrupts on mpc8313e
Date: Thu, 2 Aug 2007 11:37:14 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20070801183616.GA24549@ld0162-tx32.am.freescale.net>
Message-ID: <9299F00F70CC4A0EBD33A4EB9E95D9D2.MAI@mail.livedns.co.il>
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

Yes, I removed the flag (0) and nothing change in both cases the request_irq
return 0 which is good.
Then I added enable_irq and I recived :

Unbalanced enable for IRQ 74
------------[ cut here ]------------
Badness at c0043578 [verbose debug info unavailable]
Call Trace:
[C76C9D00] [C0008648] show_stack+0x48/0x194 (unreliable)
[C76C9D30] [C0139364] report_bug+0x84/0xac
[C76C9D40] [C000E398] program_check_exception+0xe0/0x538
[C76C9D80] [C000FE04] ret_from_except_full+0x0/0x4c
--- Exception: 700 at enable_irq+0x80/0xb0
    LR = enable_irq+0x80/0xb0
[C76C9E50] [C907423C] CreateGPIOHandler+0x28/0x7c [modexample]
[C76C9E70] [C9074728] init_module+0x2c/0x8c [modexample]
[C76C9E80] [C003B568] sys_init_module+0x1c4/0x165c
[C76C9F40] [C000F7BC] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff311f0
    LR = 0x100316a8

By the way this is my code :

static irqreturn_t GPIOinterrupt_handler(int i,void *n,struct pt_regs *
myRegs)
{
	printk("GPIO recived and handled !!!!!!!!!!!!!!!!!!!...\n");
	return IRQ_HANDLED;	
}




void CreateGPIOHandler()
{

	unsigned int myirq=irq_create_mapping(NULL,74);
	enable_irq(74);
	printk("myirq is : %d \n",myirq);
	int ret;

	ret=- request_irq(74, GPIOinterrupt_handler,0, "GPIO", NULL);
	printk("ret is : %d \n",ret);
	

}

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com] 
Sent: Wednesday, August 01, 2007 9:36 PM
To: Yoni Levin
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: GPIO interrupts on mpc8313e

On Wed, Aug 01, 2007 at 02:45:05PM +0300, Yoni Levin wrote:
> request_irq(74,handler,IRQF_DISABLED,"GPIO",NULL);
                         ^^^^^^^^^^^^^

Did you try removing that flag (or calling enable_irq())?

-Scott
