Date: Mon, 27 Oct 2003 09:55:14 -0600
Subject: radeonfb driver patch for 2.4.23 kernel to support 2003 15" PowerBooks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: michel@daenzer.net
To: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
From: Ken Offer <koffer@arlut.utexas.edu>
Message-Id: <F3E8741E-0895-11D8-B555-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Here is a patch for the linux-2.4.23-pre5-ben0 kernel radeonfb driver
to support the new 2003 15" PowerBooks.  Its not pretty, but it appears
to work.  I copied choice bits from the 2.6 driver to get this working.
  Feel free to remove the "KRO:" comments (I was keeping track of what I
changed).

Thanks go to Michel Dänzer <michel@daenzer.net> for pointing out the
surface registers.

----

*** unmodified/radeonfb.c	2003-10-20 11:19:28.000000000 -0600
--- modified/radeonfb.c	2003-10-27 08:40:33.000000000 -0700
***************
*** 168,174 ****
   #include <linux/radeonfb.h>


! #define DEBUG	0

   #if DEBUG
   #define RTRACE		printk
--- 168,174 ----
   #include <linux/radeonfb.h>


! #define DEBUG	1

   #if DEBUG
   #define RTRACE		printk
***************
*** 217,222 ****
--- 217,223 ----
   	RADEON_NI,
   	RADEON_AP,
   	RADEON_AR,
