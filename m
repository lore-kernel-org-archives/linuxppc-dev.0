From: Benjamin Herrenschmidt <bh40@calva.net>
To: <paulus@linuxcare.com.au>,
        Linux/PowerPC Devel List
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Date: Tue, 17 Oct 2000 12:41:36 +0200
Message-Id: <19340911041320.23766@192.168.1.2>
In-Reply-To: <14827.39263.212734.807452@argo.linuxcare.com.au>
References: <14827.39263.212734.807452@argo.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> > Unfortunately, there's no simple way to allow two busses to have the
>> > legacy IOs. That means on UniN machines that they'll be available either
>> > on the AGP bus, or the external PCI bus, but not both.
>>
>> Indeed, this is too awkward (is tere no way to redirect only the VGA
>> part of the legacy I/O space ? That's what the PCI-PCI bridges do, but
>> I've not yet used a single machine with AGP so I'm ignorant).
>
>Could someone fill me in on why we need legacy I/O to the AGP bus?

Some display cards (like voodoo) AFAIK, need us to tweak with the VGA IO
registers. The interest in having something like ioportremap or similar
is that we can have the platform specific code return a different base
for VGA than other legacy devices, thus allowing us to have, for example,
such a VGA card in the AGP slot and a legacy serial card in the PCI slots.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
