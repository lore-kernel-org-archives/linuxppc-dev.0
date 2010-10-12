Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9E97AB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 13:58:49 +1100 (EST)
Message-ID: <4CB3CF5F.4090006@windriver.com>
Date: Tue, 12 Oct 2010 11:00:47 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>	<20100921170700.53a99e56@udp111988uds.am.freescale.net>	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>	<20101007152626.4e834d43@udp111988uds.am.freescale.net>	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>
	<4CB2DEFB.90204@windriver.com>
In-Reply-To: <4CB2DEFB.90204@windriver.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tiejun.chen wrote:
> david.hagood@gmail.com wrote:
>> OK, using 224 as the MPIC interrupt number, and attempting to map it via
>> irq_create_mapping(0,224) gives me a kernel seg fault:
> 
> This should not be correct without initialing MSI for MPIC host. As I comment on
> another email, please refer to the file, arch/powerpc/sysdev/fsl_msi.c.

With Scott's comment I remember the NULL host would be always 'irq_default_host'
at last. The 'irq_default_host' should be your MPIC host so it should be fine.

> 
> -Tiejun
> 
>> Unable to handle kernel paging request for data at address 0x00000000
>> Faulting instruction address: 0xc0016540
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> PREEMPT SMP NR_CPUS=2 EP8641A
>> Modules linked in: Endpoint_driver(+)
>> NIP: c0016540 LR: c0050b38 CTR: c00163b8
>> REGS: ef8c1ab0 TRAP: 0300   Not tainted  (2.6.26.2-ep1.10)
>> MSR: 00001032 <ME,IR,DR>  CR: 24024482  XER: 00000000
>> DAR: 00000000, DSISR: 40000000
>> TASK = eedec6a0[60] 'insmod' THREAD: ef8c0000 CPU: 1
>> GPR00: 00000000 ef8c1b60 eedec6a0 ffffffea 00000000 00000000 c035c17c
					^
					The return value, r3, should be -22, '-EINVAL'.

And refer to the call trace and the source codes
------
int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
{
        struct mpic *mpic = mpic_from_irq(virq);
        unsigned int src = mpic_irq_to_hw(virq);
        struct irq_desc *desc = get_irq_desc(virq);
        unsigned int vecpri, vold, vnew;

        DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
            mpic, virq, src, flow_type);

        if (src >= mpic->irq_count)
                return -EINVAL;
			^
			I think this OOPS may be from here.

You can enable DBG on this file, arch/powerpc/sysdev/mpic.c, to track 'src' and
'mpic->irq_count' on your old tree.

-Tiejun

>> 000000e0
>> GPR08: 00400000 00000000 c035c020 00000000 24024422 100a7264 00000000
>> 00000095
>> GPR16: 00000095 00000000 0000000d 00000124 f102fd98 00000000 c004a4fc
>> f102c000
>> GPR24: 0000001a f1038400 00000000 c031e610 fffffffa 00009032 c031e5e0
>> 000000e0
>> NIP [c0016540] mpic_set_irq_type+0x188/0x1c4
>> LR [c0050b38] set_irq_type+0x84/0xc8
>> Call Trace:
>> [ef8c1b60] [c0050b1c] set_irq_type+0x68/0xc8 (unreliable)
>> [ef8c1b80] [c001572c] mpic_host_map+0xec/0xf4
>> [ef8c1b90] [c00064a0] irq_setup_virq+0x60/0x98
>> [ef8c1bb0] [c00065dc] irq_create_mapping+0x104/0x114
>> [ef8c1bd0] [f1034798] Endpoint_device_ctor+0x258/0x3b8 [Endpoint_driver]
>>
>> Reading the source (since these calls don't seem to have any other
>> documentation), it *looks* like it ought to be valid to call
>> irq_create_mapping with a null irq_host *host - which is good, since I
>> can't see anything obvious that would give me some other irq_host (again,
>> since none of this seems to be documented anywhere).
>>
>> I am assuming the default host used by the system would be correct.
>>
>> However, then I get this fault.
>>
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
