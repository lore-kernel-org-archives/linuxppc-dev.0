Return-Path: <thunderbird2k@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id 6EA56DE0E2
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 07:31:33 +1000 (EST)
Received: by bwz19 with SMTP id 19so937834bwz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 14:31:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49E8F2D7.3050603@embeddedarm.com>
References: <49E8F2D7.3050603@embeddedarm.com>
Date: Fri, 17 Apr 2009 23:31:30 +0200
Message-ID: <c8485d470904171431r274e9974p4aff7ccaa3a3b274@mail.gmail.com>
Subject: Re: PowerPC iotable_init equivalent?
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 11:21 PM, Eddie Dawydiuk <eddie@embeddedarm.com> wr=
ote:
> Hello,
>
> In the past I've worked with ARM architectures where I could setup virtua=
l /
> physical address mappings so I don't have to ioremap then pass around
> pointers. Does PowerPC have an equivalent abstraction? If not whats the
> recommended approach?
>
> That is, is there a better approach to the following...
>
> volatile static unsigned char *my_reg =3D NULL;
>
> static inline void read_func() {
>
> =A0 =A0 =A0 =A0if (!my_reg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my_reg =3D (unsigned char *)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ioremap(REG_PHYS_BASE, REG=
_SIZE);
> //do something with the reg
> }
>
>
> static inline void write_func() {
>
> =A0 =A0 =A0 =A0if (!my_reg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my_reg =3D (unsigned char *)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ioremap(REG_PHYS_BASE, REG=
_SIZE);
> //do something with the reg
> }
>
> --
> Best Regards,
> ________________________________________________________________
> =A0Eddie Dawydiuk, Technologic Systems | voice: =A0(480) 837-5200
> =A016525 East Laser Drive =A0 =A0 =A0 =A0 =A0 =A0 =A0| fax: =A0 =A0(480) =
837-5300
> =A0Fountain Hills, AZ 85268 =A0 =A0 =A0 =A0 =A0 =A0| web: www.embeddedARM=
.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

In general you set devices up a dts file. You can reach its contents
using openfirmware functions (of_*). In general you use an of_*
function to look up your periperhal in the device tree. Once you have
its node you would able to do e.g. of_iomap (which uses ioremap with
the right offsets behind its back) to map the device. So you don't
hard code physical addresses anymore in the code.

Regards,
Roderick Colenbrander
