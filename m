Message-ID: <40C87A07.4050105@fh-landshut.de>
Date: Thu, 10 Jun 2004 17:11:03 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: VME - PowerPC: Resource sizes
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DE3@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D0016B3DE3@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Heater, Daniel (GE Infrastructure) wrote:

>>We could iterate the PCI bus tree to the top (there is some
>>parent bus
>>field, IIRC), and then start complete iteration until a suitable
>>resource is found. This may produce larger resource regions with
>>reasonable effort.
>>
>>
>
>On the x86 boards we've dealt with we've gotten away with opening
>VMEbus windows in PCI space not allocated by the Universe's parent
>bridge because the parent bridges have always been set up for
>subtractive decoding. So if no one else claimed the cycle, it got
>passed down through the bridge to the Universe anyway.
>
>
>>Are you sure you mean 768 _KB_ and 2 _MB_, not 768 _MB_ and 2
>>_GB_? My SLSI window is already 64 MB big.
>>
>>
>
>My bad. It's actually 768KB and 2GB are correct. The SLSI window
>does fail to allocate with the patch.
>
>
That's not very good. I'm getting an Intel board (I guess VMIVME7700) In
the near future, so I could test several options. If my code does
prevent you from getting resonable window sizes, we could either walk
the tree, or conditionalize the code that way, that for the x86 resource
are again requested from iomem_resource directly.

But I guess that walking the tree should have a net result very similar
to your original code.

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