+ 	RADEON_NP       /*KRO:031016, added for 15" 2003 PowerBook */
   };

   enum radeon_arch {
***************
*** 237,281 ****
   static struct radeon_chip_info {
   	const char *name;
   	unsigned char arch;
   } radeon_chip_info[] __devinitdata = {
! 	{ "QD", RADEON_R100 },
! 	{ "QE", RADEON_R100 },
! 	{ "QF", RADEON_R100 },
! 	{ "QG", RADEON_R100 },
! 	{ "VE QY", RADEON_RV100 },
! 	{ "VE QZ", RADEON_RV100 },
! 	{ "M7 LW", RADEON_M7 },
! 	{ "M7 LX", RADEON_M7 },
! 	{ "M6 LY", RADEON_M6 },
! 	{ "M6 LZ", RADEON_M6 },
! 	{ "8500 QL", RADEON_R200 },
! 	{ "8500 QN", RADEON_R200 },
! 	{ "8500 QO", RADEON_R200 },
! 	{ "8500 Ql", RADEON_R200 },
! 	{ "8500 BB", RADEON_R200 },
! 	{ "9100 QM", RADEON_R200 },
! 	{ "7500 QW", RADEON_RV200 },
! 	{ "7500 QX", RADEON_RV200 },
! 	{ "9000 Id", RADEON_RV250 },
! 	{ "9000 Ie", RADEON_RV250 },
! 	{ "9000 If", RADEON_RV250 },
! 	{ "9000 Ig", RADEON_RV250 },
! 	{ "9200 Y", RADEON_RV280 },
! 	{ "M9 Ld", RADEON_M9 },
! 	{ "M9 Le", RADEON_M9 },
! 	{ "M9 Lf", RADEON_M9 },
! 	{ "M9 Lg", RADEON_M9 },
! 	{ "9700 ND", RADEON_R300 },
! 	{ "9700 NE", RADEON_R300 },
! 	{ "9700 NF", RADEON_R350 },
! 	{ "9700 NG", RADEON_R350 },
! 	{ "9700 AE", RADEON_R300 },
! 	{ "9700 AF", RADEON_R300 },
! 	{ "9500 AD", RADEON_R300 },
! 	{ "9800 NH", RADEON_R350 },
! 	{ "9800 NI", RADEON_R350 },
! 	{ "9600 AP", RADEON_RV350 },
! 	{ "9600 AR", RADEON_RV350 },
   };


--- 238,284 ----
   static struct radeon_chip_info {
   	const char *name;
   	unsigned char arch;
+ 	unsigned char mobility;  // KRO:031016, added mobility field to
following chip info
   } radeon_chip_info[] __devinitdata = {
! 	{ "QD", RADEON_R100, 0 },
! 	{ "QE", RADEON_R100, 0 },
! 	{ "QF", RADEON_R100, 0 },
! 	{ "QG", RADEON_R100, 0 },
! 	{ "VE QY", RADEON_RV100, 0 },
! 	{ "VE QZ", RADEON_RV100, 0 },
! 	{ "M7 LW", RADEON_M7, 2 },
! 	{ "M7 LX", RADEON_M7, 2 },
! 	{ "M6 LY", RADEON_M6, 1 },
! 	{ "M6 LZ", RADEON_M6, 1 },
! 	{ "8500 QL", RADEON_R200, 0 },
! 	{ "8500 QN", RADEON_R200, 0 },
! 	{ "8500 QO", RADEON_R200, 0 },
! 	{ "8500 Ql", RADEON_R200, 0 },
! 	{ "8500 BB", RADEON_R200, 0 },
! 	{ "9100 QM", RADEON_R200, 0 },
! 	{ "7500 QW", RADEON_RV200, 0 },
! 	{ "7500 QX", RADEON_RV200, 0 },
! 	{ "9000 Id", RADEON_RV250, 0 },
! 	{ "9000 Ie", RADEON_RV250, 0 },
! 	{ "9000 If", RADEON_RV250, 0 },
! 	{ "9000 Ig", RADEON_RV250, 0 },
! 	{ "9200 Y", RADEON_RV280, 0 },
! 	{ "M9 Ld", RADEON_M9, 2 },
! 	{ "M9 Le", RADEON_M9, 2 },
! 	{ "M9 Lf", RADEON_M9, 2 },
! 	{ "M9 Lg", RADEON_M9, 2 },
! 	{ "9700 ND", RADEON_R300, 0 },
! 	{ "9700 NE", RADEON_R300, 0 },
! 	{ "9700 NF", RADEON_R350, 0 },
! 	{ "9700 NG", RADEON_R350, 0 },
! 	{ "9700 AE", RADEON_R300, 0 },
! 	{ "9700 AF", RADEON_R300, 0 },
! 	{ "9500 AD", RADEON_R300, 0 },
! 	{ "9800 NH", RADEON_R350, 0 },
! 	{ "9800 NI", RADEON_R350, 0 },
! 	{ "9600 AP", RADEON_RV350, 0 },
! 	{ "9600 AR", RADEON_RV350, 0 },
! 	{ "9600 NP", RADEON_RV350, 2 },       /*KRO:031016, added for 15"
2003 PowerBook */
   };


***************
*** 289,294 ****
--- 292,305 ----
   	MT_STV		/* S-Video out */
   };

+ #define PCI_DEVICE_ID_ATI_RADEON_NP  0x4e50          /*KRO:031016,
added for 15" 2003 PowerBook (define should really go in pci_ids.h) */
+
+ #define VCLK_SRC_SEL_MASK            0x03            /*KRO:031016,
should be defined in radeon.h */
+ #define VCLK_SRC_SEL_CPUCLK          0x00            /*KRO:031016,
should be defined in radeon.h */
+ #define VCLK_SRC_SEL_PPLLCLK         0x03            /*KRO:031016,
should be defined in radeon.h */
+ #define	PPLL_SLEEP                   0x00000002      /*KRO:031016,
should be defined in radeon.h */
+ #define R300_PPLL_REF_DIV_ACC_MASK   (0x3ff << 18)   /*KRO:031016,
should be defined in radeon.h */
+ #define R300_PPLL_REF_DIV_ACC_SHIFT  18              /*KRO:031016,
should be defined in radeon.h */

   static struct pci_device_id radeonfb_pci_table[] __devinitdata = {
   	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QD, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, RADEON_QD},
***************
*** 329,334 ****
--- 340,346 ----
   	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AD, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, RADEON_AD},
   	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AP, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, RADEON_AP},
   	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AR, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, RADEON_AR},
