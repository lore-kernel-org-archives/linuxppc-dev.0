Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHK5Z73HMzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 07:37:06 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v16KY0wN078159
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 15:37:04 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28eu3edtr2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 15:37:04 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 13:37:03 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 55B131FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:36:39 -0700 (MST)
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v16Kb19Q13435388
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 13:37:01 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F9D97804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:37:01 -0700 (MST)
Received: from oc5780617838.ibm.com (unknown [9.10.86.191])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP id 2600E78038
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:37:01 -0700 (MST)
Subject: Re: xmon memory dump does not handle LE
To: linuxppc-dev@lists.ozlabs.org
References: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
 <87a8a4avx3.fsf@concordia.ellerman.id.au>
 <d245dc28-5075-8631-4ff1-1039ad88ccd5@linux.vnet.ibm.com>
 <87vasra7lp.fsf@concordia.ellerman.id.au>
 <4efc7afd-647c-106d-ca90-5f736514f5fc@linux.vnet.ibm.com>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Mon, 6 Feb 2017 14:37:00 -0600
MIME-Version: 1.0
In-Reply-To: <4efc7afd-647c-106d-ca90-5f736514f5fc@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <dcd38056-3142-ce00-e7fe-2bfc6ba6f69c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/06/2017 07:50 AM, Douglas Miller wrote:
> Hi Michael,
>
> Yes, your patch seems a more complete solution. The idea of "d1", 
> "d2", "d4", and "d8" commands is more what I needed and makes more 
> sense to someone hitting xmon "cold". I'll work on getting your patch 
> submitted.
>
>
> Question on these sorts of patches (PPC only), do we submit initially 
> to upstream, or here on this (PPC) mailing list? It would be nice to 
> get this into the distros as soon as possible.
>
> Thanks,
>
> Doug
>
>
> On 02/03/2017 04:31 AM, Michael Ellerman wrote:
>> Douglas Miller <dougmill@linux.vnet.ibm.com> writes:
>>
>>> I'm referring to the three commands listed in the help:
>>>
>>> d     dump bytes
>>>
>>> df    dump float values
>>>
>>> dd    dump double values
>>>
>>> As it turns out, all three of these commands do exactly the same thing,
>>> and it's certainly not what I'd expect based on experience with other
>>> debuggers. Maybe the original intent was only to simply output bytes of
>>> memory, but to me the help implies otherwise and certainly something
>>> more is needed.
>> OK. I don't think df/dd actually exist in the code, so I think the help
>> is just out of date, by about 20 years.
>>
>> 'd' definitely works as intended and does what the help says as far as
>> I'm concerned. The output is pretty similar to hexdump -C for example.
>>
>> Also xmon isn't a debugger it's a crash handler :)
>>
>>> I'll take a look at Balbir's patch and see if I can help move it along.
>> Actually take a look at mine instead.
>>
>> cheers
>>
>
Here's the patch I created and tested today:

 From 4aef7bd08950b83af355650e9b61528fb703450b Mon Sep 17 00:00:00 2001
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Mon, 6 Feb 2017 09:35:54 -0600
Subject: [PATCH] Extend dump command to allow display of 2, 4, and 8 
byte words in native
  endian format. Also adds dump command for "1 byte words" for the sake
  of symmetry. New commands are:

         d1      dump 8 bit values
         d2      dump 16 bit values
         d4      dump 32 bit values
         d8      dump 64 bit values
---
  arch/powerpc/xmon/xmon.c |   65 
+++++++++++++++++++++++++++++++++++++++++++--
  1 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..6249975 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -212,6 +212,10 @@ static void xmon_print_symbol(unsigned long 
address, const char *mid,
    "\
    C    checksum\n\
    d    dump bytes\n\
+  d1   dump 8 bit values\n\
+  d2   dump 16 bit values\n\
+  d4   dump 32 bit values\n\
+  d8   dump 64 bit values\n\
    di   dump instructions\n\
    df   dump float values\n\
    dd   dump double values\n\
@@ -2334,9 +2338,49 @@ static void dump_pacas(void)
  }
  #endif

+static void dump_by_size(unsigned long addr, long count, int size)
+{
+       unsigned char temp[16];
+       int i, j;
+       u64 val;
+
+       /*
+        * 'count' was aligned 16. If that changes, the following
+        * must also change to accommodate other values for 'count'.
+        */
+       for (i = 0; i < count; i += 16, addr += 16) {
+               printf(REG, addr);
+
+               if (mread(addr, temp, 16) != 16) {
+                       printf("Faulted reading %d bytes from 
0x"REG"\n", 16, addr);
+                       return;
+               }
+
+               for (j = 0; j < 16; j += size) {
+                       putchar(' ');
+                       switch (size) {
+                       case 1: val = temp[j]; break;
+                       case 2: val = *(u16 *)&temp[j]; break;
+                       case 4: val = *(u32 *)&temp[j]; break;
+                       case 8: val = *(u64 *)&temp[j]; break;
+                       default: val = 0;
+                       }
+
+                       printf("%0*lx", size * 2, val);
+               }
+               printf("  |");
+               for (j = 0; j < 16; ++j) {
+                       val = temp[j];
+                       putchar(' ' <= val && val <= '~' ? val : '.');
+               }
+               printf("|\n");
+       }
+}
+
  static void
  dump(void)
  {
+       static char last[] = { "d?\n" };
         int c;

         c = inchar();
@@ -2350,8 +2394,9 @@ static void dump_pacas(void)
         }
  #endif

-       if ((isxdigit(c) && c != 'f' && c != 'd') || c == '\n')
+       if (c == '\n')
                 termch = c;
+
         scanhex((void *)&adrs);
         if (termch != '\n')
                 termch = 0;
@@ -2383,9 +2428,23 @@ static void dump_pacas(void)
                         ndump = 64;
                 else if (ndump > MAX_DUMP)
                         ndump = MAX_DUMP;
-               prdump(adrs, ndump);
+
+               switch (c) {
+               case '8':
+               case '4':
+               case '2':
+               case '1':
+                       ndump = ALIGN(ndump, 16);
+                       dump_by_size(adrs, ndump, c - '0');
+                       last[1] = c;
+                       last_cmd = last;
+                       break;
+               default:
+                       prdump(adrs, ndump);
+                       last_cmd = "d\n";
+               }
+
                 adrs += ndump;
-               last_cmd = "d\n";
         }
  }

-- 
1.7.1
