Message-ID: <000c01c20513$5bf29fe0$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: problem for booting linux
Date: Mon, 27 May 2002 08:13:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sir,
    I use GDB to debug my linux 2.4.4 kernel,I find when the program run to Setup_arch(),like the flowing:
when go to the line number 752,it turn to the program /arch/ppc/mm/mem_pieces.c and invoke the function of
mem_pieces_find(unsigned int size, unsigned int align) and then it repeated in this function and not to continue.
it seems like find some memory!did you have this problem ?can you give me some advise? MY FADS board have 8M DRAM
and 2M Flash,does it be enough for version of 2.4.4-2002-03-21? Sorry for bother you again!

void __init setup_arch(char **cmdline_p)
{
 extern int panic_timeout;
 extern char _etext[], _edata[];
 extern char *klimit;
 extern void do_init_bootmem(void);

 /* so udelay does something sensible, assume <= 1000 bogomips */
 loops_per_jiffy = 500000000 / HZ;

#ifdef CONFIG_ALL_PPC
 feature_init();
#endif
#ifdef CONFIG_XMON
 xmon_map_scc();
 if (strstr(cmd_line, "xmon"))
  xmon(0);
#endif /* CONFIG_XMON */
 if ( ppc_md.progress ) ppc_md.progress("setup_arch: enter", 0x3eab);

#if defined(CONFIG_KGDB)
 kgdb_map_scc();
 set_debug_traps();
 breakpoint();
#endif

 /*
  * Set cache line size based on type of cpu as a default.
  * Systems with OF can look in the properties on the cpu node(s)
  * for a possibly more accurate value.
  */
 dcache_bsize = icache_bsize = 32; /* most common value */
 switch (_get_PVR() >> 16) {
 case 1:  /* 601, with unified cache */
  ucache_bsize = 32;
  break;
 /* XXX need definitions in here for 8xx etc. */
 case 0x40:
 case 0x41:
 case 0x35: /* 64-bit POWER3, POWER3+, POWER4 */
  dcache_bsize = icache_bsize = 128;
  break;
 }

 /* reboot on panic */
 panic_timeout = 180;

 init_mm.start_code = PAGE_OFFSET;
 init_mm.end_code = (unsigned long) _etext;
 init_mm.end_data = (unsigned long) _edata;
 init_mm.brk = (unsigned long) klimit;

 /* Save unparsed command line copy for /proc/cmdline */
752: strcpy(saved_command_line, cmd_line);
 *cmdline_p = cmd_line;

    ...

}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
