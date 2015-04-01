Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D23C51A09FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 16:05:40 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 10:35:38 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1888FE004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 10:37:56 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3155ajk64946356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 10:35:36 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3155ZKo004570
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 10:35:36 +0530
Message-ID: <551B7C9F.5030203@linux.vnet.ibm.com>
Date: Wed, 01 Apr 2015 10:35:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
 <20150331153912.267c0b1af94b5f4964d791de@linux-foundation.org>
 <CACPK8XezpWftupa-jgMfiO2B9ozJS07ZKZW7XyWdvE=Z52dF+Q@mail.gmail.com>
In-Reply-To: <CACPK8XezpWftupa-jgMfiO2B9ozJS07ZKZW7XyWdvE=Z52dF+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: fabf@skynet.be, Rusty Russell <rusty@rustcorp.com.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/01/2015 08:47 AM, Joel Stanley wrote:
> Hi Andrew,
> 
> On Wed, Apr 1, 2015 at 9:09 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
>> > On Mon, 30 Mar 2015 12:45:32 +1030 Joel Stanley <joel@jms.id.au> wrote:
>> >
>>> >> The kernel has orderly_poweroff which allows the kernel to initiate a
>>> >> graceful shutdown of userspace, by running /sbin/poweroff. This adds
>>> >> orderly_reboot that will cause userspace to shut itself down by calling
>>> >> /sbin/reboot.
>>> >>
>>> >> This will be used for shutdown initiated by a system controller on
>>> >> platforms that do not use ACPI.
>> >
>> > gee.  There are a lot of callers of emergency_restart().  Why is the
>> > BMC reboot special, and how many of the emergency_restart() callers
>> > really be using orderly_reboot()?
> The BMC reboot is intended to be a graceful shutdown - let userspace
> do it's thing before the system goes down.
> 
> Userspace may chose to stop and perform some long, slow teardown
> before it gets around to shutting down. We don't want to move callers
> over orderly_reboot() if they're shutting the system down due to a
> critical failure, eg. printer on fire.
> 
> I had a read of the emergency_restart() callers and I didn't see any
> obvious cases for moving over to orderly_reboot().
> 
>> > We have /proc/sys/kernel/poweroff_cmd.  Should we have
>> > /proc/sys/kernel/reboot_cmd as well?  If not,
>> > kernel/reboot.c:reboot_cmd[] can be made static ;)
> I don't think we need it. I'll make reboot_cmd[] static.

Just to have parity with power off command, /proc/sys/kernel/reboot_cmd would
be nice to have.
