Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id A75EADE1BF
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 02:57:04 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so2634316rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 09:57:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090415164417.E85B41600050@mail201-sin.bigfish.com>
References: <20090414200834.D05446F8056@mail163-wa4.bigfish.com>
	<fa686aa40904150814p40813d25w9d04f7e88897a88@mail.gmail.com>
	<20090415155837.139A119C0056@mail32-dub.bigfish.com>
	<fa686aa40904150903r584a3fd6wb75d4f9f606873dc@mail.gmail.com>
	<20090415164417.E85B41600050@mail201-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Apr 2009 10:56:47 -0600
Message-ID: <fa686aa40904150956i74fd23b3n9edd112c8029bd8e@mail.gmail.com>
Subject: Re: [PATCH] [V3] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel Garapati <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	John Linn <linnj@xilinx.com>, akonovalov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 10:44 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>
>> -----Original Message-----
>> From: Grant Likely [mailto:grant.likely@secretlab.ca]
>> Sent: Wednesday, April 15, 2009 9:03 AM
>> To: Stephen Neuendorffer
>> Cc: John Linn; jwboyer@linux.vnet.ibm.com; linux-fbdev-devel@lists.sourc=
eforge.net; linuxppc-
>> dev@ozlabs.org; akonovalov@ru.mvista.com; adaplas@gmail.com; Suneel Gara=
pati
>> Subject: Re: [PATCH] [V3] Xilinx : Framebuffer Driver: Add PLB support a=
nd cleanup DCR
>>
>> On Wed, Apr 15, 2009 at 9:58 AM, Stephen Neuendorffer
>> <stephen.neuendorffer@xilinx.com> wrote:
>> >> > - =A0 =A0 =A0 rc =3D of_address_to_resource(op->node, 0, &res);
>> >> > - =A0 =A0 =A0 if (rc) {
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid address\n"=
);
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
>> >> > + =A0 =A0 =A0 /*
>> >> > + =A0 =A0 =A0 =A0* To check whether the core is connected directly =
to DCR or PLB
>> >> > + =A0 =A0 =A0 =A0* interface and initialize the tft_access accordin=
gly.
>> >> > + =A0 =A0 =A0 =A0*/
>> >> > + =A0 =A0 =A0 p =3D (u32 *)of_get_property(op->node, "xlnx,dcr-splb=
-slave-if", NULL);
>> >>
>> >> Hmmm. =A0This binding is undocumented. =A0It would be better to make =
the
>> >> decision on the presence/absence of the dcr-reg and/or reg properties=
.
>> >
>> > For backward compatibility with the 'old' way, the device tree generat=
or for this core has both
>> dcr-reg and reg properties (where the reg has been translated back throu=
gh the bridge).
>>
>> So, what is in the regs and dcr-regs properties when DCR is used?
>>
>> How about when MMIO is used?
>>
>
> Currently:
> Core has DCR access, connected DCR bus:
> =A0 =A0 =A0 =A0device tree contains dcr-reg property.
> Core has DCR access, accessed through plb->dcr bridge:
> =A0 =A0 =A0 =A0device tree contains dcr-reg property, AND for backward co=
mpatibility with the
> =A0 =A0 =A0 =A0old driver, a reg property which contains the apparent reg=
isters on the bus.
> Core has PLB access:
> =A0 =A0 =A0 =A0device tree contains reg property only.
>
> So, I guess it really doesn't matter... The only interesting case is the =
second one where (because the way the reg property is published), either me=
thod will work... =A0So, nevermind, the device tree question is completely =
independent and I agree with your comment that there's probably not a need =
for a separate binding.
>
> What I do think would be nice (at some point in the future maybe) is perh=
aps a bit of DCR_or_PLB abstraction for this core and the ll_temac driver t=
o share which would avoid duplicating the code in each driver as to whether=
 it uses DCR or PLB access...

Good idea.

g.

>
> Steve
>
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
