From: Subodh Nijsure <subodh@best.com>
Message-Id: <200103290653.WAA01744@shell9.ba.best.com>
Subject: DPRAM parameters for 860P
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 28 Mar 2001 22:53:59 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Currently the 2.4.2 code assumes that DPRAM is always 4KB has anybody
put together m8xx_cpm_dpalloc() that takes advantage of larger DPRAM on 860P?

->From arch/ppc/kernel/8xx_io/commproc.c

/* The dual ported RAM is multi-functional.  Some areas can be (and are
 * being) used for microcode.  There is an area that can only be used
 * as data ram for buffer descriptors, which is all we use right now.
 * Currently the first 512 and last 256 bytes are used for microcode.
 */
#define CPM_DATAONLY_BASE   ((uint)0x0800)
/*#define CPM_DATAONLY_SIZE ((uint)0x0700)*/

/* Above definition assumes we have 4KB DPRAM but 860P has 8KB, so
 * we experiment.  My RCCR , RMDS says DATA size of 0x3400 is safe
 */

#define CPM_DATAONLY_SIZE   ((uint)0x3400)
#define CPM_DP_NOSPACE      ((uint)0x7fffffff)



I have been running my system  with above configuration for couple of days
without any problems. Are there any side effects I should be aware of?

2. Anybody knows if  there a driver currently that uses the 8xx IDMA
to transfer data from a peripheral to CPU and back?

/Subodh Nijsure

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
