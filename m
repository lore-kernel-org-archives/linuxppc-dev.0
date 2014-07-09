Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33AD51A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 23:57:57 +1000 (EST)
Message-ID: <53BD4A5E.90608@hurleysoftware.com>
Date: Wed, 09 Jul 2014 09:57:50 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>, Arnd Bergmann <arnd@arndb.de>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
 <4575870.N9RCpZ4UMg@wuerfel> <53A01F02.7000202@hurleysoftware.com>
 <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
 <53A0273F.70400@hurleysoftware.com>
In-Reply-To: <53A0273F.70400@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Karsten Keil <isdn@linux-pingi.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2014 07:32 AM, Peter Hurley wrote:
> On 06/17/2014 07:03 AM, David Laight wrote:
>> From: Peter Hurley
>> ...
>>>> I don't understand the second half of the changelog, it doesn't seem
>>>> to fit here: there deadlock that we are trying to avoid here happens
>>>> when the *same* tty needs the lock to complete the function that
>>>> sends the pending data. I don't think we do still do that any more,
>>>> but it doesn't seem related to the tty lock being system-wide or not.
>>>
>>> The tty lock is not used in the i/o path; it's purpose is to
>>> mutually exclude state changes in open(), close() and hangup().
>>>
>>> The commit that added this [1] comments that _other_ ttys may wait
>>> for this tty to complete, and comments in the code note that this
>>> function should be removed when the system-wide tty mutex was removed
>>> (which happened with the commit noted in the changelog).
>>
>> What happens if another process tries to do a non-blocking open
>> while you are sleeping in close waiting for output to drain?
>>
>> Hopefully this returns before that data has drained.
>
> Good point.
>
> tty_open() should be trylocking both mutexes anyway in O_NONBLOCK.

Further, the tty lock should not be nested within the tty_mutex lock
in a reopen, regardless of O_NONBLOCK.

AFAICT, the tty_mutex in the reopen scenario is only protecting the
tty count bump of the linked tty (if the tty is a pty).

I think with some refactoring and returning with a tty reference held
from both tty_open_current_tty() and tty_driver_lookup_tty(), the tty
lock in tty_open() can be attempted without nesting in the tty_mutex.

Regardless, I'll be splitting this series and I'll be sure to cc
you all when I resubmit these changes (after testing).

Regards,
Peter Hurley
