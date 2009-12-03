Return-Path: <mr.yogesh@gmail.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 850D6B7C05
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 15:14:28 +1100 (EST)
Received: by iwn11 with SMTP id 11so660652iwn.17
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Dec 2009 20:14:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40911300759h153b3300uc54b5d1871bfc839@mail.gmail.com>
References: <d1f76ba30911300038w272578dfx9adb116bde493e00@mail.gmail.com>
	<d1f76ba30911300150g10c1382clb2958245ebf94362@mail.gmail.com>
	<fa686aa40911300759h153b3300uc54b5d1871bfc839@mail.gmail.com>
From: Yogesh Chaudhari <mr.yogesh@gmail.com>
Date: Thu, 3 Dec 2009 09:44:04 +0530
Message-ID: <d1f76ba30912022014y1f688827qe8145a7d40de5321@mail.gmail.com>
Subject: Re: Ethernet issues with lite5200 board from linux-2.6.31
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robin Gareus <robin@gareus.org>, rt-users <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Mark Knecht <markknecht@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Clark Williams <williams@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Jon Masters <jcm@redhat.com>, John Kacur <jkacur@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Jan Blunck <jblunck@suse.de>,
	Gregory Haskins <ghaskins@novell.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/11/30 Grant Likely <grant.likely@secretlab.ca>:
> On Mon, Nov 30, 2009 at 2:50 AM, Yogesh Chaudhari <mr.yogesh@gmail.com> w=
rote:
>> Hello,
>> =A0 =A0 =A0 =A0 I am running linux kernel with rt patch on embedded boar=
d
>> based on lite5200 eval board. From linux-2.6.31 release, in which the
>> mdio patch has gone inside, =A0the fec ethernet does not come up on this
>> board. I get the following message at startup:
>> mpc52xx MII bus: probed
>> mdio_bus f0003000: error probing PHY at address 1
>>
>>
>> After the bootup if I try to do a ifconfig I get the message:
>> net eth2: of_phy_connect failed
>>
>>
>> If I change the value of reg in dts file (lite5200.dts) to 0 then this
>> ethernet comes up. However upto this kernel version, this was not
>> required.
>>
>> Ethernet does not come up on board with original lite5200.dts file
>
> Is your board based on the Lite5200 or the Lite5200B? =A0The phys are at
> different addresses on those two revisions of the board. =A0There is a
> different .dts file for each board.
>
>> phy0: ethernet-phy@1 {
>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =
=3D <1>;
>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>>
>> Ethernet comes up on board with this change
>> phy0: ethernet-phy@1 {
>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =
=3D <0>;
>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> Some PHYs treat address 0 as the 'broadcast' address. =A0You need to
> fill in this field (and modify the ethernet-phy@<address> node name)
> to reflect the address that your phy is actually at.
>
> g.
>
 I have tried the same with the latest kernel both with and without
rt, but with the same end result. I have checked that the mpc52xx fec
driver was changed from 2.6.31 version but I am not able to point
where this error is coming up from and how changing the reg value in
dts (which is not required till previous versions) is solving this.
