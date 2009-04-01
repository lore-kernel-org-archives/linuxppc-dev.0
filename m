Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 62A67DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 23:40:16 +1100 (EST)
Received: by gxk1 with SMTP id 1so53275gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Apr 2009 05:40:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49D3197C.7000806@grandegger.com>
References: <49C26434.30302@grandegger.com>
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
	<49D1E3E5.3080607@grandegger.com>
	<fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>
	<49D21C75.7060307@grandegger.com>
	<fa686aa40903310805k794b9df0s4d21a8080907a767@mail.gmail.com>
	<20090331155443.GA28242@oksana.dev.rtsoft.ru>
	<49D3197C.7000806@grandegger.com>
Date: Wed, 1 Apr 2009 06:40:14 -0600
Message-ID: <fa686aa40904010540h53c8975ao196657f6fdd66583@mail.gmail.com>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 1, 2009 at 1:36 AM, Wolfgang Grandegger <wg@grandegger.com> wro=
te:
> Anton Vorontsov wrote:
>> On Tue, Mar 31, 2009 at 09:05:28AM -0600, Grant Likely wrote:
>> [...]
>>>>>>>> + =A0 =A0 =A0 soc8544@e0000000 {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "soc";
>>>>>>> Drop device_type here too.
>>>>>> Grrr, I just realized that removing the devices type "soc" has broke=
n
>>>>>> fsl_get_sys_freq(). See:
>>>>>>
>>>>>> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80
>>>>>>
>>>>>> We need a quick fix and we could take the occasion to establish a co=
mmon
>>>>>> function for the MPC52xx as well, but it's not obvious to me how to =
find
>>>>>> the SOC node without the device type property.
>>>>> SoC node should have a compatible property, just like everything else=
.
>>>>>
>>>>> compatible =3D "fsl,mpc8544-immr"; =A0(immr =3D=3D Internally Memory =
Mapped Registers)
>>>>>
>>>>> Many other boards already do this.
>>>> Yes, it does, but searching for the SOC node is not straight-forward
>>>> because there is no common compatibility string but many CPU-specific
>>>> compatibility strings, e.g. "fsl,mpc8560-immr", etc. Have I missed
>>>> something?
>>> Choose a new value ("fsl,mpc-immr" perhaps?), document exactly what it
>>> means, and add add it to the end of the compatible list.
>>
>> As Scott Wood once pointed out, IMMR does not exists for MPC85xx
>> parts. There it's called CCSR.
>>
>> See this thread:
>>
>> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg12665.html
>>
>> I still think that
>> "fsl,mpc83NN-immr", "fsl,soc", "simple-bus" for 83xx
>> and
>> "fsl,mpc85NN-ccsr", "fsl,soc", "simple-bus" for 85xx
>>
>> would be OK, at least to start with. We can always deprecate "fsl,soc"
>> compatible in favour of something more elegant, but "fsl,soc" should be
>> just fine to replace device_type =3D "soc".
>>
>> Also, there is another good thing about "fsl,soc" -- U-Boot already
>> finds it for 83xx CPUs. ;-)
>
> Ugh! I just realize the full impact of removing device type "soc". It
> will break compatibility with U-Boot for many boards. Is it worth it?

Yes, I know this.  I'm not asking you to fix all the other boards, but
make sure that it is not required for the new board.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
