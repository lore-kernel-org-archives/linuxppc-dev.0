Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 4AE4C67A79
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 09:24:48 +1100 (EST)
Message-ID: <42239A2D.8070205@mvista.com>
Date: Mon, 28 Feb 2005 15:24:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: James Chapman <jchapman@katalix.com>
References: <42235B0A.3070302@katalix.com> <422384CA.6090004@mvista.com>
	<4223977C.4070502@katalix.com>
In-Reply-To: <4223977C.4070502@katalix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.11-rc4] ppc: add support for Radstone ppc7d boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

James Chapman wrote:

> Mark A. Greer wrote:
>
>>  > +       /* Setup P2P for PCI#0 */
>>  > +       val32 = mv64x60_read(&bh, MV64x60_PCI0_P2P_CONFIG);
>>  > +       val32 &= ~(0x00ffffff);
>>  > +       val32 |= ((bh.hose_a->first_busno & 0xff) << 16);
>> etc.
>>
>> Do you really use the P2P bridge?  Unless I missed something, I think 
>> it remains disabled.  You shouldn't need it unless you have PCI 
>> devices on one hose directly accessing PCI devices on the other 
>> hose.  The P2P stuff seems complicated & unnecessary.
>
>
> Thinking about this more, what is really being configured here is the
> primary bus number before the scan is performed. If the bus number
> doesn't match the hose's primary bus number, the mv64x60 will issue
> Type 2 PCI config cycles instead of Type 1 and the scan will fail.
>
> This board has an on-board PCI-X bridge and potentially other PCI
> bridges on PMC cards. I found that I had to init the P2P_CONFIG
> primary bus value before scan in order for the PCI scan of bus 2
> to work (hose_a has PCI busses 0 and 1).
>
> I think the writes to the P2P config registers are necessary.


mv64x60_set_bus() is supposed to do that.  Try doing your bus numbering 
setup/bus scanning like what's in ev64260.c.  If there is still a 
deficiency, then we should fix up that routine.

Mark
