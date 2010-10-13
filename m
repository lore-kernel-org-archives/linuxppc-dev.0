Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DEC01B70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 00:38:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Serial RapidIO Maintaintance read causes lock up
Date: Wed, 13 Oct 2010 06:38:49 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552013FCC59@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTimk2hRhyX4WufjdviDz-OTj7VRfjA94oyoXL9mM@mail.gmail.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com><AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com><4CAB2729.6080402@freescale.com><AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com><4CAB39F4.3030208@freescale.com><AANLkTimKbibzzNc3+DSJHcLC4gA0H5JiM+EHW2k4znZ-@mail.gmail.com>
	<AANLkTimk2hRhyX4WufjdviDz-OTj7VRfjA94oyoXL9mM@mail.gmail.com>
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

Bastiaan Nijkamp wrote:
=A0
>Has the driver ever been tested/used without a switch attached? Because =
when the host >(which has ID 0x0) enumerates the other board it also =
assigns ID 0x0 to the agent, it seems >that the agent should have=A0been =
assigned 0x1 as ID.

How the host ID is set on your host board?
Normally rio_enum_host() should increment next_destid in your case.=20

>Another thing is that the agent is now hanging on the discovery =
process.

Make sure that you have the MASTER bit is set in agent's GCCSR register =
(0xC_013C).
If your board uses HW config switches to set host/agent mode this bit =
will be 0 for agent.
For quick test you may keep both boards in the host mode - the current =
RIO implementation relies on "riohdid=3D" command line parameter instead =
of HOST bit.


Alex.
=20
=A0
