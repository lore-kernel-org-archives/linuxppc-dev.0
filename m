Return-Path: <cfriesen@nortel.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 08CAD67AC5
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 07:37:43 +1000 (EST)
Message-ID: <4254569D.2050300@nortel.com>
Date: Wed, 06 Apr 2005 15:37:33 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
References: <425429BF.1050706@nortel.com>
	<2b5cd7aefbd800842537d00be729d169@freescale.com>
	<42544010.4020105@nortel.com> <20050406211843.GA2737@iram.es>
In-Reply-To: <20050406211843.GA2737@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert wrote:
> On Wed, Apr 06, 2005 at 02:01:20PM -0600, Chris Friesen wrote:

>>static inline unsigned long long getmsr()
>>{
>>	unsigned long long val;
>>        asm volatile( \
>>                "mfmsr  %L0               \n\t" \
>>                "rldicl %0,%L0,32,32       \n\t" \
>>                "rldicl %L0,%L0,0,32        \n\t" \
>>                : "=r" (val));
>>	return val;
>>}

> If you are running in 32 bit mode, you don't need
> to clear the upper half of %L0.

Thanks for the tip.  That cuts out another instruction.

Chris