+ 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NP, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, RADEON_NP},       /*KRO:031016, added for 15" 2003
PowerBook */
   	{ 0, }
   };
   MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
***************
*** 460,465 ****
--- 472,484 ----

   	/* Endian control */
   	u32 surface_cntl;
+
+ #if 1 //KRO:031027, added
+         /* Surface/tiling registers */
+         u32 surf_lower_bound[8];
+         u32 surf_upper_bound[8];
+         u32 surf_info[8];
+ #endif
   };


***************
*** 469,475 ****
   	struct radeon_regs state;
   	struct radeon_regs init_state;

! 	char name[16];
   	char ram_type[12];

   	unsigned long mmio_base_phys;
--- 488,494 ----
   	struct radeon_regs state;
   	struct radeon_regs init_state;

! 	char name[50];     //KRO:031017, increased from 16
   	char ram_type[12];

   	unsigned long mmio_base_phys;
***************
*** 493,498 ****
--- 512,518 ----

   	short chipset;
   	unsigned char arch;
+ 	unsigned char mobility;   //KRO:031016, added
   	int video_ram;
   	u8 rev;
   	int pitch, bpp, depth;
***************
*** 708,714 ****
   	return (var->green.length == 6) ? 16 : 15;
   }

-
   static void _radeon_engine_reset(struct radeonfb_info *rinfo)
   {
   	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
--- 728,733 ----
***************
*** 755,762 ****

   	host_path_cntl = INREG(HOST_PATH_CNTL);
   	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
!
! 	if (rinfo->arch == RADEON_R300) {
   		u32 tmp;

   		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
--- 774,783 ----

   	host_path_cntl = INREG(HOST_PATH_CNTL);
   	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
!
! 	if ((rinfo->arch == RADEON_R300) ||
! 	    (rinfo->arch == RADEON_R350) ||
! 	    (rinfo->arch == RADEON_RV350)) { // KRO:031016, added R350 and
RV350 tests
   		u32 tmp;

   		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
***************
*** 792,798 ****
   	INREG(HOST_PATH_CNTL);
   	OUTREG(HOST_PATH_CNTL, host_path_cntl);

! 	if (rinfo->arch != RADEON_R300)
   		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);

   	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
--- 813,821 ----
   	INREG(HOST_PATH_CNTL);
   	OUTREG(HOST_PATH_CNTL, host_path_cntl);

! 	if ((rinfo->arch != RADEON_R300) ||
! 	    (rinfo->arch != RADEON_R350) ||
! 	    (rinfo->arch != RADEON_RV350)) // KRO:031016, added R350 and
RV350 tests
   		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);

   	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
***************
*** 1634,1641 ****
   	memset (rinfo, 0, sizeof (struct radeonfb_info));

   	rinfo->pdev = pdev;
! 	strncpy(rinfo->name, rci->name, 16);
   	rinfo->arch = rci->arch;

   	/* enable device */
   	{
--- 1657,1665 ----
   	memset (rinfo, 0, sizeof (struct radeonfb_info));

   	rinfo->pdev = pdev;
! 	strncpy(rinfo->name, rci->name, sizeof(rinfo->name));  //KRO:031016,
changed size field from 16 to size of array
   	rinfo->arch = rci->arch;
+ 	rinfo->mobility = rci->mobility;         //KRO:031016, added

   	/* enable device */
   	{
***************
*** 1752,1757 ****
--- 1776,1787 ----
   	rinfo->bios_seg = radeon_find_rom(rinfo);
   	radeon_get_pllinfo(rinfo, rinfo->bios_seg);

+ 	RTRACE("KRO: rinfo->pll.xclk = %d\n", rinfo->pll.xclk);
+ 	RTRACE("KRO: rinfo->pll.ref_clk = %d\n", rinfo->pll.ref_clk);
+ 	RTRACE("KRO: rinfo->pll.ref_div = %d\n", rinfo->pll.ref_div);
+ 	RTRACE("KRO: rinfo->pll.ppll_min = %d\n", rinfo->pll.ppll_min);
+ 	RTRACE("KRO: rinfo->pll.ppll_max = %d\n", rinfo->pll.ppll_max);
+
   	/*
   	 * Hack to get around some busted production M6's
   	 * reporting no ram
***************
*** 1782,1787 ****
--- 1812,1818 ----
   #if !defined(__powerpc__)
   	radeon_get_moninfo(rinfo);
   #else
+ #if 0  //KRO:031016, use new mobility flag
   	switch (rinfo->arch) {
   		case RADEON_M6:
   		case RADEON_M7:
***************
*** 1800,1805 ****
--- 1831,1853 ----
   			radeon_get_moninfo(rinfo);
   			break;
   	}
+ #else
+ 	if (rinfo->mobility) {
+ 			/* If forced to no-LCD, we shut down the backlight */
+ 			if (force_nolcd) {
+ #ifdef CONFIG_PMAC_BACKLIGHT
+ 				radeon_set_backlight_enable(0, BACKLIGHT_OFF, rinfo);
+ #endif
+ 				radeon_get_moninfo(rinfo);
+ 			} else {
+ 				rinfo->dviDisp_type = MT_LCD;
+ 			}
+ 	} else {
+ 			radeon_get_moninfo(rinfo);
+ 	}
+ #endif
+
+
   #endif

   	radeon_get_EDID(rinfo);
***************
*** 1902,1910 ****
--- 1950,1962 ----
   	}

   #ifdef CONFIG_PMAC_PBOOK
+ #if 0  //KRO:031016, use new mobility flag
   	if (rinfo->arch == RADEON_M6 ||
   	    rinfo->arch == RADEON_M7 ||
   	    rinfo->arch == RADEON_M9) {
+ #else
+ 	if (rinfo->mobility) {
+ #endif
                  /* Find PM registers in config space */
                  rinfo->pm_reg = pci_find_capability(pdev,
PCI_CAP_ID_PM);

***************
*** 1963,1969 ****
   	radeon_engine_reset ();

   	radeon_fifo_wait (1);
! 	if (rinfo->arch != RADEON_R300)
   		OUTREG(RB2D_DSTCACHE_MODE, 0);

   	radeon_fifo_wait (3);
--- 2015,2023 ----
   	radeon_engine_reset ();

   	radeon_fifo_wait (1);
! 	if ((rinfo->arch != RADEON_R300) &&
! 	    (rinfo->arch != RADEON_R350) &&
! 	    (rinfo->arch != RADEON_RV350))      //KRO:031016 added R350 and
RV350 tests
   		OUTREG(RB2D_DSTCACHE_MODE, 0);

   	radeon_fifo_wait (3);
***************
*** 2574,2579 ****
--- 2628,2634 ----
   		 * TODO:  set mirror accordingly for non-Mobility chipsets with 2
CRTC's
   		 */
   		case FBIO_RADEON_SET_MIRROR:
+ #if 0  //KRO:031016, use new mobility flag
   			switch (rinfo->arch) {
   				case RADEON_M6:
   				case RADEON_M7:
***************
*** 2582,2588 ****
   				default:
   					return -EINVAL;
   			}
!
   			rc = get_user(value, (__u32*)arg);

   			if (rc)
--- 2637,2648 ----
   				default:
   					return -EINVAL;
   			}
! #else
! 			if (rinfo->mobility)
! 			  break;
! 			else
! 			  return -EINVAL;
! #endif
   			rc = get_user(value, (__u32*)arg);

   			if (rc)
***************
*** 2617,2622 ****
--- 2677,2683 ----
   			return 0;

   		case FBIO_RADEON_GET_MIRROR:
+ #if 0  //KRO:031016, use new mobility flag
   			switch (rinfo->arch) {
   				case RADEON_M6:
   				case RADEON_M7:
***************
*** 2625,2631 ****
   				default:
   					return -EINVAL;
   			}
!
   			tmp = INREG(LVDS_GEN_CNTL);
   			if ((LVDS_ON | LVDS_BLON) & tmp)
   				value |= 0x01;
--- 2686,2697 ----
   				default:
   					return -EINVAL;
   			}
! #else
! 			if (rinfo->mobility)
! 			  break;
! 			else
! 			  return -EINVAL;
! #endif
   			tmp = INREG(LVDS_GEN_CNTL);
   			if ((LVDS_ON | LVDS_BLON) & tmp)
   				value |= 0x01;
***************
*** 2987,2992 ****
--- 3053,3062 ----
   	int depth = var_to_depth(mode);
           int accel = mode->accel_flags & FB_ACCELF_TEXT;

+ #if 1 //KRO:031027, added
+ 	int i;
+ #endif
+
   	rinfo->xres = mode->xres;
   	rinfo->yres = mode->yres;
   	rinfo->xres_virtual = mode->xres_virtual;
***************
*** 3001,3006 ****
--- 3071,3082 ----
   	vSyncEnd = vSyncStart + mode->vsync_len;
   	vTotal = vSyncEnd + mode->upper_margin;
   	pixClock = mode->pixclock;
+
+ #if 1 //KRO:031017, add here because its in 2.6 driver
+ 	sync = mode->sync;
+ 	h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
+ 	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+ #endif

   	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
                   /* Force the native video mode of the LCD monitor.
***************
*** 3025,3042 ****
--- 3101,3127 ----
   		vSyncStart = mode->yres + rinfo->vOver_plus;
   		vSyncEnd = vSyncStart + rinfo->vSync_width;

+ #if 1 //KRO:031017 add here because its in 2.6 driver
+ 		h_sync_pol = !rinfo->hAct_high;
+ 		v_sync_pol = !rinfo->vAct_high;
+ #endif
+
   		/* If we know the LCD clock, we shall use it, unfortunately,
   		 * we may not know it until we have proper EDID probing
   		 */
+ #if 0 //KRO:031017, test not in 2.6 driver
   		if (rinfo->clock)
+ #endif
   			pixClock = 100000000 / rinfo->clock;
   	}
   	dotClock = 1000000000 / pixClock;
   	freq = dotClock / 10; /* x100 */

