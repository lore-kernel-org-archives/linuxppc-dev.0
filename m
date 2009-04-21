Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BEB2DE0E4
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 08:50:54 +1000 (EST)
Message-Id: <46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PCI changes 2.6.26 => 2.6.28
Date: Tue, 21 Apr 2009 17:50:47 -0500
References: <49EDF333.4000200@mlbassoc.com>
	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>
	<49EE306D.3000401@mlbassoc.com> <49EE4729.3000100@mlbassoc.com>
	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I'm still looking into how the PCI address register for the video
>>> card did not get written, even though the system obviously thinks
>>> it did (hence "virtual")
>>>
>>
>> It most definitely has something to do with 0xC0000000 being
>> assigned to the video card.  I changed my DTS to move everything
>> up (started the whole space at 0xC4000000) and the video card
>> came to life!  Of course, I'm not interested in this hack,
>> so the simplest thing would be to figure out why 2.6.26 allocated
>> that outgoing window and 2.6.28 doesn't
>
> So I think the difference is due to the change in PCI code between  
> 2.6.26 and .28 for 83xx.  If you notice we exclude the FSL device  
> in .26 you have:
>
>>> c0000000-c7ffffff : 0000:00:00.0
>
> and in .28 its gone.  This accounts for the allocation differences.   
> What I don't get is why the behavior would vary based on address.
>
> Can you dump out the PCI inbound/outbound registers.  I have a  
> theory as to what's going on and want to confirm it.

Also, what's your .dts look like for the PCI node.

- k
