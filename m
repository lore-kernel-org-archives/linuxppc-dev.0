Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF0894ptczDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 12:46:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: xmon memory dump does not handle LE
In-Reply-To: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
References: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
Date: Fri, 03 Feb 2017 12:46:16 +1100
Message-ID: <87a8a4avx3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Douglas Miller <dougmill@linux.vnet.ibm.com> writes:

> I was hoping this would be any easy fix, but now it looks like it will 
> be more difficult.
>
> The basic problem is that xmon memory commands like 'dd' do not properly 
> display the data on LE instances. This means that not only is it 
> difficult to read but one cannot copy-paste addresses from the output. 
> This severely encumbers debugging using xmon on LE systems.

What do you mean by "properly"?

I think what you're saying is that dumping bytes of memory on LE doesn't
give you nice u64 pointers, but that's not a bug, that's just how memory
is laid out on LE.

Also memory isn't always filled with u64 pointers, so just byte swapping
at that size is not correct. Sometimes you'll be looking at ints, in
which case you need to swap 4 bytes at a time.

What we need is dump commands that do a byte swap of a given size.
Balbir was working on this but I think he got diverted.

His first attempt was here: https://patchwork.ozlabs.org/patch/696348/
 
But as I said in my reply:

  So as discussed, lets add d1, d2, d4, d8, which dump 1/2/4/8 bytes at a
  time, in cpu endian, and which each value separated by space.


Here's a quick hack to get it going. Let me know if that works for you,
it's not pretty, but we could probably merge it with a bit of cleanup.

cheers


diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a44b049b9cf6..3903af5fe276 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2334,10 +2334,43 @@ static void dump_pacas(void)
 }
 #endif
 
+static void dump_by_size(unsigned long addr, long count, int size)
+{
+	unsigned char temp[16];
+	int i, j;
+	u64 val;
+
+	count = ALIGN(count, 16);
+
+	for (i = 0; i < count; i += 16, addr += 16) {
+		printf(REG, addr);
+
+		if (mread(addr, temp, 16) != 16) {
+			printf("Faulted reading %d bytes from 0x"REG"\n", 16, addr);
+			return;
+		}
+
+		for (j = 0; j < 16; j += size) {
+			putchar(' ');
+			switch (size) {
+			case 1: val = temp[j]; break;
+			case 2: val = *(u16 *)&temp[j]; break;
+			case 4: val = *(u32 *)&temp[j]; break;
+			case 8: val = *(u64 *)&temp[j]; break;
+			default: val = 0;
+			}
+
+			printf("%0*lx", size * 2, val);
+		}
+
+		printf("\n");
+	}
+}
+
 static void
 dump(void)
 {
-	int c;
+	int size, c;
 
 	c = inchar();
 
@@ -2350,8 +2383,9 @@ dump(void)
 	}
 #endif
 
-	if ((isxdigit(c) && c != 'f' && c != 'd') || c == '\n')
+	if (c == '\n')
 		termch = c;
+
 	scanhex((void *)&adrs);
 	if (termch != '\n')
 		termch = 0;
@@ -2383,9 +2417,21 @@ dump(void)
 			ndump = 64;
 		else if (ndump > MAX_DUMP)
 			ndump = MAX_DUMP;
-		prdump(adrs, ndump);
+
+		size = 0;
+		switch (c) {
+		case '8': size += 4;
+		case '4': size += 2;
+		case '2': size += 1;
+		case '1': size += 1;
+			dump_by_size(adrs, ndump, size);
+			break;
+		default:
+			prdump(adrs, ndump);
+			last_cmd = "d\n";
+		}
+
 		adrs += ndump;
-		last_cmd = "d\n";
 	}
 }
 
