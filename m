Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 60DE4DDEB6
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 16:49:28 +1000 (EST)
In-Reply-To: <20070720.171509.-1300522247.kouish@swc.toshiba.co.jp>
References: <20070720.171509.-1300522247.kouish@swc.toshiba.co.jp>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2184f492262202ac5720909568153d87@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/2] fix showing xmon help
Date: Mon, 23 Jul 2007 01:49:11 -0500
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 20, 2007, at 3:15 AM, Ishizaki Kou wrote:

> Milton Miller <miltonm@bga.com> wrote:
>> On Jul 18, 2007, at 11:12 AM, Andreas Schwab wrote:
>>
>>> Milton Miller <miltonm@bga.com> writes:
>>>
>>>>>                 case '?':
>>>>> -                       printf(help_string);
>>>>> +                       xmon_puts(help_string);
>>>>>                         break;
>>>>>
>>>>
>>>> nonstdio.h #defines printf to xmon_printf.  Please add a similar
>>>> line
>>>> for puts, and use the define here.  (It will avoid an unnecessary
>>>> difference with the user space version).
>>>
>>> User space puts add a newline, which this xmon_puts doesn't.
>>>
>>> Andreas.
>>
>> Good point.  This should be xmon_fputs #defined to fputs.
>>
>> milton
>
> Should we change like below?
>
> define fputs:
>  #define fputs(str,stream)  xmon_fputs(str) /* stream is ignored. */
>
> show the help string:
>  fputs(help_string, stdout);
>

Sounds good to me.  It's consistent with using printf.


milton
