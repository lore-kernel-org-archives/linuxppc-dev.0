Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DC939B70D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 02:19:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Serial RapidIO Maintaintance read causes lock up
Date: Tue, 5 Oct 2010 08:11:34 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B9AFE@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
	<AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Bastiaan Nijkamp" <bastiaan.nijkamp@gmail.com>,
	"John Traill" <john.traill@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com> wrote:=20
=A0
>A interesting thing that i found out is that when the agent is reset =
while the host is >locked up (eg. it cannot be stopped nor can i read =
the registers and memory trough a JTAG >Interface), the host comes back =
online and just continues booting linux with a RapidIO >error. See the =
log below.
... skip ...=A0
>fsl_rio_config_read: going to request to read data at d1080068
>RIO: cfg_read error -14 for ff:0:68
... skip ...
>RIO: master port 0 device has lost enumeration to a remote host

Looks like during agent reset your SRIO link becomes good and host's =
requests go ahead.
After that you get a machine check (response time out): link is OK but =
agent is not configured.

Can you check/print 0xC_0148 and 0xC_0158 registers of SRIO block before =
the first maintenance read.

Alex.
=20
