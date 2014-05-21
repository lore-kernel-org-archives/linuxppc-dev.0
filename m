Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE5721A0814
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 20:49:07 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 May 2014 16:19:02 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E8FB5E0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:19:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4LAn7oL60489884
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:19:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4LAmvVO013905
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:18:57 +0530
Date: Wed, 21 May 2014 20:48:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] drivers/vfio: New IOCTL command VFIO_EEH_INFO
Message-ID: <20140521104852.GA20297@shangw>
References: <537B3AA7.7040106@suse.de> <537B3C68.8080102@suse.de>
 <20140520114031.GA20397@shangw> <537B4015.7030404@suse.de>
 <20140520122147.GA26483@shangw> <537B49C9.4000302@suse.de>
 <20140520123914.GA28441@shangw> <1400631832.3986.154.camel@pasglop>
 <17FB3514-B4F0-437F-826F-C473AD4F139E@suse.de>
 <1400657062.18653.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400657062.18653.2.camel@pasglop>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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

On Wed, May 21, 2014 at 05:24:22PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2014-05-21 at 08:23 +0200, Alexander Graf wrote:
>> > Note to Alex: This definitely kills the notifier idea for now
>> though,
>> > at least as a first class citizen of the design. We can add it as an
>> > optional optimization on top later.
>> 
>> I don't think it does. The notifier would just get triggered on config
>> space read failures for example :). It's really just an aid for the
>> vfio user to have a common code path for error handling.
>
>I'll let Gavin make the final call on that one, if he thinks we can
>reliably trigger it and there isn't too much code churn as a
>consequence.
>

Lets postpone it as future improvement. It's not hard to send the
event (EEH errors) out, but I need think about how to extend the
existing guest's infrastructure to accept event. As Ben mentioned,
event-scan might be potential mechanism for that. We can discuss
for more later :-)

Thanks,
Gavin
