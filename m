Date: Sat, 6 Jan 2001 17:28:22 -0500 (EST)
From: Conrad H Ziesler <cziesler@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ibook, hda power off sequence (for IBM travelstar) 
Message-ID: <Pine.SOL.4.10.10101061727190.28634-100000@frogger.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The IBM travelstar hd in the ibook wants a sleep command sent before poweroff.
According to the IBM docs, this orderly shutdown extends the life of some
component stressed by the emergency power fail head lifting mechanism.
It also stops that loud click that happens on linux power off.


This bit of code replaces pmu_shutdown from via-pmu.c, its the easiest
hack to get the IDE code to issue a sleep command to the disk at shutdown
time.

--conrad


void __openfirmware
pmu_shutdown(void)
{
  struct adb_request req;
  int ret;

  ret = broadcast_sleep(PBOOK_SLEEP_REQUEST, PBOOK_SLEEP_REJECT);
  if (ret != PBOOK_SLEEP_OK)
    printk("pmu: shutdown sleep rejected\n");
  fsync_dev(0);
  ret = broadcast_sleep(PBOOK_SLEEP_NOW, PBOOK_WAKE);
  if (ret != PBOOK_SLEEP_OK)
    printk("pmu: shutdown sleep failed\n");

  _disable_interrupts();

  pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, PMU_INT_ADB |
	      PMU_INT_TICK );
  while(!req.complete)
    pmu_poll();

  pmu_request(&req, NULL, 5, PMU_SHUTDOWN,
	      'M', 'A', 'T', 'T');
  while(!req.complete || (pmu_state != idle))
    pmu_poll();
  for (;;)
    ;
}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
