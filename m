Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id F32F8DDF08
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 05:31:20 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1817946anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 10:31:19 -0800 (PST)
Message-ID: <fa686aa40802181031s4ba6ec4eie949040f0bf23ad6@mail.gmail.com>
Date: Mon, 18 Feb 2008 11:31:19 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: arch_initcall time
In-Reply-To: <47B9CE4D.1020303@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47B9CE4D.1020303@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 18, 2008 11:28 AM, Sean MacLennan <smaclennan@pikatech.com> wrote:
> I need to call i2c_register_board_info for the new i2c style ad7414
> driver. This needs to be called at arch initcall time. Currently I just
> do this:
>
> static int __init warp_arch_init(void)
> {
>         i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
>         return 0;
> }
> arch_initcall(warp_arch_init);

Yes, this is the right thing to do, but use machine_arch_initcall()
instead so that it doesn't get called if it is not your board.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
