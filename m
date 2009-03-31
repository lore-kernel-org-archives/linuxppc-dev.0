Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 42B8ADDED6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 02:05:30 +1100 (EST)
Received: by gxk1 with SMTP id 1so9294547gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 08:05:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49D21C75.7060307@grandegger.com>
References: <49C26434.30302@grandegger.com>
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
	<49D1E3E5.3080607@grandegger.com>
	<fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>
	<49D21C75.7060307@grandegger.com>
Date: Tue, 31 Mar 2009 09:05:28 -0600
Message-ID: <fa686aa40903310805k794b9df0s4d21a8080907a767@mail.gmail.com>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
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

On Tue, Mar 31, 2009 at 7:36 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Grant Likely wrote:
>> On Tue, Mar 31, 2009 at 3:35 AM, Wolfgang Grandegger <wg@grandegger.com>=
 wrote:
>>> Grant Likely wrote:
>>>> I agree 100% with David's comments, and I have some additional ones be=
low.
>>>>
>>>> On Thu, Mar 19, 2009 at 9:26 AM, Wolfgang Grandegger <wg@grandegger.co=
m> wrote:
>>>>> + =A0 =A0 =A0 soc8544@e0000000 {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "soc";
>>>> Drop device_type here too.
>>> Grrr, I just realized that removing the devices type "soc" has broken
>>> fsl_get_sys_freq(). See:
>>>
>>> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80
>>>
>>> We need a quick fix and we could take the occasion to establish a commo=
n
>>> function for the MPC52xx as well, but it's not obvious to me how to fin=
d
>>> the SOC node without the device type property.
>>
>> SoC node should have a compatible property, just like everything else.
>>
>> compatible =3D "fsl,mpc8544-immr"; =A0(immr =3D=3D Internally Memory Map=
ped Registers)
>>
>> Many other boards already do this.
>
> Yes, it does, but searching for the SOC node is not straight-forward
> because there is no common compatibility string but many CPU-specific
> compatibility strings, e.g. "fsl,mpc8560-immr", etc. Have I missed
> something?

Choose a new value ("fsl,mpc-immr" perhaps?), document exactly what it
means, and add add it to the end of the compatible list.

> Unfortunately, other 85xx functions search for the device type "soc" as
> well. Therefore I think we must keep the devices type "soc" for the time
> being. Kumar?

Fix them!  :-)

Most troublesome places are where of_find_node_by_type() is used (I
see two cases in fsl_soc.c).  I added the of_find_matching_node()
function specifically to rework code that was only matching on a
single compatible or type value.  See usage of mpc52xx_bus_ids in
arch/powerpc/platforms/52xx/mpc52xx_common.c for an example.

It is a pain, but I think it is important to be reducing device_type
usage as we hit against them.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
