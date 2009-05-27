Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 70977DE044
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 10:44:47 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so2210644qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 17:44:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
Date: Tue, 26 May 2009 20:44:45 -0400
Message-ID: <9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
From: Jon Smirl <jonsmirl@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 8:38 PM, Timur Tabi <timur@freescale.com> wrote:
> On Tue, May 26, 2009 at 7:25 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> - =A0 =A0 =A0 spin_event_timeout(0, 10, 0, rc);
>> + =A0 =A0 =A0 spin_event_timeout(0, 10, 0);
>> =A0 =A0 =A0 =A0out_8(&regs->op0, MPC52xx_PSC_OP_RES);
>> - =A0 =A0 =A0 spin_event_timeout(0, 50, 0, rc);
>> + =A0 =A0 =A0 spin_event_timeout(0, 50, 0);
>
> Jon, I'm still hoping you'll explain why you're not using udelay() here.

Because Grant didn't want me doing udelay(50) just to delay things in
order to give the AC97 controller time to initialize. Your function
lets me loop on cpu_relax() for 50us.

I have to delay 50us because ALSA tries to access the hardware
immediately after the function returns.

>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>



--=20
Jon Smirl
jonsmirl@gmail.com
