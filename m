Return-Path: <johndavi@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e32.co.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8631967A84
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Feb 2005 11:54:42 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j170sbH5021686
	for <linuxppc-embedded@ozlabs.org>; Sun, 6 Feb 2005 19:54:37 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j170sboS426198
	for <linuxppc-embedded@ozlabs.org>; Sun, 6 Feb 2005 17:54:37 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j170sbYm028930
	for <linuxppc-embedded@ozlabs.org>; Sun, 6 Feb 2005 17:54:37 -0700
Received: from d03nm113.boulder.ibm.com (d03nm113.boulder.ibm.com
	[9.17.195.139])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j170sb8C028927
	for <linuxppc-embedded@ozlabs.org>; Sun, 6 Feb 2005 17:54:37 -0700
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFE767162F.E9B109B8-ON87256FA1.0004F827-85256FA1.00050D37@us.ibm.com>
From: John F Davis <johndavi@us.ibm.com>
Date: Sun, 6 Feb 2005 17:54:35 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 00050CAD85256FA1_="
Subject: Fw: IDE DMA on ppc405 with via VT82C686
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 00050CAD85256FA1_=
Content-Type: text/plain; charset="US-ASCII"

----- Forwarded by John F Davis/Raleigh/IBM on 02/06/2005 07:54 PM -----

John F Davis/Raleigh/IBM 
02/06/2005 03:41 PM

To
linuxppc-embedded-bounces@ozlabs.org
cc
andre@linux-ide.org, vojtech@suse.cz, maratbn@yahoo.com, 
jean-luc.coulon@fnac.net
Subject
IDE DMA on ppc405 with via VT82C686





Hello

I am still trying to get this IDE DMA code working.  I have modified 
(hacked) the ide_build_dmatable so that it flushes the buffer for each 
range of 
memory that is modified by the dma bus master.  I am certain I have 
flushed
the cache properly as shown below, but the problem persists.

Below are two traces.  The first one is from my 
log buffer utility which shows the operation of the modified 
ide_build_dmatable routine.
The second one is from the logic analyzer and it corresponds to the first
dma operation. 

Lastly, I have the entire ide_build_dmatable routine for reference as
well as the resulting ksymoops.  Note, this code appears to be rock solid
for running multiple consecutive hdparm tests.  ie. enable dma and then
issue "while true; do hdparm -t /dev/hda; done" in four logins to the 
target
with ssh.

However, I get the oops when I start playback of a video in Xine from
the disk.

I am at the point now, where my next task is to try this board with a 
different
IDE controller and see if its a problem with the IDE DMA code for this
non cache coherent processor or if its a problem in the VIA driver.

JD


Truncated portion of my log buffer.
----------------------------------------------------

IBM john f. davis utils
**************************************
ide_build_dmatable
ide_build_sglist
sg_table -> dma/prd table 16
bcount = f000 
table (cpu view) = b2009000 (bus view) = fefd000
        cpu view addr [b2009000] = 10c00e
        cpu view data [b2009004] = 100000
        bus view addr [fefd000] = ec01000
        bus view data [fefd004] = 1000
flush_dcache_range (aec01000, aec02000)
sg_table -> dma/prd table 15
bcount = 10000 
table (cpu view) = b2009008 (bus view) = fefd008
        cpu view addr [b2009008] = c00e
        cpu view data [b200900c] = 100000
        bus view addr [fefd008] = ec00000
        bus view data [fefd00c] = 1000
flush_dcache_range (aec00000, aec01000)
sg_table -> dma/prd table 14
bcount = 1000 
table (cpu view) = b2009010 (bus view) = fefd010
        cpu view addr [b2009010] = f0bf0e
        cpu view data [b2009014] = 100000
        bus view addr [fefd010] = ebff000
        bus view data [fefd014] = 1000
flush_dcache_range (aebff000, aec00000)
...
...




Truncated portion of Logic Analyzer Trace
----------------------------------------------------

Listing(Listing<1>) - 22 May 2003 (23:45)

State Number        ADDR           FUTUREPLUS SYSTEMS c 1996 
Decimal             Hex            PCI BUS TRANSACTIONS REV 1.2 
________________    ___________    ____________________________________ 

...
...  
44                  0000FFD4       I/O WRITE ADR=0000FFD4 
45                  0FEFD000          D32=0FEFD000 
46                  0FEFD000       IDLE 
47                  0000FFD4       IDLE 
 
...
...
...  
71                  0FEFD000       MEM READ ADR=0FEFD000 
72                  0BF9D000          STOP-NO DATA XFERED-RETRY 
 
