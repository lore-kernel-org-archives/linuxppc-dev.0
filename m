Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 8F1CF67A6D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 06:01:35 +1000 (EST)
Message-ID: <42544010.4020105@nortel.com>
Date: Wed, 06 Apr 2005 14:01:20 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <425429BF.1050706@nortel.com>
	<2b5cd7aefbd800842537d00be729d169@freescale.com>
In-Reply-To: <2b5cd7aefbd800842537d00be729d169@freescale.com>
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

Kumar Gala wrote:
> I'm having a similar need (for a different purpose), this post might be 
> useful:
> 
> http://gcc.gnu.org/ml/gcc/2005-04/msg00283.html

Sweet!  My new code is now shorter *and* more efficient:

static inline unsigned long long getmsr()
{
	unsigned long long val;
         asm volatile( \
                 "mfmsr  %L0               \n\t" \
                 "rldicl %0,%L0,32,32       \n\t" \
                 "rldicl %L0,%L0,0,32        \n\t" \
                 : "=r" (val));
	return val;
}

This results in

unsigned long long a = asdf3();
unsigned long long b = asdf3();

being compiled to

	mfmsr  6
	rldicl 5,6,32,32
	rldicl 6,6,0,32
	
	mfmsr  8
	rldicl 7,8,32,32
	rldicl 8,8,0,32

Which is about as good as it gets...

Thanks!

Chris
