Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Ramdisk Vs NFS
Date: Tue, 24 Apr 2007 20:16:48 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D762CA81@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

What is the primary difference between Ramdisk and NFS with respect to
the wait_queue's?

If I use ramdisk, every thing works fine, but with NFS (or you may read
as 'no ramdisk') kernel/sched.c:__wake_up_common() routines has a
problem. Basically the value of "&q->task_list->next" is out of our
memory range (not between 0xc0000000 and 0xF0000000), and this causes
trouble of accessing non-existing memory.=20

Interesting thing is, this happens much before we even load the ramdisk
drivers.

Appreciate if any one has some insight into this.

Thanks
Siva
