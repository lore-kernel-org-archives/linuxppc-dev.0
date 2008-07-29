Return-Path: <matvejchikov@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 68E45DDFF2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jul 2008 16:10:30 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so741528qwb.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jul 2008 23:10:28 -0700 (PDT)
Message-ID: <8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
Date: Tue, 29 Jul 2008 10:10:27 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (PQ2FADS based
	board)
In-Reply-To: <488E2510.7070209@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

No, it's not working for me :(

My pins is configured by u-boot so I disable init_ioports() function
call. Moreover the udbg0 console forks fine... I have no output at all
after "udbg_putc = NULL" line in the cpm_uart driver. As I see it the
cpm_uart driver doesn't run properly after udbg console has turned
off.....

2008/7/28 Scott Wood <scottwood@freescale.com>:
> Matvejchikov Ilya wrote:
>>
>>                cpm@119c0 {
>>                        #address-cells = <1>;
>>                        #size-cells = <1>;
>>                        #interrupt-cells = <2>;
>>                        compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
>
> Add "simple-bus" to this compatible list.
>
> Other than that, and that you should be using dts-v1, the tree looks fine.
>  If adding "simple-bus" doesn't fix it, check your pin setup; pq2fads
> doesn't have an SMC serial port, so its platform file doesn't set up those
> pins.
>
> -Scott
>
>
