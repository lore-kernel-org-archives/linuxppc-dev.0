Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id B69271007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 02:59:30 +1100 (EST)
Received: by yxe8 with SMTP id 8so2903668yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 07:59:28 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <d1f76ba30911300150g10c1382clb2958245ebf94362@mail.gmail.com>
References: <d1f76ba30911300038w272578dfx9adb116bde493e00@mail.gmail.com>
	<d1f76ba30911300150g10c1382clb2958245ebf94362@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 30 Nov 2009 08:59:08 -0700
Message-ID: <fa686aa40911300759h153b3300uc54b5d1871bfc839@mail.gmail.com>
Subject: Re: Ethernet issues with lite5200 board from linux-2.6.31
To: Yogesh Chaudhari <mr.yogesh@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robin Gareus <robin@gareus.org>, rt-users <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Mark Knecht <markknecht@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Clark Williams <williams@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Jon Masters <jcm@redhat.com>, John Kacur <jkacur@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Jan Blunck <jblunck@suse.de>,
	Gregory Haskins <ghaskins@novell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 30, 2009 at 2:50 AM, Yogesh Chaudhari <mr.yogesh@gmail.com> wro=
te:
> Hello,
> =A0 =A0 =A0 =A0 I am running linux kernel with rt patch on embedded board
> based on lite5200 eval board. From linux-2.6.31 release, in which the
> mdio patch has gone inside, =A0the fec ethernet does not come up on this
> board. I get the following message at startup:
> mpc52xx MII bus: probed
> mdio_bus f0003000: error probing PHY at address 1
>
>
> After the bootup if I try to do a ifconfig I get the message:
> net eth2: of_phy_connect failed
>
>
> If I change the value of reg in dts file (lite5200.dts) to 0 then this
> ethernet comes up. However upto this kernel version, this was not
> required.
>
> Ethernet does not come up on board with original lite5200.dts file

Is your board based on the Lite5200 or the Lite5200B?  The phys are at
different addresses on those two revisions of the board.  There is a
different .dts file for each board.

> phy0: ethernet-phy@1 {
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D=
 <1>;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> Ethernet comes up on board with this change
> phy0: ethernet-phy@1 {
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D=
 <0>;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};

Some PHYs treat address 0 as the 'broadcast' address.  You need to
fill in this field (and modify the ethernet-phy@<address> node name)
to reflect the address that your phy is actually at.

g.
