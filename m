Message-ID: <38BE22E0.69E80DE5@col.bsf.alcatel.fr>
Date: Thu, 02 Mar 2000 09:14:24 +0100
From: duyrat1 <duyrat1@col.bsf.alcatel.fr>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        Laurent Barbero <barbero@cabs40>
Subject: reset of the CPM
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hy,

In linux v2.2.12 release (and till in 2.3.47):
commproc.c is a file of  8xx_io directory
dealing with general purpose functions for the
global management of the MPC860 Communication Processor Module.

In  function void m8xx_cpm_reset(uint host_page_addr) following code is
disabled :
#ifdef notdef
 /* We can't do this.  It seems to blow away the microcode
  * patch that EPPC-Bug loaded for us.  EPPC-Bug uses SCC1 for
  * Ethernet, SMC1 for the console, and I2C for serial EEPROM.
  * Our own drivers quickly reset all of these.
  */

 /* Perform a reset.
 */
 commproc->cp_cpcr = (CPM_CR_RST | CPM_CR_FLG);

 /* Wait for it.
 */
 while (commproc->cp_cpcr & CPM_CR_FLG);
#endif

What is the role of this patch?
and then on a reset or when a NMI exception is generated, does that
mean  that no reset of the CPM must ever be done.

Thanks for your help!
JC


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
