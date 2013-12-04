Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 064572C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 00:44:50 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 4 Dec 2013 13:44:45 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B11A117D8069
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 13:44:33 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB4DhFHQ40894548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 13:43:15 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB4DhQcw018557
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Dec 2013 06:43:26 -0700
Message-ID: <529F31F8.6040302@linux.vnet.ibm.com>
Date: Wed, 04 Dec 2013 14:45:28 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tom Musta <tommusta@gmail.com>
Subject: Re: [PATCH] powerpc: fix xmon disassembler for little-endian
References: <1385975412-25869-1-git-send-email-felix@linux.vnet.ibm.com>
 <529C9397.9050704@gmail.com>
In-Reply-To: <529C9397.9050704@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tom Musta wrote:
> On 12/2/2013 3:10 AM, Philippe Bergheaud wrote:
> 
>>This patch fixes the disassembler of the powerpc kernel debugger xmon,
>>for little-endian.
>>
>>Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
>>---
>> arch/powerpc/xmon/xmon.c |    4 ++++
>> 1 file changed, 4 insertions(+)
>>
>>diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>>index af9d346..6c27804 100644
>>--- a/arch/powerpc/xmon/xmon.c
>>+++ b/arch/powerpc/xmon/xmon.c
>>@@ -171,7 +171,11 @@ extern void xmon_leave(void);
>> #define REG		"%.8lx"
>> #endif
>> 
>>+#ifdef __LITTLE_ENDIAN__
>>+#define GETWORD(v)	(((v)[3] << 24) + ((v)[2] << 16) + ((v)[1] << 8) + (v)[0])
>>+#else
>> #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
>>+#endif
>> 
>> #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
>> 			 || ('a' <= (c) && (c) <= 'f') \
>>
> 
> 
> Philippe:  Wouldn't it be better to just do a 32-bit load and let the endianness be worked out
> by the hardware?  i.e.
> 
> #define GETWORD(v) (*(u32 *)v)
Yes, your alternative is better.
Wouldn't it narrow the scope of the macro to aligned words on POWER7?
I think that all references to GETWORD operate on aligned words anyway.

Philippe
