Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9EF11A02E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 19:26:22 +1000 (EST)
Message-ID: <53A15B38.3080807@xenosoft.de>
Date: Wed, 18 Jun 2014 11:26:16 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Olof Johansson <olof@lixom.net>
Subject: Kernel 3.15: Boot problems with a PA6T board
References: <5366649E.4030102@xenosoft.de>				
 <1399268891.4600.3.camel@concordia> <53720AAC.1000100@xenosoft.de>			
 <1401107166.23096.1.camel@concordia> <53851AFA.5040504@xenosoft.de>		
 <1401251015.5468.5.camel@concordia> <5385A3F4.8070004@xenosoft.de>		
 <5385C7A3.1080508@xenosoft.de> <1401331711.4930.7.camel@concordia>	
 <5389AEB6.4030500@xenosoft.de> <5389B686.7070305@xenosoft.de>	
 <538A58D4.5090602@xenosoft.de> <5396E4D6.60306@xenosoft.de>	
 <5397060F.9010308@xenosoft.de> <1403074303.32307.5.camel@concordia>
 <53A15492.3090604@xenosoft.de>
In-Reply-To: <53A15492.3090604@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 18.06.14 10:57, schrieb Christian Zigotzky:
> Am 18.06.14 08:51, schrieb Michael Ellerman:
>> On Tue, 2014-06-10 at 15:20 +0200, Christian Zigotzky wrote:
>>> Hi All,
>>>
>>> Could you help me to remove the changes of the PCI code, please? Or
>>> which patches shall I remove to get the old PCI code?
>> Hi Christian,
>>
>> Thanks for doing the bisect. It wasn't clear why that change was 
>> causing your
>> issue, so I guess we're a bit stuck.
>>
>> Olof (on CC), was going to try and look at it when he got some spare 
>> time.
>> Please keep him on CC.
>>
>> cheers
>>
>>
>>
> Hi Michael,
>
> Thank you for your answer. Adrian told me the reason about this issue.
>
> Quote Adrian:
>
> As I recall, PCI resource allocation on Nemo was always a little 
> strange due to using an AMD south bridge together with the PA6T north 
> bridge. The south bridge does not behave as a standard PCIe device, 
> but instead presents itself as multiple devices on the PCIe root bus. 
> This is not compliant with the PCIe specification. We modified the 
> core powerpc PCI code so that Nemo could boot, but the changes to PCI 
> code in 3.15 have broken the old workaround. I don't understand the 
> PCI changes in 3.15 enough to comment further at this point.
>
> Regards,
> Adrian
>
> Quote end
>
> Cheers,
>
> Christian
But my opinion is, that's normal for the SB600 south bridge to presents 
itself as multiple devices on the PCIe bus on x86 PCs. I see a lot of 
PCs with SB600 south bridge on the internet. And the Linux kernel works 
with this south bridge. Or is it a powerpc issue?

- Christian
