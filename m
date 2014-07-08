Return-Path: <j-nomura@ce.jp.nec.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A92EE1A0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 20:42:41 +1000 (EST)
Received: from tyo201.gate.nec.co.jp (TYO201.gate.nec.co.jp [210.143.35.51])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53B971400B0
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2014 20:42:41 +1000 (EST)
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
To: Mike Snitzer <snitzer@redhat.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: Regression in 3.15 on POWER8 with multipath SCSI
Date: Tue, 8 Jul 2014 10:28:13 +0000
Message-ID: <11AF7C027C4C02408624617A4986078401323542@BPXM12GP.gisp.nec.co.jp>
References: <20140630103058.GA17747@iris.ozlabs.ibm.com>
 <20140701193907.GA15306@redhat.com>
In-Reply-To: <20140701193907.GA15306@redhat.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Cc: Vladimir Davydov <vdavydov@parallels.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/14 04:39, Mike Snitzer wrote:
> On Mon, Jun 30 2014 at  6:30am -0400,
> Paul Mackerras <paulus@samba.org> wrote:
>=20
>> I have a machine on which 3.15 usually fails to boot, and 3.14 boots
>> every time.  The machine is a POWER8 2-socket server with 20 cores
>> (thus 160 CPUs), 128GB of RAM, and 7 SCSI disks connected via a
>> hardware-RAID-capable adapter which appears as two IPR controllers
>> which are both connected to each disk.  I am booting from a disk that
>> has Fedora 20 installed on it.
>>
>> After over two weeks of bisections, I can finally point to the commits
>> that cause the problems.  The culprits are:
>>
>> 3e9f1be1 dm mpath: remove process_queued_ios()
>> e8099177 dm mpath: push back requests instead of queueing
>> bcccff93 kobject: don't block for each kobject_uevent
>>
>> The interesting thing is that neither e8099177 nor bcccff93 cause
>> failures on their own, but with both commits in there are failures
>> where the system will fail to find /home on some occasions.
>>
>> With 3e9f1be1 included, the system appears to be prone to a deadlock
>> condition which typically causes the boot process to hang with this
>> message showing:
>>
>> A start job is running for Monitoring of LVM2 mirror...rogress polling
>>
>> (with a [***     ] thing before it where the asterisks move back and
>> forth).
>>
>> If I revert 63d832c3 ("dm mpath: really fix lockdep warning") ,
>> 4cdd2ad7 ("dm mpath: fix lock order inconsistency in
>> multipath_ioctl"), 3e9f1be1 and bcccff93, in that order, I get a
>> kernel that will boot every time.  The first two are later commits
>> that fix some problems with 3e9f1be1 (though not the problems I am
>> seeing).
>>
>> Can anyone see any reason why e8099177 and bcccff93 would interfere
>> with each other?
>=20
> No, not seeing any obvious relation.
>=20
> But even though you listed e8099177 as a culprit you didn't list it as a
> commit you reverted.  Did you leave e8099177 simply because attempting
> to revert it fails (if you don't first revert other dm-mpath.c commits)?
>=20
> (btw, Bart Van Assche also has issues with commit e8099177 due to hangs
> during cable pull testing of mpath devices -- Bart: curious to know if
> your cable pull tests pass if you just revert bcccff93).

It seems Bart's issue has gone with the attached patch:
http://www.redhat.com/archives/dm-devel/2014-July/msg00035.html
Could you try if it makes any difference on your issue?

The problem is dm-mpath's state machine stall due to e8099177
but ioctl to the device can kick the state machine running again.
That might be related to why bcccff93 affects the reproducibility.
Also, 3e9f1be1 integrates some codes into the one which is affected
by this problem. So it makes sense why the problem becomes easier
to occur with that.

-
Jun'ichi Nomura, NEC Corporation


pg_ready() checks the current state of the multipath and may return
false even if a new IO is needed to change the state.

OTOH, if multipath_busy() returns busy, a new IO will not be sent
to multipath target and the state change won't happen. That results
in lock up.

The intent of multipath_busy() is to avoid unnecessary cycles of
dequeue + request_fn + requeue if it is known that multipath device
will requeue.

Such situation would be:
  - path group is being activated
  - there is no path and the multipath is setup to requeue if no path

This patch should fix the problem introduced as a part of this commit:
  commit e809917735ebf1b9a56c24e877ce0d320baee2ec
  dm mpath: push back requests instead of queueing

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index ebfa411..d58343e 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1620,8 +1620,9 @@ static int multipath_busy(struct dm_target *ti)
=20
 	spin_lock_irqsave(&m->lock, flags);
=20
-	/* pg_init in progress, requeue until done */
-	if (!pg_ready(m)) {
+	/* pg_init in progress or no paths available */
+	if (m->pg_init_in_progress ||
+	    (!m->nr_valid_paths && m->queue_if_no_path)) {
 		busy =3D 1;
 		goto out;
 	}=
