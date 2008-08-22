Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 6D6D3DE015
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 11:31:05 +1000 (EST)
Received: from [192.168.1.37] (node39.76.251.72.1dial.com [72.251.76.39])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7M1TK1W037143
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:30:57 -0700 (PDT)
Message-ID: <48AE1644.8050102@hypersurf.com>
Date: Thu, 21 Aug 2008 18:28:36 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: disable modules and get "multiple definition" errors?
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

	I am trying to do some compile testing of my cpufreq driver. If
I disable modules I am getting multiple definition errors of inline
functions:

inline volatile unsigned int get_PLL(void)
{
unsigned int ret;

         __asm__ __volatile__ ("mfspr %0,%1":
                 "=r"(ret):
                 "i"(SPRN_HID1)
         );

         return ret;
}

arch/powerpc/kernel/cpu/pll_if.o(.text+0x1c): In function `get_PLL':
: multiple definition of `get_PLL'
arch/powerpc/kernel/cpu/cpufreq/built-in.o(.text+0x0): first defined here

What am I doing wrong?

kevin
