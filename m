Message-ID: <40C80EA6.1060005@fh-landshut.de>
Date: Thu, 10 Jun 2004 09:32:54 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: VME - PowerPC: Resource sizes
References: <DB1DE297F535B340AEAE1E51B221C3D007E84017@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D007E84017@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Heater, Daniel (GE Infrastructure) wrote:

>>I don't know about x86 bus organization, but maybe it limits
>>the address
>>range for available addresses too strongly (on a single bus,
>>where the
>>Universe is on). Comparing how much window space you can map with the
>>old version and the new one on x86 could prove useful.
>>
>>
>
>Your dead on right. I cannot allocate as much space. In fact,
>on a VMIVME-7750 I'm only able to allocate 768KB now vs. the
>~2MB I could access before.
>
>
Since we only request the current bus the Universe is on, there could be
a fix:
We could iterate the PCI bus tree to the top (there is some parent bus
field, IIRC), and then start complete iteration until a suitable
resource is found. This may produce larger resource regions with
reasonable effort.

Are you sure you mean 768 _KB_ and 2 _MB_, not 768 _MB_ and 2 _GB_? My
SLSI window is already 64 MB big, and with the PCI layout on my MVME2100
it is imaginable that I could map 84000000 - BEFFFFFF = 944MB (from end
of SLSI window to start of the Universe I/O memory)?

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
