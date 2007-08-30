Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B6A3EDDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 02:32:30 +1000 (EST)
In-Reply-To: <20070829164638.GA31640@ld0162-tx32.am.freescale.net>
References: <20070829164638.GA31640@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ab107db1fd4d7e9bc3b461b7f4157100@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/9] bootwrapper: Add strtoull().
Date: Thu, 30 Aug 2007 10:52:22 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Aug 30 02:46:38 EST 2007, Scott Wood wrote:

> +               if (*ptr >= '0' && *ptr <= '9' && *ptr < '0' + base)
> +                       digit = *ptr - '0';
> +               else if (*ptr >= 'A' && *ptr < 'A' + base - 10)
> +                       digit = *ptr - 'A' + 10;
> +               else if (*ptr >= 'a' && *ptr < 'z' + base - 10)
> +                       digit = *ptr - 'a' + 10;
> +               else
> +                       break;

'z' should also be 'a' like the 'A' case.

Should we add <= 'Z' like we do '9', or do we not care about bases > 
36?  (It really breaks above base 42).

milton
