Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 93C78DE067
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 09:00:55 +1000 (EST)
Message-ID: <49EE5021.4020703@mlbassoc.com>
Date: Tue, 21 Apr 2009 17:00:49 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI changes 2.6.26 => 2.6.28
References: <49EDF333.4000200@mlbassoc.com>	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>	<49EE306D.3000401@mlbassoc.com>
	<49EE4729.3000100@mlbassoc.com>	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>
	<46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>
In-Reply-To: <46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>
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

Kumar Gala wrote:
>>>> I'm still looking into how the PCI address register for the video
>>>> card did not get written, even though the system obviously thinks
>>>> it did (hence "virtual")
>>>>
>>>
>>> It most definitely has something to do with 0xC0000000 being
>>> assigned to the video card.  I changed my DTS to move everything
>>> up (started the whole space at 0xC4000000) and the video card
>>> came to life!  Of course, I'm not interested in this hack,
>>> so the simplest thing would be to figure out why 2.6.26 allocated
>>> that outgoing window and 2.6.28 doesn't
>>
>> So I think the difference is due to the change in PCI code between
>> 2.6.26 and .28 for 83xx.  If you notice we exclude the FSL device in
>> .26 you have:
>>
>>>> c0000000-c7ffffff : 0000:00:00.0
>>
>> and in .28 its gone.  This accounts for the allocation differences. 
>> What I don't get is why the behavior would vary based on address.
>>
>> Can you dump out the PCI inbound/outbound registers.  I have a theory
>> as to what's going on and want to confirm it.

I found the difference - in 2.6.28 the inbound/outbound windows
don't seem to be set up at all.  In 2.6.26, the function 'fsl_add_bridge'
was common among architectures and ended up calling 'setup_pci_atmu'
which created those mappings.  In 2.6.28, the 83xx PCI setup code
has been refactored.  It uses 'mpc83xx_add_bridge' instead of
'fsl_add_bridge' and 'setup_pci_atmu' is not called at all :-(

I'm sure this is the problem.

> Also, what's your .dts look like for the PCI node.

For the record:
		bus-range = <0 0>;
		ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x10000000
			  0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
