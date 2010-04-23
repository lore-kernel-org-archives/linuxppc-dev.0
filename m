Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id 71A6CB7D1D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Apr 2010 01:32:11 +1000 (EST)
Received: by qyk27 with SMTP id 27so4743483qyk.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 08:32:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <z2m2acbd3e41004230814pc0ce9acasaf99a180d3f5b702@mail.gmail.com>
References: <x2v48abf2c21004221936kf5ca0a49mbf476d379038568@mail.gmail.com>
	<z2m2acbd3e41004230814pc0ce9acasaf99a180d3f5b702@mail.gmail.com>
Date: Fri, 23 Apr 2010 23:32:09 +0800
Message-ID: <g2u48abf2c21004230832g72e8d5bdz2a509af84a4ec70e@mail.gmail.com>
Subject: Re: My MDIO is acting strange
From: Peter Pan <pppeterpppan@gmail.com>
To: Andy Fleming <afleming@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

linux 2.6.22 is working correctly on my board. So, I think this is due
to the difference between them.
I will check the boot time difference between 2.6.22 and my new port.
Hope that will give me a clue.

2010/4/23 Andy Fleming <afleming@gmail.com>:
> On Thu, Apr 22, 2010 at 9:36 PM, Peter Pan <pppeterpppan@gmail.com> wrote=
:
>> I'm porting Linux 2.6.32.6 to my MPC8247 based board. Our FCC1 and
>> FCC2 are used as 100MBps ethernet ports. MDIO is used to connect with
>> PHY chip. During boot, the of driver is checking the PHYID, it gets
>> all Fs. But after I comment the following lines:
>> //if ((phy_id & 0x1fffffff) =3D=3D 0x1fffffff)
>> // =A0 =A0return NULL;
>> I can use my FCC ethernet normally after boot into console.
>
> This means that your PHY can work without any initialization, and
> implies the problem is with your MDIO bus.
>
>> I checked that while boot, all the read bit from MDIO pin is 1, that
>> makes no TA bit, and no PHYID.
>> I'm wondering why is that happening.
>
> Possible reasons include the board being wired incorrectly (so the PHY
> is not responding to MDIO commands), or software being configured
> incorrectly to use the wrong pins for MDIO. =A0That's my guess.
>
> Andy
>
