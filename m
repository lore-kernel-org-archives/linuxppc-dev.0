From: dsmk@bu.edu
Date: Mon, 1 Nov 1999 10:08:39 -0500 (EST)
To: Troy Benjegerdes <hozer@drgw.net>
cc: Paul Mackerras <paulus@linuxcare.com>, linuxppc-dev@lists.linuxppc.org,
        dsmk@bu.edu
Subject: (simple /proc/apm support for pmud) Re: PMU daemon
In-Reply-To: <381CD1E5.3F4E45FF@drgw.net>
Message-ID: <Pine.LNX.4.20.9911011005150.14599-100000@faust.bu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 31 Oct 1999, Troy Benjegerdes wrote:
> [...]
> 
> Finally, does anyone know how feasable it would be to make pmud have the
> same API as the intel-ish APMD, since there are a bunch of nice X
> apps/applets for various window managers that talk to APMD?

Well, I threw together a quick patch to pmud that does this.  Here is the
message that I sent to Paul Mackerras the other day.

From: David King <dsmk@bu.edu>
To: paulus@linuxcare.com
Subject: /proc/apm compatability using pmud (patch)

Hi,

pmud-0.2 has been working great on my Lombard 333.  The only feature that 
I have missed is the ability to use the apm battery monitoring utilities
(Batmon is nice but I'd like something in my windowmaker dock).

This patch extends pmud to update a apm formated file with every polling 
pass.  I have managed to compile and use both wmbattery and wmapm by just 
changing the /proc/apm path to /var/spool/pmud/apm.  

This isn't exactly clean - the thresholds are hard-coded, it does not
correctly handle multiple batteries with the exception of time
remaining, does not handle the 3400 style battery lookup, and it does
not handle updating the remaining time when recharging - but it does
work.

My original plan was to add this functionality to pmud and then move it into
the kernel as /proc/apm but this works well enough for me that I'm not going
to worry about it for now.  

My next plan is to write a apm command which talks with pmud's telnet
port.  This should enable the sleep functionality of wmapm and some
other tools (they generally just do a system call to apm to force a sleep).

Thanks for the wonderful work,
-David

*** pmud.c.19991021	Sun Sep 26 05:31:57 1999
--- pmud.c	Fri Oct 22 13:51:22 1999
***************
*** 29,34 ****
--- 29,40 ----
  
  #define PMUD_VERSION		"0.2"
  
+ #define APMFILE 		"/var/spool/pmud/apm"
+ #define APMFAKEFLAGS		0x02
+ #define APMCRITICAL		10
+ #define APMLOW			30
+ #define APMSEC2MINTHRESHOLD	600
+ 
  #define POWERLEVEL_SCRIPT	"/sbin/pwrctl"
  #define POWER_FILE		"/etc/powerlevels"
  #define PORT			879
***************
*** 310,315 ****
--- 316,342 ----
  	struct timeval now;
  	int timeleft = -1;
  
+ #ifdef  APMFILE
+ 	static FILE *fapm = NULL;
+ 	struct pmu_apm_compat {
+ 	  int ac_avail;
+ 	  int battery_status;
+ 	  int battery_flags;
+ 	  int remain_percent;
+ 	  int remain_time;
+ 	  char* time_unit;
+ 	} pac;
+ 
+ 	/* init structure */
+ 	pac.ac_avail = 0;
+ 	pac.battery_status = 0;
+ 	pac.battery_flags = 0;
+ 	pac.remain_percent = 0;
+ 	pac.remain_time = 0;
+ 	pac.time_unit = "sec";
+ 
+ #endif
+ 
  	if (pmu_op(PMU_GET_INPUT, 0, 0, &switches, 1, "switch req") < 0)
  		return;
  
***************
*** 358,363 ****
--- 385,418 ----
  					sprintf(p, " %d", batt[j]);
  					p += strlen(p);
  				}
+ 
+ #ifdef APMFILE
+ 				/* prepare the apm structure */
+ 				if (batt[0] & 0x04) {
+ 				  pac.ac_avail = batt[0] & 0x01;
+ 
+ 				  /* determine a percent remaining 
+ 				     and a charge level */
+ 				  pac.remain_percent = 
+ 				    (batt[1] * 100) / batt[2];
+ 				  if (pac.remain_percent <= APMCRITICAL) {
+ 				    pac.battery_status = 0x02;
+ 				    pac.battery_flags = 0x04;
+ 				  } else if (pac.remain_percent <= APMLOW) {
+ 				    pac.battery_status = 0x01;
+ 				    pac.battery_flags = 0x02;
+ 				  } else {
+ 				    pac.battery_status = 0x00;
+ 				    pac.battery_flags = 0x01;
+ 				  }
+ 
+ 				  /* now we determine if we are charging */
+ 				  if (batt[0] & 0x02) {
+ 				    pac.battery_status = 0x03;
+ 				    pac.battery_flags |= 0x08;
+ 				  }
+ 				}
+ #endif				  
  			}
  			*p++ = '}';
  		}
***************
*** 365,371 ****
--- 420,460 ----
  		*p = 0;
  		if (current < 0)
  			timeleft = charge * 3552 / -current;
+ 
+ #ifdef APMFILE
+ 		if (timeleft > APMSEC2MINTHRESHOLD) {
+ 		  pac.remain_time = timeleft / 60;
+ 		  pac.time_unit = "min";
+ 		} else {
+ 		  pac.remain_time = timeleft;
+ 		}
+ #endif
  	}
+ 
+ #ifdef  APMFILE
+ 	/* now we output the data */
+ 
+ 	/* open or reset the file */
+ 	if (fapm == NULL) {
+ 	  /* open the new one for writing */
+ 	  fapm = fopen(APMFILE, "w");
+ 	} else {
+ 	  rewind(fapm);
+ 	}
+ 
+ 	/* rewrite the file */
+ 	if (fapm != NULL) {
+ 	  fprintf(fapm, "%s %d.0 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n%s",
+ 		  PMUD_VERSION,
+ 		  pmu_version,
+ 		  APMFAKEFLAGS,
+ 		  pac.ac_avail, pac.battery_status, pac.battery_flags,
+ 		  pac.remain_percent, pac.remain_time, pac.time_unit,
+ 		  "                                               ");
+ 	  fflush(fapm);
+ 	}
+ 
+ #endif 
  
  	n = strlen(status);
  	for (ss = all_sockets; ss != 0; ss = ssnext) {


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
