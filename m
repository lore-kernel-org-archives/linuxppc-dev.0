Message-ID: <3E74DD59.7090804@elitedvb.net>
Date: Sun, 16 Mar 2003 21:23:53 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE corruption w/ 48 Bit addressing
References: <3E74C280.3000608@elitedvb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Users report harddisk corruption, and a quick test showed, that data
> written to 0x1800000000+x (LBA sector 0xC000000+x/512) is also written
> to x. (direct O_LARGEFILE-access to /dev/discs0/disc).
OK, update, this was a bit misleading:

when reading from the device, the upper 3 bytes aren't updated in the
right way, so the "previous content" (as specified in the ATA/6 specs)
seem to be invalid and contain, well, wrong content.

felix


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
