In-Reply-To: <409108FE.70500@nortelnetworks.com>
References: <408FEBB6.105@nortelnetworks.com> <1083191370.21436.81.camel@gaston> <409108FE.70500@nortelnetworks.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B77CD81E-99EE-11D8-B5B8-000393A47A5C@lanl.gov>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Greg Watson <gwatson@lanl.gov>
Subject: Re: confused about HID1 bits and G5
Date: Thu, 29 Apr 2004 09:05:56 -0600
To: Chris Friesen <cfriesen@nortelnetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As a firmware designed (LinuxBIOS), I would support this. Obviously
there are some things that the firmware has to do, like enable memory,
but the less reliance the o/s has on magic behavior the better. It
makes firmware design simpler and more reliable.

Greg

On 29/04/2004, at 7:54 AM, Chris Friesen wrote:

>
> Benjamin Herrenschmidt wrote:
>>> It appears that we're relying on the firmware to set up a lot of the
>>> bits in this register--is there
>>> any reason we aren't forcing particular values?
>>
>>
>> Forcing values in HIDs is BAD. The firmware may set/clear bits to work
>> around specific CPU or north bridge bugs for example. That's why I
>> need
>> to change the code that force-clear HID4/5 one of these days too and
>> instead just clear the bits I want to be cleared.
>
> I'm just thinking of stuff that should really be set, like enabling
> the icache or the branch history
> table.  Do we really want to rely on firmware to do that? [1]
>
> Currently there are a bunch of bits in HID1 that are not specifically
> set in the linux code.  I
> think they should be set, but I have no way of actually checking the
> value since I'm running in
> 32-bit mode. [2]
>
> Chris
>
>
>
>
> 1. We've seen at least one firmware that didn't do this for some 74xx
> hardware.  Drove us nuts
> trying to figure out why performance wasn't meeting projections.
>
> 2. I'm trying to get a 64-bit toolchain built, but the gcc doesn't
> build when I follow the
> instructions on linuxppc64.org.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
