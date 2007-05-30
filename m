Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E15BDE042
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:49:24 +1000 (EST)
In-Reply-To: <19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
	<A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
	<1180503967.12577.20.camel@localhost.localdomain>
	<19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <976AFF56-7590-46B9-ADCA-4FA6673D4C9B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
Date: Wed, 30 May 2007 08:49:12 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> I'm not terrible happy with blindly writing to rstcr.
>>>>>
>>>> I can understand you.
>>>> But I jut want to make things simple and workable.
>>>> Any idea?
>>>
>>> one idea would be for us to add a property on the soc node.
>>> Something like has-rstcr or something similar in a guts node?
>> I have seen your suggestion before to add a property in device tree.
>> But I still think the current implementation is simple.
>
> While it simple you are depending on the fact that a given
> implementation may or may not have something at the particular
> offset.  Who knows if 8599 or some future part could put the 'cause
> my part to smoke and self-destruct' at the same offset in the  
> future :)
>
>> Anyway, I can try your suggestion.
>
> I'm thinking have a guts block and putting a property in it makes the
> most sense.

After some discussion on IRC I think the following is the suggested  
node we should add in.

guts@e00000 {
	compatible = "fsl,mpc8548-guts";
	reg = <e00000 1000>;
	fsl,has-rstcr;
};

- k