+ #if 0  //KRO:031017, not here in 2.6 driver
   	sync = mode->sync;
   	h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
   	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+ #endif

   	RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
   		hSyncStart, hSyncEnd, hTotal);
***************
*** 3145,3150 ****
--- 3230,3244 ----
   	}
   #endif

+ #if 1 //KRO:031027, added
+         /* Clear surface registers */
+         for (i=0; i<8; i++) {
+                 newmode.surf_lower_bound[i] = 0;
+                 newmode.surf_upper_bound[i] = 0x1f;
+                 newmode.surf_info[i] = 0;
+         }
+ #endif
+
   	RTRACE("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
   		newmode.crtc_h_total_disp, newmode.crtc_h_sync_strt_wid);
   	RTRACE("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
***************
*** 3264,3270 ****
   			if (rinfo->arch == RADEON_R100 ||
   			    rinfo->arch == RADEON_R200 ||
   			    rinfo->arch == RADEON_R300 ||
! 			    rinfo->arch == RADEON_R350)
   				newmode.tmds_transmitter_cntl &= ~TMDS_PLL_EN;
   			else
   				newmode.tmds_transmitter_cntl |= TMDS_PLL_EN;
--- 3358,3365 ----
   			if (rinfo->arch == RADEON_R100 ||
   			    rinfo->arch == RADEON_R200 ||
   			    rinfo->arch == RADEON_R300 ||
! 			    rinfo->arch == RADEON_R350 ||
! 			    rinfo->arch == RADEON_RV350)
   				newmode.tmds_transmitter_cntl &= ~TMDS_PLL_EN;
   			else
   				newmode.tmds_transmitter_cntl |= TMDS_PLL_EN;
***************
*** 3283,3291 ****
   	}

   	/* do it! */
