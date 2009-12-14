Return-Path: <neilc@linux.vnet.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [194.196.100.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC21AB6F1B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 01:21:25 +1100 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate5.uk.ibm.com (8.13.1/8.13.1) with ESMTP id nBEELLag018119
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 14:21:21 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id nBEELLkj1314880
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 14:21:21 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id nBEELKnU027007
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 14:21:21 GMT
Message-ID: <4B2649DF.4010903@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2009 14:21:19 +0000
From: Neil Campbell <neilc@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: handle VSX alignment faults correctly in
	little-endian mode
References: <4B2646F9.4000203@linux.vnet.ibm.com>
In-Reply-To: <4B2646F9.4000203@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Neil Campbell wrote:
> This patch fixes the handling of VSX alignment faults in little-endian
> mode (the current code assumes the processor is in big-endian mode).
> 
> The patch also makes the handlers clear the top 8 bytes of the register
> when handling an 8 byte VSX load.

For the interested, here is a test case that demonstrates the problem.

It should compile with something like:

gcc -m64 -Wa,-mregnames -fno-strict-aliasing -mcpu=power7 -mvsx vsx_le.c -o vsx_le

On an unpatched kernel it reports 8 failures for me, the patch fixes all 8 of these.

---

#include <stdio.h>
#include <string.h>

int fails = 0;

#define LOAD_FUNC(name,inst) \
void test_load_##name(char* input, char* output, int le) \
{ \
  int aligned = (0 == ((long)input & 15)); \
  char* alignstr = aligned?"aligned:   ":"unaligned: "; \
  char* modestr = le?"(le)":"(be)"; \
  int i; \
  char dummydata[16] __attribute__((__aligned__(16))) = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff }; \
 \
  memset(output, 0, 16); \
 \
  asm ( \
      "mr r15, %[address1]\n\t" \
      "mr r16, %[address2]\n\t" \
      "lvx v0, r0, %[address3]\n\t" /* set register to dummy values */ \
      "cmpwi %[le],1 \n\t" \
      "beq "#name"leversion \n\t" \
      #name" vs32, r0, r15\n\t" \
      "b " #name"store\n\t" \
      #name"leversion: \n\t" \
      "li r0, 171\n\t" \
      "li r3, 20\n\t" \
      "li r4, 1\n\t" \
      "sc\n\t" \
      ".long " inst "\n\t" \
      ".long 0xab000038\n\t" /*"li 0, 171\n\t"*/ \
      ".long 0x14006038\n\t" /*"li 3, 20\n\t"*/ \
      ".long 0x00008038\n\t" /*"li 4, 0\n\t"*/ \
      ".long 0x02000044\n\t" /*"sc\n\t"*/ \
      #name"store: \n\t" \
      "stvx v0,r0,r16 \n\t" \
      : \
      : [address1] "b" (input), [address2] "b" (output), [address3] "b" (dummydata), [le] "b" (le) \
      : "vs32", "r0", "r3", "r4", "r9", "r15", "r16", "cc",  "memory"); \
 \
  fprintf(stderr, #name" %s after %s  ", alignstr, modestr); \
  for (i = 0; i < 16; ++i) \
  { \
    fprintf(stderr, " %x ", output[i]); \
  } \
  fprintf(stderr, "\n"); \
} \


#define STORE_FUNC(name,inst) \
void test_store_##name(char* input, char* output, int le) \
{ \
  int aligned = (0 == ((long)output & 15)); \
  char* alignstr = aligned?"aligned:   ":"unaligned: "; \
  char* modestr = le?"(le)":"(be)"; \
  int i; \
 \
  memset(output, 0, 16); \
 \
  asm ( \
      "mr r15, %[address2]\n\t" \
      "lvx v0, r0, %[address1]\n\t" \
      "cmpwi %[le],1 \n\t" \
      "beq "#name"leversion \n\t" \
      #name" vs32, r0, r15\n\t" \
      "b " #name"end\n\t" \
      #name"leversion: \n\t" \
      "li r0, 171\n\t" \
      "li r3, 20\n\t" \
      "li r4, 1\n\t" \
      "sc\n\t" \
      ".long " inst "\n\t" \
      ".long 0xab000038\n\t" /*"li 0, 171\n\t"*/ \
      ".long 0x14006038\n\t" /*"li 3, 20\n\t"*/ \
      ".long 0x00008038\n\t" /*"li 4, 0\n\t"*/ \
      ".long 0x02000044\n\t" /*"sc\n\t"*/ \
      #name"end: \n\t" \
      : \
      : [address1] "b" (input), [address2] "b" (output), [le] "b" (le) \
      : "vs32", "r0", "r3", "r4", "r9", "r15", "cc",  "memory"); \
 \
  fprintf(stderr, #name" %s after %s  ", alignstr, modestr); \
  for (i = 0; i < 16; ++i) \
  { \
    fprintf(stderr, " %x ", output[i]); \
  } \
  fprintf(stderr, "\n"); \
} \

void do_compare(char* buf1, char* buf2)
{
  if(0 == memcmp(buf1,buf2,16))
  {
    fprintf(stderr, "PASS\n");
  }
  else
  {
    fprintf(stderr, "FAIL\n");
    fails++;
  }
}

STORE_FUNC(stxvw4x, "0x197f007c")
STORE_FUNC(stxvd2x, "0x997f007c")
STORE_FUNC(stxsdx, "0x997d007c")

LOAD_FUNC(lxvw4x, "0x197e007c")
LOAD_FUNC(lxvd2x, "0x997e007c")
LOAD_FUNC(lxsdx, "0x997c007c")
LOAD_FUNC(lxvdsx, "0x997a007c")

int main(int argc, char* argv[])
{
  char inbuf[17] __attribute__((__aligned__(16))) = { -1, 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf };
  char alignedinbuf[16] __attribute__((__aligned__(16))) = { 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf };
  char outbuf[17] __attribute__((__aligned__(16))) = { -1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0 };
  char alignedoutbuf[16] __attribute__((__aligned__(16))) = { 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0 };
  char alignedoutbuf2[16] __attribute__((__aligned__(16))) = { 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0 };

  test_store_stxvw4x(alignedinbuf, alignedoutbuf, 0);
  test_store_stxvw4x(alignedinbuf, &outbuf[1], 0);
  do_compare(alignedoutbuf, &outbuf[1]);
  test_store_stxvw4x(alignedinbuf, alignedoutbuf, 1);
  test_store_stxvw4x(alignedinbuf, &outbuf[1], 1);
  do_compare(alignedoutbuf, &outbuf[1]);
  fprintf(stderr, "\n");

  test_store_stxvd2x(alignedinbuf, alignedoutbuf, 0);
  test_store_stxvd2x(alignedinbuf, &outbuf[1], 0);
  do_compare(alignedoutbuf, &outbuf[1]);
  test_store_stxvd2x(alignedinbuf, alignedoutbuf, 1);
  test_store_stxvd2x(alignedinbuf, &outbuf[1], 1);
  do_compare(alignedoutbuf, &outbuf[1]);
  fprintf(stderr, "\n");

  test_store_stxsdx(alignedinbuf, alignedoutbuf, 0);
  test_store_stxsdx(alignedinbuf, &outbuf[1], 0);
  do_compare(alignedoutbuf, &outbuf[1]);
  test_store_stxsdx(alignedinbuf, alignedoutbuf, 1);
  test_store_stxsdx(alignedinbuf, &outbuf[1], 1);
  do_compare(alignedoutbuf, &outbuf[1]);
  fprintf(stderr, "\n");

  test_load_lxvw4x(alignedinbuf, alignedoutbuf, 0);
  test_load_lxvw4x(&inbuf[1], alignedoutbuf2, 0);
  do_compare(alignedoutbuf, alignedoutbuf2);
  test_load_lxvw4x(alignedinbuf, alignedoutbuf, 1);
  test_load_lxvw4x(&inbuf[1], alignedoutbuf2, 1);
  do_compare(alignedoutbuf, alignedoutbuf2);
  fprintf(stderr, "\n");

  test_load_lxvd2x(alignedinbuf, alignedoutbuf, 0);
  test_load_lxvd2x(&inbuf[1], alignedoutbuf2, 0);
  do_compare(alignedoutbuf, alignedoutbuf2);
  test_load_lxvd2x(alignedinbuf, alignedoutbuf, 1);
  test_load_lxvd2x(&inbuf[1], alignedoutbuf2, 1);
  do_compare(alignedoutbuf, alignedoutbuf2);
  fprintf(stderr, "\n");

  test_load_lxsdx(alignedinbuf, alignedoutbuf, 0);
  test_load_lxsdx(&inbuf[1], alignedoutbuf2, 0);
  do_compare(alignedoutbuf, alignedoutbuf2);
  test_load_lxsdx(alignedinbuf, alignedoutbuf, 1);
  test_load_lxsdx(&inbuf[1], alignedoutbuf2, 1);
  do_compare(alignedoutbuf, alignedoutbuf2);
  fprintf(stderr, "\n");

  test_load_lxvdsx(alignedinbuf, alignedoutbuf, 0);
  test_load_lxvdsx(&inbuf[1], alignedoutbuf2, 0);
  do_compare(alignedoutbuf, alignedoutbuf2);
  test_load_lxvdsx(alignedinbuf, alignedoutbuf, 1);
  test_load_lxvdsx(&inbuf[1], alignedoutbuf2, 1);
  do_compare(alignedoutbuf, alignedoutbuf2);
  fprintf(stderr, "\n");

  fprintf(stderr, "%d tests failed\n", fails);
  return fails;
}
