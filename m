Return-Path: <joel.stan@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C3B01A0145
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 14:17:27 +1100 (AEDT)
Received: by wixo5 with SMTP id o5so34433689wix.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 20:17:23 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20150331153912.267c0b1af94b5f4964d791de@linux-foundation.org>
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
 <20150331153912.267c0b1af94b5f4964d791de@linux-foundation.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Apr 2015 13:47:01 +1030
Message-ID: <CACPK8XezpWftupa-jgMfiO2B9ozJS07ZKZW7XyWdvE=Z52dF+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 fabf@skynet.be, Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On Wed, Apr 1, 2015 at 9:09 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 30 Mar 2015 12:45:32 +1030 Joel Stanley <joel@jms.id.au> wrote:
>
>> The kernel has orderly_poweroff which allows the kernel to initiate a
>> graceful shutdown of userspace, by running /sbin/poweroff. This adds
>> orderly_reboot that will cause userspace to shut itself down by calling
>> /sbin/reboot.
>>
>> This will be used for shutdown initiated by a system controller on
>> platforms that do not use ACPI.
>
> gee.  There are a lot of callers of emergency_restart().  Why is the
> BMC reboot special, and how many of the emergency_restart() callers
> really be using orderly_reboot()?

The BMC reboot is intended to be a graceful shutdown - let userspace
do it's thing before the system goes down.

Userspace may chose to stop and perform some long, slow teardown
before it gets around to shutting down. We don't want to move callers
over orderly_reboot() if they're shutting the system down due to a
critical failure, eg. printer on fire.

I had a read of the emergency_restart() callers and I didn't see any
obvious cases for moving over to orderly_reboot().

> We have /proc/sys/kernel/poweroff_cmd.  Should we have
> /proc/sys/kernel/reboot_cmd as well?  If not,
> kernel/reboot.c:reboot_cmd[] can be made static ;)

I don't think we need it. I'll make reboot_cmd[] static.

Cheers,

Joel
