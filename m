Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCFEE1A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 20:57:16 +1000 (EST)
Message-ID: <53A01F02.7000202@hurleysoftware.com>
Date: Tue, 17 Jun 2014 06:57:06 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
 <4575870.N9RCpZ4UMg@wuerfel>
In-Reply-To: <4575870.N9RCpZ4UMg@wuerfel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Karsten Keil <isdn@linux-pingi.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2014 04:00 AM, Arnd Bergmann wrote:
> On Monday 16 June 2014 09:17:11 Peter Hurley wrote:
>> tty_wait_until_sent_from_close() drops the tty lock while waiting
>> for the tty driver to finish sending previously accepted data (ie.,
>> data remaining in its write buffer and transmit fifo).
>>
>> However, dropping the tty lock is a hold-over from when the tty
>> lock was system-wide; ie., one lock for all ttys.
>>
>> Since commit 89c8d91e31f267703e365593f6bfebb9f6d2ad01,
>> 'tty: localise the lock', dropping the tty lock has not been necessary.
>>
>> CC: Karsten Keil <isdn@linux-pingi.de>
>> CC: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>
> I don't understand the second half of the changelog, it doesn't seem
> to fit here: there deadlock that we are trying to avoid here happens
> when the *same* tty needs the lock to complete the function that
> sends the pending data. I don't think we do still do that any more,
> but it doesn't seem related to the tty lock being system-wide or not.

The tty lock is not used in the i/o path; it's purpose is to
mutually exclude state changes in open(), close() and hangup().

The commit that added this [1] comments that _other_ ttys may wait
for this tty to complete, and comments in the code note that this
function should be removed when the system-wide tty mutex was removed
(which happened with the commit noted in the changelog).

Regards,
Peter Hurley


[1]
commit a57a7bf3fc7eff00f07eb9c805774d911a3f2472
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Thu Aug 25 15:12:06 2011 +0200

     TTY: define tty_wait_until_sent_from_close

     We need this helper to fix system stalls. The issue is that the rest
     of the system TTYs wait for us to finish waiting. This wasn't an issue
     with BKL. BKL used to unlock implicitly.

     This is based on the Arnd suggestion.

     Signed-off-by: Jiri Slaby <jslaby@suse.cz>
     Acked-by: Arnd Bergmann <arnd@arndb.de>
     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