! 	if (!rinfo->asleep)
   		radeon_write_mode (rinfo, &newmode);

   #if defined(CONFIG_BOOTX_TEXT)
   	btext_update_display(rinfo->fb_base_phys, mode->xres, mode->yres,
   			     rinfo->depth, rinfo->pitch*64);
--- 3378,3404 ----
   	}

   	/* do it! */
! 	if (!rinfo->asleep) {
   		radeon_write_mode (rinfo, &newmode);

+ 		//KRO:031017, add re-initialize because its in 2.6 driver
+
+ 		/* (re)initialize the engine */
+ 		if (accel)
+ 			radeon_engine_init (rinfo);
+ 	}
+
+ #if 1 //KRO:031017, add section from 2.6 driver
+
+ 	/* Update fix */
+ 	if (accel)
+         	rinfo->disp.line_length = rinfo->pitch*64;
+         else
+ 		rinfo->disp.line_length = mode->xres_virtual *
((mode->bits_per_pixel + 1) / 8);
+         rinfo->disp.visual = rinfo->depth == 8 ?
FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+
+ #endif
+
   #if defined(CONFIG_BOOTX_TEXT)
   	btext_update_display(rinfo->fb_base_phys, mode->xres, mode->yres,
   			     rinfo->depth, rinfo->pitch*64);
