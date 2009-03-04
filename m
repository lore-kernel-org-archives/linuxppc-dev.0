Return-Path: <pku.leo@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id BF61FDDF71
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 14:10:32 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1703096yxb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Mar 2009 19:10:30 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090303193833.GA8941@oksana.dev.rtsoft.ru>
References: <20090303160201.GA3242@oksana.dev.rtsoft.ru>
	<20090303175746.GC8692@ld0162-tx32.am.freescale.net>
	<20090303183407.GA27678@oksana.dev.rtsoft.ru>
	<49AD796A.90601@freescale.com>
	<20090303193833.GA8941@oksana.dev.rtsoft.ru>
Date: Wed, 4 Mar 2009 11:10:30 +0800
Message-ID: <2a27d3730903031910r14de8b2ek7930ccbe8a6a92a2@mail.gmail.com>
Subject: Re: [PATCH RFC] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
From: Li Yang <leoli@freescale.com>
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 4, 2009 at 3:38 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Currently it doesn't matter where the mdio nodes are placed, but with
> power management support (i.e. when sleep =3D <> properties will take
> effect), mdio nodes placement will become important: mdio controller
> is a part of the ethernet block, so the mdio nodes should be placed
> correctly. Otherwise we may wrongly assume that MDIO controllers are
> available during sleep.
>
> Suggested-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> On Tue, Mar 03, 2009 at 12:39:38PM -0600, Scott Wood wrote:
>> Anton Vorontsov wrote:
>>> On Tue, Mar 03, 2009 at 11:57:46AM -0600, Scott Wood wrote:
>>>> On Tue, Mar 03, 2009 at 07:02:01PM +0300, Anton Vorontsov wrote:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mdio@24520 {
>>>>> @@ -226,6 +244,8 @@
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
interrupt-parent =3D <&ipic>;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
tbi-handle =3D <&tbi0>;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
phy-handle =3D <&phy2>;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep=
 =3D <&pmc 0xc0000000>;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsl,m=
agic-packet;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>>>> Note that this makes it look to the kernel like enet0 can be put to sl=
eep
>>>> without putting the mdio (which is shared with enet1) to sleep. =C2=A0=
This is
>>>> why I moved mdio under the ethernet node on 8313erdb.
>>>
>>> And that isn't absolutely correct either, since enet1 depends on
>>> net0... If enet0's mdio goes into sleep mode before enet1, then
>>> enet1 will fail to send power-down command to its PHY...
>>
>> But the kernel knows that enet1 depends on mdio0. =C2=A0Getting the kern=
el to
>> act on that knowledge isn't the device tree's problem.
>
> Well, that makes sense. I'd like to move mdio nodes in a separate
> patch though, since the original patch becomes difficult to review
> because of too many changes...
>
> A question though... do we want real addr translation via ranges, or
> the dummy "ranges;" are OK?
>
> Here is the RFC. It's tested to work on MPC8377-RDB.

Last time I brought up a similar issue with a MPC8313 patch.  Looks
like the consensus is that we shouldn't use compatible =3D "simple-bus"
for gianfar nodes.

- Leo
