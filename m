Return-Path: <cfriesen@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id E4EFC67A6F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 04:26:12 +1000 (EST)
Received: from zcard303.ca.nortel.com (zcard303.ca.nortel.com [47.129.242.59])
	by zcars04f.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with
	ESMTP id j36IQ9j02360
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Apr 2005 14:26:09 -0400 (EDT)
Message-ID: <425429BF.1050706@nortel.com>
Date: Wed, 06 Apr 2005 12:26:07 -0600
From: Chris Friesen <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: question on inline assembly and long long values
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I want to retrieve the msr (which is 64-bits) on a 970 when running in 
32-bit mode.  I have the following bit of code that seems to work, but 
when looking at the code it always seems to use a suboptimal register 
for the low word, and then it ends up having to copy it to the right 
register to create a long long register pair.

static inline unsigned long long get_msr()
{
	union {
		struct {
			unsigned long low;
			unsigned long high;
		} words;
		unsigned long long val;
	} val;
         asm volatile( \
                 "mfmsr  %0               \n\t" \
                 "rldicl %1,%0,32,32       \n\t" \
                 "rldicl %0,%0,0,32        \n\t" \
                 : "=r" (val.words.low), "=r" (val.words.high));
	return val.val;
}

Using this code, the optimised assembly output of

	unsigned long long a = asdf();
	unsigned long long b = asdf();

is

	mfmsr  5
	rldicl 0,5,32,32
	rldicl 5,5,0,32
	mr 6,0
	mfmsr  7
	rldicl 9,7,32,32
	rldicl 7,7,0,32
	mr 8,9

I figure it should have been able to use registers 6/8 in the first 
place, and save the extra moves.

Is there any way to help gcc optimise this?


Chris
