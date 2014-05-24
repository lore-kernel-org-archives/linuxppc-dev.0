Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C5901A0547
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:38:03 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 24 May 2014 11:37:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4C46C357804F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:37:55 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4O1GF5F38600718
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:16:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4O1brxR018104
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 11:37:54 +1000
Date: Sat, 24 May 2014 11:37:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140524013754.GA4636@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <537DC991.9010401@suse.de> <20140523001730.GA12584@shangw>
 <20140523003737.GA15136@shangw>
 <1400815400.3289.436.camel@ul30vt.home>
 <22ECE7F7-2C1F-4E54-AD6B-0D2405357C9A@suse.de>
 <20140523115809.GB4042@shangw> <537F3F64.8020807@suse.de>
 <1400856559.3289.460.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400856559.3289.460.camel@ul30vt.home>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 23, 2014 at 08:49:19AM -0600, Alex Williamson wrote:
>On Fri, 2014-05-23 at 14:30 +0200, Alexander Graf wrote:
>> On 23.05.14 13:58, Gavin Shan wrote:
>> > On Fri, May 23, 2014 at 08:52:23AM +0200, Alexander Graf wrote:
>> >>> Am 23.05.2014 um 05:23 schrieb Alex Williamson <alex.williamson@redhat.com>:
>> >>>> On Fri, 2014-05-23 at 10:37 +1000, Gavin Shan wrote:
>> >>>>> On Fri, May 23, 2014 at 10:17:30AM +1000, Gavin Shan wrote:
>> >>>>>> On Thu, May 22, 2014 at 11:55:29AM +0200, Alexander Graf wrote:
>> >>>>>> On 22.05.14 10:23, Gavin Shan wrote:

.../...

>
>If there's a reason to use something other than _IO+argsz+flags, we can
>discuss it, but this is not it.
>

If I just need a command, need I define a struct for the command, or I
should pass "NULL" for the 3rd parameter of ioctl() ?

struct foo {
	uint32_t argsz;
	uint32_t flags;
};

>> >   Also, I need keep the return value from
>> > ioctl() less or equal to 0 ? :-)
>> 
>> Usually return values are
>> 
>>    < 0 means error
>>    == 0 means success
>>    > 0 means return payload
>
>Agree, >0 only makes sense if the return value of the ioctl can be
>expressed as a positive int, ex. VFIO_EEH_ERROR_COUNT (if such a thing
>was needed).  Thanks,
>

What if I have to return "0" ? For "0", I need have a field in the
data struct to carry it. For "> 0", to carry it with return value
from ioctl(). Why not make it unified to have additional field in
the data struct to carry the return values. In this case, ioctl()
just returns:

<  0: error
== 0: success, check return value from the data struct.

Thanks,
Gavin
