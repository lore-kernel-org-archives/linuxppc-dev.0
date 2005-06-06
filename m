Return-Path: <edward.qin.hong@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id 177E3679FC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 06:00:11 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 16so1847238nzp
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 06 Jun 2005 13:00:09 -0700 (PDT)
Message-ID: <21fb73bc0506061300126b1c43@mail.gmail.com>
Date: Mon, 6 Jun 2005 14:00:09 -0600
From: Edward Hong <edward.qin.hong@gmail.com>
To: Randy Vinson <rvinson@mvista.com>
In-Reply-To: <42A49A80.9000405@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <21fb73bc0506041640736e3020@mail.gmail.com>
	<20050605002832.6311AC1512@atlas.denx.de>
	<21fb73bc050605223311af6408@mail.gmail.com>
	<42A49A80.9000405@mvista.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel ported from ELDK 3.0 hangs (loops in idled()) on my
	custom MPC870 Board
Reply-To: Edward Hong <edward.qin.hong@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/6/05, Randy Vinson <rvinson@mvista.com> wrote:
>=20
> Hi Edward,
>   I've seen these symptoms before. The problem was traced to external
> interrupts being disabled (MSR[EE] not set). Without external
> interrupts, there is no decrementer interrupt (at least on 7xx
> processors). Without the decrementer, there in no system clock tick and
> without the clock tick, the scheduler won't run which means that the
> init task won't start. To verify that this is the problem, use mfmsr()
> to get the MSR and print it. I'd suggest that you add something like:
>=20
>     printk("MSR =3D %x\n", mfmsr());
>
I got  MSR =3D 9032 just before cpu_idle which means EE (the most
significant bit) was enabled.

Thank you!

Edward