***************
*** 3297,3302 ****
--- 3410,3417 ----

   static void radeon_write_pll_regs(struct radeonfb_info *rinfo, struct
radeon_regs *mode)
   {
+ #if 0
+
   	/* Workaround from XFree */
   	if (rinfo->arch < RADEON_R300) {
   	        /* A temporal workaround for the occational blanking on
certain laptop panels.
***************
*** 3336,3341 ****
--- 3451,3535 ----
   	OUTPLL(HTOTAL_CNTL, 0);

   	OUTPLLP(PPLL_CNTL, 0, ~PPLL_RESET);
+
+ #else
+
+ 	int i;
+
+ 	/* Workaround from XFree */
+ 	if (rinfo->mobility) {
+ 	        /* A temporal workaround for the occational blanking on
certain laptop panels.
+ 	           This appears to related to the PLL divider registers
(fail to lock?).
+ 		   It occurs even when all dividers are the same with their old
settings.
+ 	           In this case we really don't need to fiddle with PLL
registers.
+ 	           By doing this we can avoid the blanking problem with some
panels.
+ 	        */
+ 		if ((mode->ppll_ref_div == (INPLL(PPLL_REF_DIV) &
PPLL_REF_DIV_MASK)) &&
+ 		    (mode->ppll_div_3 == (INPLL(PPLL_DIV_3) &
+ 		    		(PPLL_POST3_DIV_MASK | PPLL_FB3_DIV_MASK))))
+             		return;
+ 	}
+
+ 	/* Swich VCKL clock input to CPUCLK so it stays fed while PPLL
updates*/
+ 	OUTPLLP(VCLK_ECP_CNTL, VCLK_SRC_SEL_CPUCLK, ~VCLK_SRC_SEL_MASK);
+
+ 	/* Reset PPLL & enable atomic update */
+ 	OUTPLLP(PPLL_CNTL,
+ 		PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN,
+ 		~(PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN));
+
+ 	/* Switch to PPLL div 3 */
+ 	OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, ~PPLL_DIV_SEL_MASK);
+
+ 	/* Set PPLL ref. div */
+ 	if (rinfo->arch == RADEON_R300 ||
+ 	    rinfo->arch == RADEON_R350 ||
+ 	    rinfo->arch == RADEON_RV350) {
+ 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
+ 			/* When restoring console mode, use saved PPLL_REF_DIV
+ 			 * setting.
+ 			 */
+ 			OUTPLLP(PPLL_REF_DIV, mode->ppll_ref_div, 0);
+ 		} else {
+ 			/* R300 uses ref_div_acc field as real ref divider */
+ 			OUTPLLP(PPLL_REF_DIV,
+ 				(mode->ppll_ref_div << R300_PPLL_REF_DIV_ACC_SHIFT),
+ 				~R300_PPLL_REF_DIV_ACC_MASK);
+ 		}
+ 	} else
+ 		OUTPLLP(PPLL_REF_DIV, mode->ppll_ref_div, ~PPLL_REF_DIV_MASK);
+
+ 	/* Set PPLL divider 3 & post divider*/
+ 	OUTPLLP(PPLL_DIV_3, mode->ppll_div_3, ~PPLL_FB3_DIV_MASK);
+ 	OUTPLLP(PPLL_DIV_3, mode->ppll_div_3, ~PPLL_POST3_DIV_MASK);
+
+ 	/* Write update */
+ 	while (INPLL(PPLL_REF_DIV) & PPLL_ATOMIC_UPDATE_R)
+ 		;
+ 	OUTPLLP(PPLL_REF_DIV, PPLL_ATOMIC_UPDATE_W, ~PPLL_ATOMIC_UPDATE_W);
+
+ 	/* Wait read update complete */
+ 	/* FIXME: Certain revisions of R300 can't recover here.  Not sure of
+ 	   the cause yet, but this workaround will mask the problem for now.
+ 	   Other chips usually will pass at the very first test, so the
+ 	   workaround shouldn't have any effect on them. */
+ 	for (i = 0; (i < 10000 && INPLL(PPLL_REF_DIV) &
PPLL_ATOMIC_UPDATE_R); i++)
+ 		;
+
+ 	OUTPLL(HTOTAL_CNTL, 0);
+
+ 	/* Clear reset & atomic update */
+ 	OUTPLLP(PPLL_CNTL, 0,
+ 		~(PPLL_RESET | PPLL_SLEEP | PPLL_ATOMIC_UPDATE_EN |
PPLL_VGA_ATOMIC_UPDATE_EN));
+
+ 	/* Let the clock to lock */
+ 	/* FIXME: Schedule here */
+ 	mdelay(5);
+
+ 	/* Switch back VCLK source to PPLL */
+ 	OUTPLLP(VCLK_ECP_CNTL, VCLK_SRC_SEL_PPLLCLK, ~VCLK_SRC_SEL_MASK);
+
+ #endif
   }

   static void radeon_write_mode (struct radeonfb_info *rinfo,
***************
*** 3354,3359 ****
--- 3548,3562 ----
   			OUTREG(common_regs[i].reg, common_regs[i].val);
   	}

