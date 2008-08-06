Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 551F8DDF6B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 10:24:00 +1000 (EST)
Received: from [192.168.1.37] (node223.77.251.72.1dial.com [72.251.77.223])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m760NgR4078239
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 17:23:54 -0700 (PDT)
Message-ID: <4898EE60.9080206@hypersurf.com>
Date: Tue, 05 Aug 2008 17:20:48 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: inline assembly & r0 SOS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

If I have:

inline unsigned int get_PLL_range(unsigned int range, unsigned int
         config)
{
unsigned int ret;

         /*
          * Turn r3 (range) into a rotate count for the selected range.
          * 0 -> 23, 1 -> 31
          */
         __asm__ __volatile__ (  "slwi %0,%0,3\n"
                                 "addi %0,%0,23\n"
                                 "rlwnm %0,%1,%0,30,31\n":
                 "=r"(ret):
                 "r"(config),"0"(range)
         );

         return ret;
}

in a header and the resultant code generated is:

.L58:
         li 0,1   # ratio,
         mr 29,0  # ret, ratio
#APP
         slwi 29,29,3     # ret
addi 29,29,21    # ret
rlwnm 29,28,29,27,31     # ret, ret

         slwi 0,0,3       # ret
addi 0,0,23      # ret
rlwnm 0,28,0,30,31       # ret, ret

#NO_APP

thats bad right? Because the "addi 0, 0, 23" will not work as expected 
because of the "special property" of r0. FYI:  The first three lines 
after the "#APP" are from a similar function get_PLL_ratio().

	Is there a way to blacklist r0?

kevin
