From: "James Bates" <jbates@paradise.co.uk>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Executable delay
Date: Mon, 22 Dec 2003 09:58:22 -0000
Message-ID: <OJEPIMKHOKJAJIDJLJBNAEKLCAAA.jbates@paradise.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <OJEPIMKHOKJAJIDJLJBNIEJPCAAA.jbates@paradise.co.uk>
Reply-To: jbates@paradise.co.uk
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I have had my first real poke around the kernel and it looks like I was
correct in saying that any task accessing the DOC drivers was put into an
incorrect state. The code that seemed to do the damage can be found in
drivers/mtd/devices/doc2000.c in the function _DoC_WaitReady().

The problem seems to be the call to cond_resched which is not in slightly
older kernel versions. To fix the bug I reverted this function back to the
code in version 2.4.10 of the kernel.

After making these changes it appears to work perfectly. My question now is.
Have I inadvertently broken something without knowing it.

Kind Regards,

James Bates

PS: My  _DoC_WaitReady is as follows:


/* DOC_WaitReady: Wait for RDY line to be asserted by the flash chip */
static int _DoC_WaitReady(struct DiskOnChip *doc)
{
	unsigned long docptr = doc->virtadr;
#ifndef CONFIG_MTD_DOCPROBE_SHORT_TIMEOUTS
	unsigned long timeo = jiffies + (HZ * 10);
#else
	unsigned long timeo = jiffies + 1;
#endif

	DEBUG(MTD_DEBUG_LEVEL3,
	      "_DoC_WaitReady called for out-of-line wait\n");

	/* Out-of-line routine to wait for chip response */
	while (!(ReadDOC(docptr, CDSNControl) & CDSN_CTRL_FR_B)) {
		if (time_after(jiffies, timeo)) {
			DEBUG(MTD_DEBUG_LEVEL2, "_DoC_WaitReady timed out.\n");
			return -EIO;
		}
// This is the "new" code from version 2.4.23
//		udelay(1);
//		cond_resched();
// Revert back to old task state management in 2.4.10
		if (current->need_resched) {
			set_current_state(TASK_UNINTERRUPTIBLE);
			schedule_timeout(1);
		}
		else
			udelay(1);
// End of 2.4.10 code
	}

	return 0;
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
