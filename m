Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 11A55DDEC2
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 01:52:01 +1000 (EST)
In-Reply-To: <20070718.182640.-1300542340.kouish@swc.toshiba.co.jp>
References: <20070718.182640.-1300542340.kouish@swc.toshiba.co.jp>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7bd7b12c7bd2303039a850a1fee9634c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/2] fix showing xmon help
Date: Wed, 18 Jul 2007 10:51:50 -0500
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Jul 18 19:26:40 EST 2007, Ishizaki Kou wrote:
> In some configuration, xmon help string is larger than xmon_printf
> buffer. We need not to use printf.  This patch adds xmon_puts and
> change to use it to show help string.

[Since I'm requesting changes I'll suggest a new change log.]

In some configurations the xmon help string is larger than the 
xmon_printf buffer.  However, since its a fixed string we do not need 
printf to format it.  This patch adds xmon_puts and uses it to show the 
help string.


>                 case '?':
> -                       printf(help_string);
> +                       xmon_puts(help_string);
>                         break;
>

nonstdio.h #defines printf to xmon_printf.  Please add a similar line 
for puts, and use the define here.  (It will avoid an unnecessary 
difference with the user space version).

Thanks,
milton
