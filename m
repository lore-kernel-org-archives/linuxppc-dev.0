Return-Path: <deepesh@india.tejasnetworks.com>
Received: from anche.india.tejasnetworks.com (unknown [164.164.94.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F91767B6C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 19:06:45 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by anche.india.tejasnetworks.com (*****) with ESMTP id 38EC27394A
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 08:37:20 +0000 (UTC)
Received: from anche.india.tejasnetworks.com ([127.0.0.1])
	by localhost (anche [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30709-05 for <linuxppc-dev@ozlabs.org>;
	Fri, 16 Jun 2006 14:07:18 +0530 (IST)
Received: from pop-mail (localhost [127.0.0.1])
	by anche.india.tejasnetworks.com (*****) with ESMTP id 9DEB573946
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 14:07:18 +0530 (IST)
Message-ID: <34765.192.168.90.80.1150447038.squirrel@pop-mail>
Date: Fri, 16 Jun 2006 14:07:18 +0530 (IST)
Subject: Block driver question (MPC852 with DoC)
From: deepesh@india.tejasnetworks.com
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Processor: MPC852
OS : linuxppc-2.4.20 from denx
DoC: Disk On Chip, A block device.


We are using DiskOnChip on our board. And we have got a block driver from
the vendor, which can be insmoded.

The request function of the block driver:
DeviceRequest() {
   some error checkings;
   list_add_tail(&queue,&requestsList);
   wake_up(&waitQueueHead);
}

There is an kernel thread which does the final block read-writes to the
disk on chip:

IOKernelThread() {
    while(1) {
       set_current_state(TASK_INTERRUPTIBLE);
       interruptible_sleep_on_timeout(&waitQueueHead,1);
       while(!list_empty(&requestsList)) {
          read/write to the disk;
          list_del(&queue);
       }
    }

}

The list manipulations happen in the DeviceRequest and the IOKernelThread.
Is there a potential chance of a race condition, when a timer interrupt
occurs?

Thank you,
Deepesh
