Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 71A95DDDA1
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 18:36:31 +1100 (EST)
Message-ID: <49D3197C.7000806@grandegger.com>
Date: Wed, 01 Apr 2009 09:36:28 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
	<49D1E3E5.3080607@grandegger.com>
	<fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>
	<49D21C75.7060307@grandegger.com>
	<fa686aa40903310805k794b9df0s4d21a8080907a767@mail.gmail.com>
	<20090331155443.GA28242@oksana.dev.rtsoft.ru>
In-Reply-To: <20090331155443.GA28242@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Tue, Mar 31, 2009 at 09:05:28AM -0600, Grant Likely wrote:
> [...]
>>>>>>> +       soc8544@e0000000 {
>>>>>>> +               #address-cells = <1>;
>>>>>>> +               #size-cells = <1>;
>>>>>>> +               device_type = "soc";
>>>>>> Drop device_type here too.
>>>>> Grrr, I just realized that removing the devices type "soc" has broken
>>>>> fsl_get_sys_freq(). See:
>>>>>
>>>>> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80
>>>>>
>>>>> We need a quick fix and we could take the occasion to establish a common
>>>>> function for the MPC52xx as well, but it's not obvious to me how to find
>>>>> the SOC node without the device type property.
>>>> SoC node should have a compatible property, just like everything else.
>>>>
>>>> compatible = "fsl,mpc8544-immr";  (immr == Internally Memory Mapped Registers)
>>>>
>>>> Many other boards already do this.
>>> Yes, it does, but searching for the SOC node is not straight-forward
>>> because there is no common compatibility string but many CPU-specific
>>> compatibility strings, e.g. "fsl,mpc8560-immr", etc. Have I missed
>>> something?
>> Choose a new value ("fsl,mpc-immr" perhaps?), document exactly what it
>> means, and add add it to the end of the compatible list.
> 
> As Scott Wood once pointed out, IMMR does not exists for MPC85xx
> parts. There it's called CCSR.
> 
> See this thread:
> 
> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg12665.html
> 
> I still think that
> "fsl,mpc83NN-immr", "fsl,soc", "simple-bus" for 83xx
> and
> "fsl,mpc85NN-ccsr", "fsl,soc", "simple-bus" for 85xx
> 
> would be OK, at least to start with. We can always deprecate "fsl,soc"
> compatible in favour of something more elegant, but "fsl,soc" should be
> just fine to replace device_type = "soc".
> 
> Also, there is another good thing about "fsl,soc" -- U-Boot already
> finds it for 83xx CPUs. ;-)

Ugh! I just realize the full impact of removing device type "soc". It
will break compatibility with U-Boot for many boards. Is it worth it?

Wolfgang.