73                  0FEFD000       MEM READ ADR=0FEFD000 
74                  0EC01000          D32=0EC01000 
75                  00001000          D32=00001000 
76                  00001000       IDLE 
77                  00001000       IDLE 
 
78                  000000A1       I/O WRITE ADR=000000A1 
79                  3F3F3F3F          D32=xxxx3Fxx          STOP# 
80                  3F3F3F3F       IDLE 
81                  000000A1       IDLE 
 
82                  00000021       I/O WRITE ADR=00000021 
83                  F9F9F9F9          D32=xxxxF9xx          STOP# 
84                  F9F9F9F9       IDLE 
85                  00000021       IDLE 
 
86                  0EC01000       MEM WRITE ADR=0EC01000 
87                  1000B8FA          D32=1000B8FA 
88                  00BCD08E          D32=00BCD08E 
89                  0000B8B0          D32=0000B8B0 
90                  C08ED88E          D32=C08ED88E 
91                  7C00BEFB          D32=7C00BEFB 
92                  B90600BF          D32=B90600BF 


Modified ide_build_dma_table routine
----------------------------------------------------


/* JFD NOTES
 * This is called second after the dma_read is started.
 */ 
int ide_build_dmatable (ide_drive_t *drive, struct request *rq, int ddir)
{
        ide_hwif_t *hwif        = HWIF(drive);
        unsigned int *table     = hwif->dmatable_cpu;  /* JFD Blach table 
gets the non cached memory */
        volatile unsigned int *tableJFD;
        unsigned int is_trm290  = (hwif->chipset == ide_trm290) ? 1 : 0;
        unsigned int count = 0;
        unsigned int countJFD;
        int i,m;
        struct scatterlist *sg;
        unsigned int *prd_entry;
        unsigned int flush_start_addr;
        unsigned int flush_length;
 

//      jd_print_it("ide_build_dmatable\n");

        if (rq->cmd == IDE_DRIVE_TASKFILE) {
                printk("calling ide_raw_build_sglist\n");
                hwif->sg_nents = i = ide_raw_build_sglist(hwif, rq);
        } else {
                /* JFD we call this routine each time */
                // printk("calling ide_build_sglist\n");
                hwif->sg_nents = i = ide_build_sglist(hwif, rq, ddir);
        }


        if (!i)
                return 0;

        sg = hwif->sg_table;
        while (i && sg_dma_len(sg)) {
                u32 cur_addr;
                u32 cur_len;

                cur_addr = sg_dma_address(sg);  /* jfd blach these are 
real addresses */
                cur_len = sg_dma_len(sg);
//              jd_print_it("sg_table -> dma/PRD table %i\n", i);

                /*
                 * Fill in the dma table, without crossing any 64kB 
boundaries.
                 * Most hardware requires 16-bit alignment of all blocks,
                 * but the trm290 requires 32-bit alignment.
                 */

                while (cur_len) {
                        tableJFD=table;
                        if (count++ >= PRD_ENTRIES) {
                                printk("%s: DMA table too small\n", 
drive->name);
                                goto use_pio_instead;
                        } else {
                                u32 xcount, bcount = 0x10000 - (cur_addr & 
0xffff);

                                jd_print_it("bcount = %x \n",bcount);
                                if (bcount > cur_len)
                                        bcount = cur_len;

                                // JFD writes the address to the PRD table
                                *table++ = cpu_to_le32(cur_addr);
                                xcount = bcount & 0xffff;
                                countJFD=xcount;
                                if (is_trm290)
                                        xcount = ((xcount >> 2) - 1) << 
16;
                                if (xcount == 0x0000) {
        /* 
         * Most chipsets correctly interpret a length of 0x0000 as 64KB,
         * but at least one (e.g. CS5530) misinterprets it as zero (!).
         * So here we break the 64KB entry into two 32KB entries instead.
         */
                                        if (count++ >= PRD_ENTRIES) {
                                                printk("%s: DMA table too 
small\n", drive->name);
                                                goto use_pio_instead;
                                        }
 
                                        // JFD Write the truncated length 
to the PRD table
                                        *table++ = cpu_to_le32(0x8000);
                                        // JFD Write the address for the 
next truncated length to the PRD table
                                        *table++ = cpu_to_le32(cur_addr + 
0x8000);
                                        xcount = 0x8000;

// cut out the logging for real test
#if 0

                                        jd_print_it("table-trunc (cpu 
view) = %x (bus view) = %x\n",tableJFD, virt_to_bus(tableJFD));
                                        jd_print_it("\tCPU View ADDR [%x] 
= %x\n",tableJFD, *tableJFD);
                                        jd_print_it("\tCPU View DATA [%x] 
= %x\n",tableJFD+1, *(tableJFD+1));

                                        jd_print_it("\tBUS View ADDR [%x] 
= %x\n",virt_to_bus(tableJFD), le32_to_cpu(*tableJFD));
                                        jd_print_it("\tBUS View DATA [%x] 
= %x\n",virt_to_bus(tableJFD+1), le32_to_cpu(*(tableJFD+1)));

#endif
                                        flush_start_addr = 
bus_to_virt((unsigned int *)le32_to_cpu(*tableJFD));
                                        flush_length = 
le32_to_cpu(*(tableJFD+1));

//                                      jd_print_it("flush_dcache_range 
(%x, %x)\n", flush_start_addr, flush_start_addr + flush_length);
                                        flush_dcache_range 
(flush_start_addr, flush_start_addr + flush_length );
  
                                        // have to increment  our pointer 
to the next PRD address loc as well.
                                        tableJFD++;
                                        tableJFD++;
                                }


                                // JFD Write the length (could be trucated 
per above) to the PRD table
                                *table++ = cpu_to_le32(xcount);
                                cur_addr += bcount;
                                cur_len -= bcount;
                        }

// cut out the logging for real test.
#if 0
                                        jd_print_it("table (cpu view) = %x 
(bus view) = %x\n",tableJFD, virt_to_bus(tableJFD));
                                        jd_print_it("\tCPU View ADDR [%x] 
= %x\n",tableJFD, *tableJFD);
                                        jd_print_it("\tCPU View DATA [%x] 
= %x\n",tableJFD+1, *(tableJFD+1));

                                        jd_print_it("\tBUS View ADDR [%x] 
= %x\n",virt_to_bus(tableJFD), le32_to_cpu(*tableJFD));
                                        jd_print_it("\tBUS View DATA [%x] 
= %x\n",virt_to_bus(tableJFD+1), le32_to_cpu(*(tableJFD+1)));

#endif
                                        flush_start_addr = 
bus_to_virt((unsigned int *)le32_to_cpu(*tableJFD));
                                        flush_length = 
le32_to_cpu(*(tableJFD+1));

//                                      jd_print_it("flush_dcache_range 
(%x, %x)\n", flush_start_addr, flush_start_addr + flush_length);
                                        flush_dcache_range 
(flush_start_addr, flush_start_addr + flush_length );


 
#if 0
                        // Lets try to read that address into a variable 
to see if it "flushes that cache entry"
                        for (m=0; m< 0x1000;m++) {
                                ulFoo = *(unsigned int*) 
bus_to_virt(le32_to_cpu(*tableJFD++));
                        }
#endif

                }




                sg++;
                i--;
        }

        if (count) {
                if (!is_trm290)
                        *--table |= cpu_to_le32(0x80000000);
                return count;
        }
        printk("%s: empty DMA table?\n", drive->name);
use_pio_instead:
        pci_unmap_sg(hwif->pci_dev,
                     hwif->sg_table,
                     hwif->sg_nents,
                     hwif->sg_dma_direction);
        hwif->sg_dma_active = 0;
        return 0; /* revert to PIO for this request */
}




Ksymoops dump
----------------------------------------------------

003AF9C A002F770 A002EC18 A003B14C A003B288 A003B5E8 A003C1E4 
AA003AF9C A002F770 A002EC18 A003B14C A003B288 A003B5E8 A003C1E4 
007CA8C A0027690 A0028044 A0028518 A0028A5C A003840C A000279C 
0A007CA8C A0027690 A0028044 A0028518 A0028A5C A003840C A000279C 
FECCB68 0F833B80 0F59D02C 0F59D298 0F59C830 0FF5B278 0FEC7914 
00FECCB68 0F833B80 0F59D02C 0F59D298 0F59C830 0FF5B278 0FEC7914 
FC0B408 
0FC0B408 
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; a002fc68 <kmem_find_general_cachep+da4/2bb4>   <=====

>>GPR1; ac803cf0 <_end+c55ffc8/125f6420>
>>GPR2; ac802000 <_end+c55e2d8/125f6420>
>>GPR3; a02eb1c8 <_end+474a0/125f6420>
>>GPR4; ac0b4000 <_end+be102d8/125f6420>
>>GPR9; ac12c020 <_end+be882f8/125f6420>
>>GPR11; a02eb1d0 <_end+474a8/125f6420>
>>GPR18; a00288ec <do_generic_file_read+74c/814>
>>GPR19; ad3fc834 <_end+d158b0c/125f6420>
>>GPR20; ac803ed8 <_end+c5601b0/125f6420>
>>GPR21; a007c768 <journal_blocks_per_page+4390/8868>
>>GPR25; a04ff860 <_end+25bb38/125f6420>
>>GPR29; a02eb1c8 <_end+474a0/125f6420>
>>GPR30; ac0b4f60 <_end+be11238/125f6420>
>>GPR31; a02eb1c8 <_end+474a0/125f6420>

Trace; a003af9c <bread+10/138>
Trace; a002f770 <kmem_find_general_cachep+8ac/2bb4>
Trace; a002ec18 <kmem_cache_alloc+10/20>
Trace; a003b14c <get_unused_buffer_head+68/c8>
Trace; a003b288 <set_bh_page+dc/350>
Trace; a003b5e8 <create_empty_buffers+24/960>
Trace; a003c1e4 <block_read_full_page+2c0/2ec>
Trace; a007ca8c <journal_blocks_per_page+46b4/8868>
Trace; a0027690 <filemap_fdatawait+424/4ec>
Trace; a0028044 <grab_cache_page_nowait+230/38c>
Trace; a0028518 <do_generic_file_read+378/814>
Trace; a0028a5c <generic_file_read+a8/9e4>
Trace; a003840c <default_llseek+340/e28>
Trace; a000279c <set_context+3b4/5e0>
Trace; 0feccb68 Before first symbol
Trace; 0f833b80 Before first symbol
Trace; 0f59d02c Before first symbol
Trace; 0f59d298 Before first symbol
Trace; 0f59c830 Before first symbol
Trace; 0ff5b278 Before first symbol
Trace; 0fec7914 Before first symbol
Trace; 0fc0b408 Before first symbol


5 warnings and 2 errors issued.  Results may not be reliable.


--=_alternative 00050CAD85256FA1_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=1 color=#800080 face="sans-serif">----- Forwarded by John
F Davis/Raleigh/IBM on 02/06/2005 07:54 PM -----</font>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>John F Davis/Raleigh/IBM</b>
</font>
<p><font size=1 face="sans-serif">02/06/2005 03:41 PM</font>
<td width=59%>
<table width=100%>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td valign=top><font size=1 face="sans-serif">linuxppc-embedded-bounces@ozlabs.org</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td valign=top><font size=1 face="sans-serif">andre@linux-ide.org, vojtech@suse.cz,
maratbn@yahoo.com, jean-luc.coulon@fnac.net</font>
<tr>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td valign=top><font size=1 face="sans-serif">IDE DMA on ppc405 with via
VT82C686</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br><font size=2 face="sans-serif">Hello</font>
<br>
<br><font size=2 face="sans-serif">I am still trying to get this IDE DMA
code working. &nbsp;I have modified </font>
<br><font size=2 face="sans-serif">(hacked) the ide_build_dmatable so that
it flushes the buffer for each range of </font>
<br><font size=2 face="sans-serif">memory that is modified by the dma bus
master. &nbsp;I am certain I have flushed</font>
<br><font size=2 face="sans-serif">the cache properly as shown below, but
the problem persists.</font>
<br>
<br><font size=2 face="sans-serif">Below are two traces. &nbsp;The first
one is from my </font>
<br><font size=2 face="sans-serif">log buffer utility which shows the operation
of the modified ide_build_dmatable routine.</font>
<br><font size=2 face="sans-serif">The second one is from the logic analyzer
and it corresponds to the first</font>
<br><font size=2 face="sans-serif">dma operation. </font>
<br>
<br><font size=2 face="sans-serif">Lastly, I have the entire ide_build_dmatable
routine for reference as</font>
<br><font size=2 face="sans-serif">well as the resulting ksymoops. &nbsp;Note,
this code appears to be rock solid</font>
<br><font size=2 face="sans-serif">for running multiple consecutive hdparm
tests. &nbsp;ie. enable dma and then</font>
<br><font size=2 face="sans-serif">issue &quot;while true; do hdparm -t
/dev/hda; done&quot; in four logins to the target</font>
<br><font size=2 face="sans-serif">with ssh.</font>
<br>
<br><font size=2 face="sans-serif">However, I get the oops when I start
playback of a video in Xine from</font>
<br><font size=2 face="sans-serif">the disk.</font>
<br>
<br><font size=2 face="sans-serif">I am at the point now, where my next
task is to try this board with a different</font>
<br><font size=2 face="sans-serif">IDE controller and see if its a problem
with the IDE DMA code for this</font>
<br><font size=2 face="sans-serif">non cache coherent processor or if its
a problem in the VIA driver.</font>
<br>
<br><font size=2 face="sans-serif">JD</font>
<br>
<br>
<br><font size=2 face="sans-serif">Truncated portion of my log buffer.</font>
<br><font size=2 face="sans-serif">----------------------------------------------------</font>
<br>
<br><font size=2 face="sans-serif">IBM john f. davis utils</font>
<br><font size=2 face="sans-serif">**************************************</font>
<br><font size=2 face="sans-serif">ide_build_dmatable</font>
<br><font size=2 face="sans-serif">ide_build_sglist</font>
<br><font size=2 face="sans-serif">sg_table -&gt; dma/prd table 16</font>
<br><font size=2 face="sans-serif">bcount = f000 </font>
<br><font size=2 face="sans-serif">table (cpu view) = b2009000 (bus view)
= fefd000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cpu
view addr [b2009000] = 10c00e</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cpu
view data [b2009004] = 100000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus
view addr [fefd000] = ec01000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus
view data [fefd004] = 1000</font>
<br><font size=2 face="sans-serif">flush_dcache_range (aec01000, aec02000)</font>
<br><font size=2 face="sans-serif">sg_table -&gt; dma/prd table 15</font>
<br><font size=2 face="sans-serif">bcount = 10000 </font>
<br><font size=2 face="sans-serif">table (cpu view) = b2009008 (bus view)
= fefd008</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cpu
view addr [b2009008] = c00e</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cpu
view data [b200900c] = 100000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus
view addr [fefd008] = ec00000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus
view data [fefd00c] = 1000</font>
<br><font size=2 face="sans-serif">flush_dcache_range (aec00000, aec01000)</font>
<br><font size=2 face="sans-serif">sg_table -&gt; dma/prd table 14</font>
<br><font size=2 face="sans-serif">bcount = 1000 </font>
<br><font size=2 face="sans-serif">table (cpu view) = b2009010 (bus view)
= fefd010</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cpu
view addr [b2009010] = f0bf0e</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cpu
view data [b2009014] = 100000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus
view addr [fefd010] = ebff000</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; bus
view data [fefd014] = 1000</font>
<br><font size=2 face="sans-serif">flush_dcache_range (aebff000, aec00000)</font>
<br><font size=2 face="sans-serif">...</font>
<br><font size=2 face="sans-serif">...</font>
<br>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Truncated portion of Logic Analyzer
Trace</font>
<br><font size=2 face="sans-serif">----------------------------------------------------</font>
<br>
<br><font size=2 face="sans-serif">Listing(Listing&lt;1&gt;) - 22 May 2003
(23:45)</font>
<br>
<br><font size=2 face="sans-serif">State Number &nbsp; &nbsp; &nbsp; &nbsp;ADDR
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FUTUREPLUS SYSTEMS c 1996 &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">Decimal &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; Hex &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;PCI BUS TRANSACTIONS
REV 1.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">________________ &nbsp; &nbsp;___________
&nbsp; &nbsp;____________________________________ &nbsp; &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">...</font>
<br><font size=2 face="sans-serif">... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">44 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0000FFD4 &nbsp; &nbsp; &nbsp; I/O WRITE ADR=0000FFD4
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">45 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0FEFD000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=0FEFD000
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">46 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0FEFD000 &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">47 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0000FFD4 &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">...</font>
<br><font size=2 face="sans-serif">...</font>
<br><font size=2 face="sans-serif">... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">71 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0FEFD000 &nbsp; &nbsp; &nbsp; MEM READ ADR=0FEFD000
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">72 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0BF9D000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;STOP-NO
DATA XFERED-RETRY &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">73 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0FEFD000 &nbsp; &nbsp; &nbsp; MEM READ ADR=0FEFD000
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">74 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0EC01000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=0EC01000
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">75 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;00001000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=00001000
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">76 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;00001000 &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">77 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;00001000 &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">78 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;000000A1 &nbsp; &nbsp; &nbsp; I/O WRITE ADR=000000A1
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">79 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;3F3F3F3F &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=xxxx3Fxx
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;STOP# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">80 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;3F3F3F3F &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">81 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;000000A1 &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">82 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;00000021 &nbsp; &nbsp; &nbsp; I/O WRITE ADR=00000021
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">83 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;F9F9F9F9 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=xxxxF9xx
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;STOP# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">84 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;F9F9F9F9 &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">85 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;00000021 &nbsp; &nbsp; &nbsp; IDLE &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">86 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0EC01000 &nbsp; &nbsp; &nbsp; MEM WRITE ADR=0EC01000
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=2 face="sans-serif">87 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;1000B8FA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=1000B8FA
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">88 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;00BCD08E &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=00BCD08E
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">89 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0000B8B0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=0000B8B0
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">90 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;C08ED88E &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=C08ED88E
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">91 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;7C00BEFB &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=7C00BEFB
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">92 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;B90600BF &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D32=B90600BF
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br>
<br>
<br><font size=2 face="sans-serif">Modified ide_build_dma_table routine</font>
<br><font size=2 face="sans-serif">----------------------------------------------------</font>
<br>
<br>
<br><font size=2 face="sans-serif">/* JFD NOTES</font>
<br><font size=2 face="sans-serif">&nbsp;* This is called second after
the dma_read is started.</font>
<br><font size=2 face="sans-serif">&nbsp;*/ </font>
<br><font size=2 face="sans-serif">int ide_build_dmatable (ide_drive_t
*drive, struct request *rq, int ddir)</font>
<br><font size=2 face="sans-serif">{</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; ide_hwif_t
*hwif &nbsp; &nbsp; &nbsp; &nbsp;= HWIF(drive);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; unsigned
int *table &nbsp; &nbsp; &nbsp; &nbsp;= hwif-&gt;dmatable_cpu;
&nbsp;/* JFD Blach table gets the non cached memory */</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; volatile
unsigned int *tableJFD;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; unsigned
int is_trm290 &nbsp; &nbsp; &nbsp; &nbsp;= (hwif-&gt;chipset ==
ide_trm290) ? 1 : 0;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; unsigned
int count = 0;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; unsigned
int countJFD;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; int
i,m;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; struct
scatterlist *sg;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; unsigned
int *prd_entry;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; unsigned
int flush_start_addr;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; unsigned
int flush_length;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br>
<br><font size=2 face="sans-serif">// &nbsp; &nbsp; &nbsp; &nbsp;jd_print_it(&quot;ide_build_dmatable\n&quot;);</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; if
(rq-&gt;cmd == IDE_DRIVE_TASKFILE) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; printk(&quot;calling ide_raw_build_sglist\n&quot;);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; hwif-&gt;sg_nents = i = ide_raw_build_sglist(hwif,
rq);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; }
else {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; /* JFD we call this routine each time */</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; // printk(&quot;calling ide_build_sglist\n&quot;);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; hwif-&gt;sg_nents = i = ide_build_sglist(hwif,
rq, ddir);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; }</font>
<br>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; if
(!i)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; return 0;</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; sg
= hwif-&gt;sg_table;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; while
(i &amp;&amp; sg_dma_len(sg)) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; u32 cur_addr;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; u32 cur_len;</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; cur_addr = sg_dma_address(sg); &nbsp;/* jfd
blach these are real addresses */</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; cur_len = sg_dma_len(sg);</font>
<br><font size=2 face="sans-serif">// &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;jd_print_it(&quot;sg_table -&gt; dma/PRD
table %i\n&quot;, i);</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; /*</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;* Fill in the dma table, without crossing
any 64kB boundaries.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;* Most hardware requires 16-bit alignment
of all blocks,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;* but the trm290 requires 32-bit alignment.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;*/</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; while (cur_len) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tableJFD=table;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (count++
&gt;= PRD_ENTRIES) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; printk(&quot;%s: DMA table too small\n&quot;,
drive-&gt;name);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; goto use_pio_instead;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else
{</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; u32 xcount, bcount = 0x10000 - (cur_addr &amp;
0xffff);</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; jd_print_it(&quot;bcount = %x \n&quot;,bcount);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; if (bcount &gt; cur_len)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bcount
= cur_len;</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; // JFD writes the address to the PRD table</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; *table++ = cpu_to_le32(cur_addr);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; xcount = bcount &amp; 0xffff;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; countJFD=xcount;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; if (is_trm290)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; xcount
= ((xcount &gt;&gt; 2) - 1) &lt;&lt; 16;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; if (xcount == 0x0000) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; /*
</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
Most chipsets correctly interpret a length of 0x0000 as 64KB,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
but at least one (e.g. CS5530) misinterprets it as zero (!).</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*
So here we break the 64KB entry into two 32KB entries instead.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (count++
&gt;= PRD_ENTRIES) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; printk(&quot;%s: DMA table too small\n&quot;,
drive-&gt;name);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; goto use_pio_instead;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // JFD
Write the truncated length to the PRD table</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *table++
= cpu_to_le32(0x8000);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // JFD
Write the address for the next truncated length to the PRD table</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *table++
= cpu_to_le32(cur_addr + 0x8000);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; xcount
= 0x8000;</font>
<br>
<br><font size=2 face="sans-serif">// cut out the logging for real test</font>
<br><font size=2 face="sans-serif">#if 0</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;table-trunc
(cpu view) = %x (bus view) = %x\n&quot;,tableJFD, virt_to_bus(tableJFD));</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tCPU
View ADDR [%x] = %x\n&quot;,tableJFD, *tableJFD);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tCPU
View DATA [%x] = %x\n&quot;,tableJFD+1, *(tableJFD+1));</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tBUS
View ADDR [%x] = %x\n&quot;,virt_to_bus(tableJFD), le32_to_cpu(*tableJFD));</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tBUS
View DATA [%x] = %x\n&quot;,virt_to_bus(tableJFD+1), le32_to_cpu(*(tableJFD+1)));</font>
<br>
<br><font size=2 face="sans-serif">#endif</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; flush_start_addr
= bus_to_virt((unsigned int *)le32_to_cpu(*tableJFD));</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; flush_length
= le32_to_cpu(*(tableJFD+1));</font>
<br>
<br><font size=2 face="sans-serif">// &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;jd_print_it(&quot;flush_dcache_range
(%x, %x)\n&quot;, flush_start_addr, flush_start_addr + flush_length);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; flush_dcache_range
(flush_start_addr, flush_start_addr + flush_length );</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // have
to increment &nbsp;our pointer to the next PRD address loc as well.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tableJFD++;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tableJFD++;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; }</font>
<br>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; // JFD Write the length (could be trucated
per above) to the PRD table</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; *table++ = cpu_to_le32(xcount);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; cur_addr += bcount;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; cur_len -= bcount;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</font>
<br>
<br><font size=2 face="sans-serif">// cut out the logging for real test.</font>
<br><font size=2 face="sans-serif">#if 0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;table
(cpu view) = %x (bus view) = %x\n&quot;,tableJFD, virt_to_bus(tableJFD));</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tCPU
View ADDR [%x] = %x\n&quot;,tableJFD, *tableJFD);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tCPU
View DATA [%x] = %x\n&quot;,tableJFD+1, *(tableJFD+1));</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tBUS
View ADDR [%x] = %x\n&quot;,virt_to_bus(tableJFD), le32_to_cpu(*tableJFD));</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; jd_print_it(&quot;\tBUS
View DATA [%x] = %x\n&quot;,virt_to_bus(tableJFD+1), le32_to_cpu(*(tableJFD+1)));</font>
<br>
<br><font size=2 face="sans-serif">#endif</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; flush_start_addr
= bus_to_virt((unsigned int *)le32_to_cpu(*tableJFD));</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; flush_length
= le32_to_cpu(*(tableJFD+1));</font>
<br>
<br><font size=2 face="sans-serif">// &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;jd_print_it(&quot;flush_dcache_range
(%x, %x)\n&quot;, flush_start_addr, flush_start_addr + flush_length);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; flush_dcache_range
(flush_start_addr, flush_start_addr + flush_length );</font>
<br>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=2 face="sans-serif">#if 0</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // Lets
try to read that address into a variable to see if it &quot;flushes that
cache entry&quot;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for (m=0;
m&lt; 0x1000;m++) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; ulFoo = *(unsigned int*) bus_to_virt(le32_to_cpu(*tableJFD++));</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</font>
<br><font size=2 face="sans-serif">#endif</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; }</font>
<br>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; sg++;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; i--;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; }</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; if
(count) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; if (!is_trm290)</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *--table
|= cpu_to_le32(0x80000000);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; return count;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; }</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; printk(&quot;%s:
empty DMA table?\n&quot;, drive-&gt;name);</font>
<br><font size=2 face="sans-serif">use_pio_instead:</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; pci_unmap_sg(hwif-&gt;pci_dev,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;hwif-&gt;sg_table,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;hwif-&gt;sg_nents,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;hwif-&gt;sg_dma_direction);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; hwif-&gt;sg_dma_active
= 0;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; return
0; /* revert to PIO for this request */</font>
<br><font size=2 face="sans-serif">}</font>
<br>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Ksymoops dump</font>
<br><font size=2 face="sans-serif">----------------------------------------------------</font>
<br>
<br><font size=2 face="sans-serif">003AF9C A002F770 A002EC18 A003B14C A003B288
A003B5E8 A003C1E4 </font>
<br><font size=2 face="sans-serif">AA003AF9C A002F770 A002EC18 A003B14C
A003B288 A003B5E8 A003C1E4 </font>
<br><font size=2 face="sans-serif">007CA8C A0027690 A0028044 A0028518 A0028A5C
A003840C A000279C </font>
<br><font size=2 face="sans-serif">0A007CA8C A0027690 A0028044 A0028518
A0028A5C A003840C A000279C </font>
<br><font size=2 face="sans-serif">FECCB68 0F833B80 0F59D02C 0F59D298 0F59C830
0FF5B278 0FEC7914 </font>
<br><font size=2 face="sans-serif">00FECCB68 0F833B80 0F59D02C 0F59D298
0F59C830 0FF5B278 0FEC7914 </font>
<br><font size=2 face="sans-serif">FC0B408 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">0FC0B408 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; </font>
<br><font size=2 face="sans-serif">Warning (Oops_read): Code line not seen,
dumping what data is available</font>
<br>
<br>
<br><font size=2 face="sans-serif">&gt;&gt;NIP; a002fc68 &lt;kmem_find_general_cachep+da4/2bb4&gt;
&nbsp; &lt;=====</font>
<br>
<br><font size=2 face="sans-serif">&gt;&gt;GPR1; ac803cf0 &lt;_end+c55ffc8/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR2; ac802000 &lt;_end+c55e2d8/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR3; a02eb1c8 &lt;_end+474a0/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR4; ac0b4000 &lt;_end+be102d8/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR9; ac12c020 &lt;_end+be882f8/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR11; a02eb1d0 &lt;_end+474a8/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR18; a00288ec &lt;do_generic_file_read+74c/814&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR19; ad3fc834 &lt;_end+d158b0c/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR20; ac803ed8 &lt;_end+c5601b0/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR21; a007c768 &lt;journal_blocks_per_page+4390/8868&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR25; a04ff860 &lt;_end+25bb38/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR29; a02eb1c8 &lt;_end+474a0/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR30; ac0b4f60 &lt;_end+be11238/125f6420&gt;</font>
<br><font size=2 face="sans-serif">&gt;&gt;GPR31; a02eb1c8 &lt;_end+474a0/125f6420&gt;</font>
<br>
<br><font size=2 face="sans-serif">Trace; a003af9c &lt;bread+10/138&gt;</font>
<br><font size=2 face="sans-serif">Trace; a002f770 &lt;kmem_find_general_cachep+8ac/2bb4&gt;</font>
<br><font size=2 face="sans-serif">Trace; a002ec18 &lt;kmem_cache_alloc+10/20&gt;</font>
<br><font size=2 face="sans-serif">Trace; a003b14c &lt;get_unused_buffer_head+68/c8&gt;</font>
<br><font size=2 face="sans-serif">Trace; a003b288 &lt;set_bh_page+dc/350&gt;</font>
<br><font size=2 face="sans-serif">Trace; a003b5e8 &lt;create_empty_buffers+24/960&gt;</font>
<br><font size=2 face="sans-serif">Trace; a003c1e4 &lt;block_read_full_page+2c0/2ec&gt;</font>
<br><font size=2 face="sans-serif">Trace; a007ca8c &lt;journal_blocks_per_page+46b4/8868&gt;</font>
<br><font size=2 face="sans-serif">Trace; a0027690 &lt;filemap_fdatawait+424/4ec&gt;</font>
<br><font size=2 face="sans-serif">Trace; a0028044 &lt;grab_cache_page_nowait+230/38c&gt;</font>
<br><font size=2 face="sans-serif">Trace; a0028518 &lt;do_generic_file_read+378/814&gt;</font>
<br><font size=2 face="sans-serif">Trace; a0028a5c &lt;generic_file_read+a8/9e4&gt;</font>
<br><font size=2 face="sans-serif">Trace; a003840c &lt;default_llseek+340/e28&gt;</font>
<br><font size=2 face="sans-serif">Trace; a000279c &lt;set_context+3b4/5e0&gt;</font>
<br><font size=2 face="sans-serif">Trace; 0feccb68 Before first symbol</font>
<br><font size=2 face="sans-serif">Trace; 0f833b80 Before first symbol</font>
<br><font size=2 face="sans-serif">Trace; 0f59d02c Before first symbol</font>
<br><font size=2 face="sans-serif">Trace; 0f59d298 Before first symbol</font>
<br><font size=2 face="sans-serif">Trace; 0f59c830 Before first symbol</font>
<br><font size=2 face="sans-serif">Trace; 0ff5b278 Before first symbol</font>
<br><font size=2 face="sans-serif">Trace; 0fec7914 Before first symbol</font>
<br><font size=2 face="sans-serif">Trace; 0fc0b408 Before first symbol</font>
<br>
<br>
<br><font size=2 face="sans-serif">5 warnings and 2 errors issued. &nbsp;Results
may not be reliable.</font>
<br>
<br>
--=_alternative 00050CAD85256FA1_=--
