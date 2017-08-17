Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXpd04TlWzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 11:33:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "abdhalee\@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch\@lst.de" <hch@lst.de>,
 "brking\@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
 "sfr\@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "sachinp\@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
 "linux-next\@vger.kernel.org" <linux-next@vger.kernel.org>,
 "hare\@suse.com" <hare@suse.com>
Subject: Re: [BUG][bisected 270065e] linux-next fails to boot on powerpc
In-Reply-To: <1502904072.2421.3.camel@wdc.com>
References: <1502902815.3305.22.camel@abdul.in.ibm.com>
 <1502904072.2421.3.camel@wdc.com>
Date: Thu, 17 Aug 2017 11:33:08 +1000
Message-ID: <87o9rfrnaj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bart Van Assche <Bart.VanAssche@wdc.com> writes:

> On Wed, 2017-08-16 at 22:30 +0530, Abdul Haleem wrote:
>> As of next-20170809, linux-next on powerpc boot hung with below trace
>> message.
>> 
>> [ ... ]
>> 
>> A bisection resulted in first bad commit (270065e92 - scsi: scsi-mq:
>> Always unprepare ...) in the merge branch 'scsi/for-next'
>> 
>> System booted fine when the below commit is reverted: 
>> 
>> commit 270065e92c317845d69095ec8e3d18616b5b39d5
>> Author: Bart Van Assche <bart.vanassche@wdc.com>
>> Date:   Thu Aug 3 14:40:14 2017 -0700
>> 
>>     scsi: scsi-mq: Always unprepare before requeuing a request
>
> Hello Brian and Michael,
>
> Do you agree that this probably indicates a bug in the PowerPC block driver
> that is used to access the boot disk?

I don't know a scsi device from a block device, so I'm not much help sorry.

It seems likely it is a powerpc specific bug, as it seems no one else
has reported any problems with this commit.

> Anyway, since a solution is not yet available, I will submit a revert
> for this patch.

Thanks. Sorry I haven't been able to debug it further, there's about 10
things on fire right now - ie. situation normal :)

cheers
