Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8CE35DDED4
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:36:55 +1100 (EST)
Message-ID: <49D21C75.7060307@grandegger.com>
Date: Tue, 31 Mar 2009 15:36:53 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>	
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>	
	<49D1E3E5.3080607@grandegger.com>
	<fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>
In-Reply-To: <fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>
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

Grant Likely wrote:
> On Tue, Mar 31, 2009 at 3:35 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Grant Likely wrote:
>>> I agree 100% with David's comments, and I have some additional ones below.
>>>
>>> On Thu, Mar 19, 2009 at 9:26 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>>> +       soc8544@e0000000 {
>>>> +               #address-cells = <1>;
>>>> +               #size-cells = <1>;
>>>> +               device_type = "soc";
>>> Drop device_type here too.
>> Grrr, I just realized that removing the devices type "soc" has broken
>> fsl_get_sys_freq(). See:
>>
>> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80
>>
>> We need a quick fix and we could take the occasion to establish a common
>> function for the MPC52xx as well, but it's not obvious to me how to find
>> the SOC node without the device type property.
> 
> SoC node should have a compatible property, just like everything else.
> 
> compatible = "fsl,mpc8544-immr";  (immr == Internally Memory Mapped Registers)
> 
> Many other boards already do this.

Yes, it does, but searching for the SOC node is not straight-forward
because there is no common compatibility string but many CPU-specific
compatibility strings, e.g. "fsl,mpc8560-immr", etc. Have I missed
something?

Unfortunately, other 85xx functions search for the device type "soc" as
well. Therefore I think we must keep the devices type "soc" for the time
being. Kumar?

Wolfgang.
