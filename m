Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29C461A081F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:39:14 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 May 2014 14:39:12 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5FBB62CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:39:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4L4HXwv64553170
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:17:34 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4L4d87L018528
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:39:08 +1000
Date: Wed, 21 May 2014 14:39:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
Message-ID: <20140521043907.GA1959@shangw>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3AA7.7040106@suse.de> <537B3C68.8080102@suse.de>
 <20140520114031.GA20397@shangw> <537B4015.7030404@suse.de>
 <20140520122147.GA26483@shangw> <537B49C9.4000302@suse.de>
 <20140520123914.GA28441@shangw> <1400631832.3986.154.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400631832.3986.154.camel@pasglop>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 21, 2014 at 10:23:52AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2014-05-20 at 22:39 +1000, Gavin Shan wrote:
>> >>Yeah. How about this? :-)
>> >>
>> >>- Move eeh-vfio.c to drivers/vfio/pci/
>> >>- From eeh-vfio.c, dereference arch/powerpc/kernel/eeh.c::eeh_ops, which
>> >>   is arch/powerpc/plaforms/powernv/eeh-powernv.c::powernv_eeh_ops. Call
>> >
>> >Hrm, I think it'd be nicer to just export individual functions that
>> >do thing you want to do from eeh.c.
>> >
>> 
>> Ok. Got it. Thanks for your comments :)
>
>The interesting thing with this approach is that VFIO per-se can work
>with EEH RTAS backend too in the host.
>

Yeah, it's another benefit for the approach. I need think about it
later. Thanks, Ben. It's really good point.

>IE, with PR KVM for example or with non-KVM uses of VFIO, it would be
>possible to use a device in a user process and exploit EEH even when
>running under a PAPR hypervisor.
>
>That is, vfio-eeh uses "generic" exported EEH APIs from the EEH core
>that will work on both powernv and RTAS backends.
>
>Note to Alex: This definitely kills the notifier idea for now though,
>at least as a first class citizen of the design. We can add it as an
>optional optimization on top later.
>

Yeah, I'll address the notifier later.

Thanks,
Gavin
