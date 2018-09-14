Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BpBw0ntZzF31p
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 07:12:55 +1000 (AEST)
Subject: Re: [PATCH v2 5/5] PCI/powerpc/eeh: Add pcibios hooks for preparing
 to rescan
To: <benh@au1.ibm.com>
CC: Sam Bobroff <sbobroff@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux@yadro.com>
References: <20180906115752.29316-1-s.miroshnichenko@yadro.com>
 <20180906115752.29316-6-s.miroshnichenko@yadro.com>
 <20180910050328.GC14370@tungsten.ozlabs.ibm.com>
 <61e8e5b9-0ed2-1848-d676-64bcbd3b9cbc@yadro.com>
 <baf90fe99f3644b33d50966b5721991a84369a7d.camel@au1.ibm.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Message-ID: <6ae5e29d-8fdc-3b43-79eb-b0472588b49f@yadro.com>
Date: Sat, 15 Sep 2018 00:12:50 +0300
MIME-Version: 1.0
In-Reply-To: <baf90fe99f3644b33d50966b5721991a84369a7d.camel@au1.ibm.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 9/12/18 1:39 PM,  wrote:
> On Mon, 2018-09-10 at 19:00 +0300, Sergey Miroshnichenko wrote:
>>
>> Yes, missing a real EEH event is possible, unfortunately, and it is
>> indeed worth mentioning.
>>
>> To reduce this probability the next patchset I'll post in a few days
>> among other things puts all the affected device drivers to pause during
>> rescan, mainly because of moving BARs and bridge windows, but it will
>> also help here a bit.
> 
> How do you deal with moving BARs etc... within the segmenting
> restrictions of EEH ?
> 

Actually, [un]fortunately, we haven't encountered any segmenting issues
yet, but to move BARs we are using the same existing mechanism in Linux
kernel that re-enumerated the PCIe topology during startup with
"pci=realloc" and PCI_REASSIGN_ALL_BUS. What restrictions must be broken
to provoke a segmenting event?

Are there any other limitations on segmenting besides keeping all the
BARs of the PHB within its huge M32+M64 segments which are 2GiB+4GiB on
our setup?

> It's a horrible mess right now and I don't know if the current code can
> even work properly to be honest.
> 
> Cheers,
> Ben.
> 
> 

Best regards,
Serge
