Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id DA1C4DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 02:17:32 +1100 (EST)
Received: by qyk14 with SMTP id 14so1792761qyk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 07:17:30 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
Date: Thu, 19 Feb 2009 09:17:30 -0600
Message-ID: <ed82fe3e0902190717p5658fc12k7552a9e178e9302@mail.gmail.com>
Subject: Re: Newby trying to get Ethernet going on MPC83xx series device.
From: Timur Tabi <timur@freescale.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 19, 2009 at 12:58 AM, Dushara Jayasinghe
<DusharaJ@optiscan.com> wrote:
> I based my board specific file on mpc834x_itx.c which had
>
> static struct of_device_id __initdata mpc834x_itx_ids[] = {
>                 { .compatible = "fsl,pq2pro-localbus", },
>                 { .compatible = "simple-bus", },
>                 {},
> };
>
> Don't know if this is broken?

Actually, it's your device tree that's broken.  The above is the right
way to do it.  The other way:

static struct of_device_id mpc834x_ids[] = {
        { .type = "soc", },
        { .compatible = "soc", },
        { .compatible = "simple-bus", },
        {},
};

is the old way.  You're missing a compatible=simple-bus in your device tree.

-- 
Timur Tabi
Linux kernel developer at Freescale
