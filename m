Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id A20A8DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 05:17:38 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1534647rvf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 12:17:37 -0700 (PDT)
Message-ID: <9e4733910709181217v417438s85bb9e6b4ad4b475@mail.gmail.com>
Date: Tue, 18 Sep 2007 15:17:37 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen@coderock.org>
Subject: Re: [PATCH] phy: export phy_mii_ioctl
In-Reply-To: <20070918151622.GD32628@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
	<20070915121444.GA19857@nd47.coderock.org>
	<20070917095334.GA4546@powerlinux.fr>
	<20070917202140.GB2642@nd47.coderock.org>
	<9e4733910709171508s76c842c8hca236249617cbb44@mail.gmail.com>
	<20070918151622.GD32628@nd47.coderock.org>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/18/07, Domen Puncer <domen@coderock.org> wrote:
> More testing and getting it to work properly on Phytec pcm030 would
> be great.

I compiled it as a module:
  CC [M]  drivers/net/fec_mpc52xx/fec.o
drivers/net/fec_mpc52xx/fec.c:613: warning: 'mpc52xx_fec_mac_setup'
defined but not used

This code needs to be enclosed in "#ifndef MODULE". But why aren't you
using module_param() to make a string parameter and then copy it into
mpc52xx_fec_mac_addr[] if the parameter is not null?

If it is a module param you need to use
fec_mpc52xx_phy.mpc52xx-mac="xxxx" instead of just mpc52xx-mac. The
way it is not you can't use mpc52xx-mac when built as a module.

static int __init mpc52xx_fec_mac_setup(char *mac_address)
{
        int i;
        u64 val64;

        val64 = simple_strtoull(mac_address, NULL, 16);

        for (i = 0; i < 6; i++)
                mpc52xx_fec_mac_addr[5-i] = val64 >> (i*8);

        return 0;
}

__setup("mpc52xx-mac=", mpc52xx_fec_mac_setup);



-- 
Jon Smirl
jonsmirl@gmail.com
