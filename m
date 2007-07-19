Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BDE3ADDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 15:50:46 +1000 (EST)
In-Reply-To: <je1wf5bshh.fsf@sykes.suse.de>
References: <20070718.182640.-1300542340.kouish@swc.toshiba.co.jp>
	<7bd7b12c7bd2303039a850a1fee9634c@bga.com>
	<je1wf5bshh.fsf@sykes.suse.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <664cbe49d76cfcba9d8a86e3a6946a2a@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/2] fix showing xmon help
Date: Thu, 19 Jul 2007 00:50:22 -0500
To: Andreas Schwab <schwab@suse.de>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 11:12 AM, Andreas Schwab wrote:

> Milton Miller <miltonm@bga.com> writes:
>
>>>                 case '?':
>>> -                       printf(help_string);
>>> +                       xmon_puts(help_string);
>>>                         break;
>>>
>>
>> nonstdio.h #defines printf to xmon_printf.  Please add a similar line
>> for puts, and use the define here.  (It will avoid an unnecessary
>> difference with the user space version).
>
> User space puts add a newline, which this xmon_puts doesn't.
>
> Andreas.

Good point.  This should be xmon_fputs #defined to fputs.

milton
