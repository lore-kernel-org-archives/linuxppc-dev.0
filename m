Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD9A51A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:23:47 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 10 Feb 2016 16:23:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0A72C2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:23:44 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A6NaYu1179938
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:23:44 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A6NB1Q028613
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:23:11 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 13/18] cxl: sysfs support for guests
In-reply-to: <56BA03EF.8040507@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-14-git-send-email-fbarrat@linux.vnet.ibm.com>
 <877fifykej.fsf@linux.vnet.ibm.com> <56BA03EF.8040507@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 17:22:46 +1100
Message-Id: <1455084834-sup-732@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-02-10 02:21:19 +1100:
> 
> Le 08/02/2016 04:02, Stewart Smith a écrit :
> > Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
> >> --- a/Documentation/ABI/testing/sysfs-class-cxl
> >> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> >> @@ -183,7 +183,7 @@ Description:    read only
> >>                   Identifies the revision level of the PSL.
> >>   Users:        https://github.com/ibm-capi/libcxl
> >>
> >> -What:           /sys/class/cxl/<card>/base_image
> >> +What:           /sys/class/cxl/<card>/base_image (not in a guest)
> >
> > Is this going to be the case for KVM guest as well as PowerVM guest?
> 
> 
> That's too early to say.
> The entries we've removed are because the information is filtered by 
> pHyp and not available to the OS. Some of it because nobody thought it 
> would be useful, some of it because it's not meant to be seen by the OS. 
> For KVM, if the card can be shared between guests, I would expect the 
> same kind of restrictions.

The OS doesn't particularly care about this - the only people who might
even possibly need to know will be whoever is trying to flash their PSL
image, and probably not even then.

On KVM we are thinking that it will have to be root on the hypervisor
responsible for flashing the PSL image (there isn't much other option
unless we want to go into signed images and whatnot, but even if we do
I'm 100% committed to making that a userspace problem to solve and not
trying to do anything fancy in the kernel), so we won't really need it,
but I also don't see any harm in exposing it to guests.

Cheers,
-Ian
