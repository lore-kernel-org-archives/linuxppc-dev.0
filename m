Return-Path: <ml@iridescent.org>
Received: from mx0.connactivity.com (mx0.connactivity.com [66.112.160.20])
	by ozlabs.org (Postfix) with ESMTP id 79A6967A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 03:09:17 +1000 (EST)
Mime-Version: 1.0
Message-Id: <p06210211be8997487f7c@mail.iridescent.org>
In-Reply-To: <c3d0340b0504151609397d73f7@mail.gmail.com>
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
Date: Mon, 18 Apr 2005 10:01:02 -0700
To: Shawn Jin <shawnxjin@gmail.com>,
	ppcembed <linuxppc-embedded@ozlabs.org>
From: "Lawrence E. Bakst" <ml@iridescent.org>
Content-Type: text/plain; charset="us-ascii"
Subject: Re: Interrupt prioritization on linux for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I just want to say that in certain applications critical interrupts can be put to good use. There are issues you have to deal with when you use them. I wonder if any of the people saying that they "really don't think it's worth it" have ever had to meet any real time interrupt latency constraints?

Best,

leb


At 4:09 PM -0700 4/15/05, Shawn Jin wrote:
>On 4/15/05, Eugene Surovegin <ebs@ebshome.net> wrote:
>> On Fri, Apr 15, 2005 at 02:36:51PM -0700, Shawn Jin wrote:
>> >
>> > The home-made interrupt controller PIC supports interrupt priorities
>> > and critical/non-critical interrupts. I found that the current kernel
>> > doesn't support interrupt priorities.
>>
>> Yes, we don't have IRQ priorities on 4xx. Theoretically, they can be
> > emulated in get_irq, but I really don't think it's worth it.
>
>Hmmm...that's one way I thought of to implement IRQ priority. Why
>isn't it worth it? ppc4xx_pic gets the first irq from the least
>significant bit by calling ffs(). So theoretically and maybe
>practically some external interrupts will keep UART's interrupt from
>being served.
>
>> > Is this observation true? Is
>> > there any existing patch to support that?
>>
>> I'm not aware of such patch existence.
>
>By googling the Internet I found this patch for i386 architecture
>http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040304/rtirq.html.
>This mustn't have been caught sight of by linux mainstream.
>
>Anybody knows if RTAI or RTLinux supports IRQ priorities?
>
>> > I noticed that the implementation of ppc4xx_pic.c disables all
>> > critical interrupts during initialization. To support critical
>> > interrupts, is it so simple that we change the handler of critical
>> > exception from CriticalInput to do_IRQ in head_44x.S?
>>
>> No, it's not that simple. Linux doesn't support a notion of critical
>> IRQs versus normal ones. Until there is an infrastructure for this, it
>> doesn't make any sense to implement 4xx support.
>
>What kind of infrastructure can you think of to support this? ppc440
>at least provides some interrupt processing registers (CSSR0/1) to
>differentiate critical and non-critical interrupts.
>
>Another confusion about 440GP/GX UIC is the registers VCR (Vector
>Configuration Reg) and VR (Vector Reg). They seem to be totally
>useless on linux. The interrupt vector is already in the table of
>irq_desc[]. Why does the controller have to generate the address?
>
>Thanks for the inputs. Welcome more.
>
>Regards,
>-Shawn.
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
