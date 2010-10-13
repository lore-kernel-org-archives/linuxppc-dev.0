Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6DC9D1007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 02:34:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Serial RapidIO Maintaintance read causes lock up
Date: Wed, 13 Oct 2010 08:34:31 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552013FCCE2@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTikV69ZThBQbetT0f=PZGQos3qWKjqjoNJXysH2V@mail.gmail.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
	<AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
	<4CAB39F4.3030208@freescale.com>
	<AANLkTimKbibzzNc3+DSJHcLC4gA0H5JiM+EHW2k4znZ-@mail.gmail.com>
	<AANLkTimk2hRhyX4WufjdviDz-OTj7VRfjA94oyoXL9mM@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552013FCC59@CORPEXCH1.na.ads.idt.com>
	<AANLkTikV69ZThBQbetT0f=PZGQos3qWKjqjoNJXysH2V@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Bastiaan Nijkamp" <bastiaan.nijkamp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com> wrote:

>>=A0How the host ID is set on your host board?
>> Normally rio_enum_host() should increment next_destid in your case.
>
> The hostID is set to 0x0 with the riohdid parameter as boot =
argument.=A0
>

In this case I would expect to see ID=3D1 assigned to the endpoint. I =
will take a look based on your use scenario. Let me know if you find the =
source of problem before I get back to you about this issue.=20

>>=A0Make sure that you have the MASTER bit is set in agent's GCCSR =
register (0xC_013C).
>> If your board uses HW config switches to set host/agent mode this bit =
will be 0 for
>> agent.
>> For quick test you may keep both boards in the host mode - the =
current RIO implementation >> relies on "riohdid=3D" command line =
parameter instead of HOST bit.
>
> This seems to have done the trick :-) However, i wonder, doesn't it =
make more sense to
> make the driver check this setting and correcting it or giving an =
error instead of
> entering a endless loop?=A0

One of my recent patches handles the MASTER bit. It is in -mm tree now.

In the case that you have seen, the agent does not enter endless loop - =
it just has request that cannot leave the SRIO controller. As result =
that request cannot be timed out and hangs the processor (no machine =
check).

Alex.
 =20
