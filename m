Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 51CFCDDF02
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 08:15:32 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LjgdF-0008GW-Ll
	for linuxppc-dev@ozlabs.org; Tue, 17 Mar 2009 14:15:29 -0700
Message-ID: <22567864.post@talk.nabble.com>
Date: Tue, 17 Mar 2009 14:15:29 -0700 (PDT)
From: davidastro <davidastro@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Fix for __div64_32 locks when using some 64 bit numbers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I found a bug when using the function __div64_32 in assembly in a 32 bit ppc
architecture unit.

I tried the numbers 55834565048000000 for the dividend and 4294967079 for
the divisor. When passing these two numbers to the function  __div64_32, I
had a software lock. I searched for possible patches online and in different
forums but I could not find anything related to the assembly implementation
to this function (I would have to apologize if somebody already found a fix
:-) ).

Anyway, when analyzing the assembly code, I found out with gdb the problem.
I am not an expert in ppc architecture but I read the documentation and I am
pretty sure I solved the issue (I have been testing for couple of days using
random 64 to 32 number combinations with good results).

Who or Where should I post the fix to be reviewed.

Thanks for your attention
-- 
View this message in context: http://www.nabble.com/Fix-for-__div64_32-locks-when-using-some-64-bit-numbers-tp22567864p22567864.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
