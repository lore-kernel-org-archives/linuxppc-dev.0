Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 0D6C7DDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 09:19:38 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so311019anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Jul 2008 16:19:37 -0700 (PDT)
Message-ID: <3ae3aa420807201619m51e4a914rc4b97e084367d193@mail.gmail.com>
Date: Sun, 20 Jul 2008 18:19:36 -0500
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Nathan Lynch" <ntl@pobox.com>
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
In-Reply-To: <20080720203333.GQ9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <488383D4.9000602@us.ibm.com> <20080720203333.GQ9594@localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2008/7/20 Nathan Lynch <ntl@pobox.com>:
> Mike Mason wrote:
>>
>> This patch changes the EEH_MAX_FAILS action from panic to printing
>> an error message.  Panicking under under this condition is too
>> harsh.


>>                       /* re-read the slot reset state */
>>                       if (read_slot_reset_state(pdn, rets) != 0)
>>                               rets[0] = -1;   /* reset state unknown */
>
> While I tend to agree that panic() is unnecessary, don't we want a
> stack dump unconditionally (i.e. not bracketed in #ifdef DEBUG)?

Probably. This stack trace would reveal a point inside the
inf loop, which can then be analyzed and fixed.

> I'd prefer just removing the code instead of adding #ifdef's in the
> middle of this function.  eeh.c needs less #ifdef DEBUG, not more :)

I didn't know that there was a lot of ifdef DEBUG in there.
Yes, we don't need an ifdef DEBUG for this.

Pending these changes, I'd happily add:

Acked-by: Linas Vepstas <linasvepstas@gmail.com>

--linas