+ #if 1  //KRO:031027 added
+         /* Apply surface registers */
+         for (i=0; i<8; i++) {
+                 OUTREG(SURFACE0_LOWER_BOUND + 0x10*i,
mode->surf_lower_bound[i]);
+                 OUTREG(SURFACE0_UPPER_BOUND + 0x10*i,
mode->surf_upper_bound[i]);
+                 OUTREG(SURFACE0_INFO + 0x10*i, mode->surf_info[i]);
+         }
+ #endif
+
   	OUTREG(CRTC_GEN_CNTL, mode->crtc_gen_cntl);
   	OUTREGP(CRTC_EXT_CNTL, mode->crtc_ext_cntl,
   		CRTC_HSYNC_DIS | CRTC_VSYNC_DIS | CRTC_DISPLAY_DIS);
***************
*** 3452,3458 ****
--- 3655,3665 ----
   	 * out in what direction backlight should work on a given
   	 * panel ?
   	 */
+ #if 0  //KRO:031016 use new mobility flag
   	if ((rinfo->arch == RADEON_M7 || rinfo->arch == RADEON_M9)
+ #else
+ 	if ((rinfo->mobility == 2)
+ #endif
   		&& !machine_is_compatible("PowerBook4,3"))
   		conv_table = backlight_conv_m7;
   	else
***************
*** 3899,3907 ****
   	u32 pixclks_cntl;

   	/* Mobility chips only */
   	if ((rinfo->arch != RADEON_M6) && (rinfo->arch != RADEON_M7) &&
(rinfo->arch != RADEON_M9))
   		return;
!
   	/* Force Core Clocks */
   	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
   	sclk_cntl |= 	SCLK_CNTL_M6__FORCE_CP|
--- 4106,4118 ----
   	u32 pixclks_cntl;

   	/* Mobility chips only */
+ #if 0   //KRO:031016, use new mobility flag
   	if ((rinfo->arch != RADEON_M6) && (rinfo->arch != RADEON_M7) &&
(rinfo->arch != RADEON_M9))
   		return;
! #else
! 	if (rinfo->mobility == 0)
! 		return;
! #endif
   	/* Force Core Clocks */
   	sclk_cntl = INPLL( pllSCLK_CNTL_M6);
   	sclk_cntl |= 	SCLK_CNTL_M6__FORCE_CP|
***************
*** 3971,3978 ****
--- 4182,4194 ----
   	u32 mclk_misc;

   	/* Mobility chips only */
+ #if 0   //KRO:031016, use new mobility flag
   	if ((rinfo->arch != RADEON_M6) && (rinfo->arch != RADEON_M7) &&
(rinfo->arch != RADEON_M9))
   		return;
+ #else
+ 	if (rinfo->mobility == 0)
+ 		return;
+ #endif

   	/* Set Latencies */
   	clk_pwrmgt_cntl = INPLL( pllCLK_PWRMGT_CNTL_M6);
***************
*** 4208,4214 ****
--- 4424,4434 ----
   	// MLCK /YCLK sync
   	radeon_pm_yclk_mclk_sync(rinfo);

+ #if 0  //KRO:031016, use new mobility flag
   	if ((rinfo->arch == RADEON_M6) || (rinfo->arch == RADEON_M7) ||
(rinfo->arch == RADEON_M9)) {
+ #else
+ 	if (rinfo->mobility) {
+ #endif
   		radeon_pm_program_mode_reg(rinfo, 0x2000, 1);
   		radeon_pm_program_mode_reg(rinfo, 0x2001, 1);
   		radeon_pm_program_mode_reg(rinfo, 0x2002, 1);
***************
*** 4253,4259 ****
--- 4473,4483 ----

   		/* Prepare mobility chips for suspend
   		 */
+ #if 0  //KRO:031016, use new mobility flag
   		if (rinfo->arch == RADEON_M6 || rinfo->arch == RADEON_M7 ||
rinfo->arch == RADEON_M9) {
+ #else
+ 		if (rinfo->mobility) {
+ #endif
   			/* Program V2CLK */
   			radeon_pm_program_v2clk(rinfo);

***************
*** 4289,4295 ****
--- 4513,4523 ----
   		mdelay(500);

   		/* Reset the SDRAM controller */
+ #if 0  //KRO:031016, use new mobility flag
   		if (rinfo->arch == RADEON_M6 || rinfo->arch == RADEON_M7 ||
rinfo->arch == RADEON_M9)
+ #else
+ 		if (rinfo->mobility)
+ #endif
   			radeon_pm_full_reset_sdram(rinfo);

   		/* Restore some registers */
***************
*** 4315,4320 ****
--- 4543,4549 ----

           	disp = (rinfo->currcon < 0) ? rinfo->info.disp :
&fb_display[rinfo->currcon];

+ #if 0  //KRO:031016, use new mobility flag
   		switch (rinfo->arch) {
   			case RADEON_M6:
   			case RADEON_M7:
***************
*** 4323,4328 ****
--- 4552,4563 ----
   			default:
   				return PBOOK_SLEEP_REFUSE;
   		}
+ #else
+ 		if (rinfo->mobility)
+ 		  break;
+ 		else
+ 		  return PBOOK_SLEEP_REFUSE;
+ #endif

   		radeonfb_get_fix(&fix, fg_console, (struct fb_info *)rinfo);
   		nb = fb_display[fg_console].var.yres * fix.line_length;

+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
