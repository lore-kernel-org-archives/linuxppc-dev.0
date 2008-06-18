Return-Path: <johann.baudy@ixwaves.com>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by ozlabs.org (Postfix) with ESMTP id 0F3B0DDEDF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 00:36:18 +1000 (EST)
Message-ID: <48591919.4010502@ixwaves.com>
Date: Wed, 18 Jun 2008 16:18:01 +0200
From: Johann Baudy <johann.baudy@ixwaves.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: gen-mhs-devtree - C_ALL_PIMS_SHARE_ADDRESSES=0 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

I wasn't able to get the FDT generator working with  
C_ALL_PIMS_SHARE_ADDRESSES = 0 (parameter of MPMC) and EDK10.1 SP1 (you 
will find error output below).
It seems that it's not fully supported in FDT TCL script yet!
Indeed, this script is looking for C_MPMC_BASEADDR instead of 
C_PIMX_BASEADDR even if  C_ALL_PIMS_SHARE_ADDRESSES = 0.

#--------------------------------------
# FDT BSP DRC...!
#--------------------------------------
Running generate for OS'es, Drivers and Libraries ...
#--------------------------------------
# FDT BSP generate...
#--------------------------------------
Clock Frequency: 300000000
+++++++++++ 151545648 ++++++++
Bus handle DPLB0 connected through a bus...
-master 151545648 DPLB0 plb ppc405_0
-master 151545648 IPLB0 plb ppc405_0
-slave 153793872 SPLB0 plb DDR_SDRAM_32Mx16
-slave 153793872 SDMA_CTRL1 plb DDR_SDRAM_32Mx16
-slave 153793872 SDMA_CTRL2 plb DDR_SDRAM_32Mx16
-slave 164169800 SPLB plb TriMode_MAC_GMII
-slave 166899408 SPLB plb xps_intc_0
-slave 167195280 SPLB plb common_gpio
-slave 167632152 SPLB plb xps_bram_if_cntlr_0
-slave 168015912 SPLB plb flash_ctrl_0
-slave 168339256 SPLB plb xps_uartlite_0
+++++++++++ 151545648 ++++++++
Bus handle DPLB1 connected directly...
VERSION
ERROR:MDT - fdt () - Bad highaddr for DDR_SDRAM_32Mx16
       while executing
   "error "Bad highaddr for $nodename""
       (procedure "gen_reg_property" line 10)
       invoked from within
   "gen_reg_property $name $baseaddr $highaddr"
       (procedure "memory" line 12)
       invoked from within
   "memory $slave "MPMC_" """
       ("mpmc" arm line 2)
       invoked from within
   "switch $type {
               "plb_bram_if_cntlr" -
               "opb_bram_if_cntlr" {
                   # Ignore these, since they aren't big enough to be main
                   # memory, and we can'..."
       (procedure "gen_memories" line 9)
       invoked from within
   "gen_memories $toplevel $hwproc_handle"
       (procedure "::sw_fdt::generate" line 78)
       invoked from within
   "::sw_fdt::generate 174540912"
ERROR:MDT - Error while running "generate" for processor ppc405_0...
ERROR:MDT - : ld.so: object '/home/johann/Tools/usb_driver/libusb-driver.so'
   from LD_PRELOAD cannot be preloaded: ignored.
make: *** [ppc405_0/lib/libxil.a] Error 2
Done!

I suggest this first draft below to fix it:
 (assuming main bus is connected to PIM0)

--- fdt_v2_1_0.tcl.orig    2008-05-08 19:46:22.000000000 +0200
+++ fdt_v2_1_0.tcl    2008-06-18 15:47:49.000000000 +0200
@@ -475,7 +475,12 @@
         set mpmc_node [lindex $tree 2]
     }]} {
         # No control port
+        set share_addresses [scan_int_parameter_value $slave 
"C_ALL_PIMS_SHARE_ADDRESSES"]
+        if {$share_addresses == 0} {
+            set baseaddr [scan_int_parameter_value $slave 
"C_PIM0_BASEADDR"]
+        } else {
         set baseaddr [scan_int_parameter_value $slave "C_MPMC_BASEADDR"]
+        }
         set tree [slaveip_basic $slave $intc "" [format_ip_name "mpmc" 
$baseaddr] ]
         set ip_name [lindex $tree 0]
         set mpmc_node [lindex $tree 2]
@@ -495,12 +500,12 @@
             # Found an SDMA port
             if {$share_addresses == 0} {
                 set baseaddr [scan_int_parameter_value $slave [format 
"C_SDMA_CTRL%d_BASEADDR" $x]]
+                set highaddr [scan_int_parameter_value $slave [format 
"C_SDMA_CTRL%d_HIGHADDR" $x]]
             } else {
                 set baseaddr [scan_int_parameter_value $slave 
"C_SDMA_CTRL_BASEADDR"]
-            }
             set baseaddr [expr $baseaddr + $x * 0x80]
             set highaddr [expr $baseaddr + 0x7f]
-
+            }
             set sdma_name [format_ip_name sdma $baseaddr "PIM$x"]
             set sdma_tree [list $sdma_name tree {}]
             set sdma_tree [tree_append $sdma_tree [gen_reg_property 
$sdma_name $baseaddr $highaddr]]
@@ -783,7 +788,6 @@
 
     set baseaddr [scan_int_parameter_value $slave [format 
"C_%sBASEADDR" $baseaddr_prefix]]
     set highaddr [scan_int_parameter_value $slave [format 
"C_%sHIGHADDR" $baseaddr_prefix]]
-
     lappend ip_node [gen_reg_property $name $baseaddr $highaddr]
     lappend ip_node [list "device_type" string "memory"]
     set ip_node [gen_params $ip_node $slave $params]
@@ -998,7 +1002,12 @@
                 }
             }
             "mpmc" {
+            set share_addresses [scan_int_parameter_value $slave 
"C_ALL_PIMS_SHARE_ADDRESSES"]
+            if {$share_addresses != 0} {
                 lappend tree [memory $slave "MPMC_" ""]
+                } else {
+                lappend tree [memory $slave "PIM0_" ""]
+                }
                 set memory_count [expr $memory_count + 1]
             }
         }

Best regards,
Johann Baudy

-- 
RT System Engineer - IXWAVES
Johann Baudy
Tel: +33(0)952335121
mail: johann.baudy@ixwaves.com

IXWAVES
220 rue Albert Caquot
Sophia Antipolis
06560
