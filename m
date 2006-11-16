Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 16 Nov 2006 18:23:21 +1100
Subject: [RFC/PATCH 3/9] Add a 'sd' command (spu dump) to xmon to dump spu
	local store
In-Reply-To: <1163661800.406227.631357998554.qpush@cradle>
Message-Id: <20061116072323.8CBF867BCE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a command to xmon to dump the memory of a spu's local store.
This mimics the 'd' command which dumps regular memory, but does
a little hand holding by taking the user supplied address and
finding that offset in the local store for the specified spu.

This makes it easy for example to look at what was executing on a spu:

1:mon> ss
...
Stopped spu 04 (was running)
...
1:mon> sf 4
Dumping spu fields at address c0000000019e0a00:
...
  problem->spu_npc_RW     = 0x228
...
1:mon> sd 4 0x228
d000080080318228 01a00c021cffc408 4020007f217ff488  |........@ ..!...|

Aha, 01a00c02, which is of course rdch $2,$ch24 !

--

Updated to only do the setjmp goo around the spu access, and not
around prdump because it does its own (via mread).

Also the num variable is now common between sf and sd, so you don't
have to keep typing the spu number in if you're repeating commands
on the same spu.

---

 arch/powerpc/xmon/xmon.c |   60 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

Index: cell/arch/powerpc/xmon/xmon.c
===================================================================
--- cell.orig/arch/powerpc/xmon/xmon.c
+++ cell/arch/powerpc/xmon/xmon.c
@@ -217,7 +217,8 @@ Commands:\n\
 #ifdef CONFIG_PPC_CELL
 "  ss	stop execution on all spus\n\
   sr	restore execution on stopped spus\n\
-  sf #	dump spu fields for spu # (in hex)\n"
+  sf  #	dump spu fields for spu # (in hex)\n\
+  sd  #	dump spu local store for spu # (in hex)\n"
 #endif
 "  S	print special registers\n\
   t	print backtrace\n\
@@ -2649,6 +2650,7 @@ struct spu_info {
 	struct spu *spu;
 	u64 saved_mfc_sr1_RW;
 	u32 saved_spu_runcntl_RW;
+	unsigned long dump_addr;
 	u8 stopped_ok;
 };
 
@@ -2668,6 +2670,8 @@ void xmon_register_spus(struct list_head
 
 		spu_info[spu->number].spu = spu;
 		spu_info[spu->number].stopped_ok = 0;
+		spu_info[spu->number].dump_addr = (unsigned long)
+				spu_info[spu->number].spu->local_store;
 	}
 }
 
@@ -2813,9 +2817,43 @@ static void dump_spu_fields(struct spu *
 	DUMP_FIELD(spu, "0x%p", priv2);
 }
 
+static void dump_spu_ls(unsigned long num)
+{
+	unsigned long offset, addr, ls_addr;
+
+	if (setjmp(bus_error_jmp) == 0) {
+		catch_memory_errors = 1;
+		sync();
+		ls_addr = (unsigned long)spu_info[num].spu->local_store;
+		sync();
+		__delay(200);
+	} else {
+		catch_memory_errors = 0;
+		printf("*** Error: accessing spu info for spu %d\n", num);
+		return;
+	}
+	catch_memory_errors = 0;
+
+	if (scanhex(&offset))
+		addr = ls_addr + offset;
+	else
+		addr = spu_info[num].dump_addr;
+
+	if (addr >= ls_addr + LS_SIZE) {
+		printf("*** Error: address outside of local store\n");
+		return;
+	}
+
+	prdump(addr, 64);
+	addr += 64;
+	last_cmd = "sd\n";
+
+	spu_info[num].dump_addr = addr;
+}
+
 static int do_spu_cmd(void)
 {
-	unsigned long num = 0;
+	static unsigned long num = 0;
 	int cmd;
 
 	cmd = inchar();
@@ -2827,10 +2865,22 @@ static int do_spu_cmd(void)
 		restart_spus();
 		break;
 	case 'f':
-		if (scanhex(&num) && num < XMON_NUM_SPUS && spu_info[num].spu)
-			dump_spu_fields(spu_info[num].spu);
-		else
+	case 'd':
+		scanhex(&num);
+		if (num >= XMON_NUM_SPUS || !spu_info[num].spu) {
 			printf("*** Error: invalid spu number\n");
+			return 0;
+		}
+
+		switch (cmd) {
+		case 'f':
+			dump_spu_fields(spu_info[num].spu);
+			break;
+		default:
+			dump_spu_ls(num);
+			break;
+		}
+
 		break;
 	default:
 		return -1;
