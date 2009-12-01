Return-Path: <mr.yogesh@gmail.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id A034CB7BCA
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 16:48:57 +1100 (EST)
Received: by iwn11 with SMTP id 11so2802364iwn.17
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 21:48:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40911300759h153b3300uc54b5d1871bfc839@mail.gmail.com>
References: <d1f76ba30911300038w272578dfx9adb116bde493e00@mail.gmail.com>
	<d1f76ba30911300150g10c1382clb2958245ebf94362@mail.gmail.com>
	<fa686aa40911300759h153b3300uc54b5d1871bfc839@mail.gmail.com>
From: Yogesh Chaudhari <mr.yogesh@gmail.com>
Date: Tue, 1 Dec 2009 11:18:36 +0530
Message-ID: <d1f76ba30911302148q60a9aea3s421f4d40081315f7@mail.gmail.com>
Subject: Re: Ethernet issues with lite5200 board from linux-2.6.31
To: Grant Likely <grant.likely@secretlab.ca>
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

Hello Grant,

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

This change in reg value was not required till 2.6.31. It is only
after this version that the change is needed. Is there some change in
31 that makes this change mandatory?

>
> g.
>



--=20
DREAM IT, CODE IT

"CODITO, ERGO SUM"
"I CODE, THEREFORE I AM"
