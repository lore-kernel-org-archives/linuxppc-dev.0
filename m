Date: Tue, 25 Sep 2001 10:38:15 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Solutions for Fast Software Upgrade in Linux/PPC
Message-Id: <Pine.SOL.4.20.0109251001370.4999-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am embarking on a project in which there exists a requirement to take my
embedded system (Walnut board w/ PowerPC 405GP w/ raft of PCI devices) and
allow it to perform a near-zero downtime upgrade/downgrade of
software/firmware.

Of the belief that there are very few new problems, just solutions that
aren't widely known, I have to imagine that the telecommunications carrier
equipment people have solved this problem long ago--albeit probably not
with Linux.

Does anyone know of any commercial or public solutions addressing this
problem in Linux or Linux on the PowerPC?

Anyway, there are a few solution spaces I can envision:

1. Check point all of your driver and application state, reboot, and
   hope that you can warm-start with your check pointed state quickly.

   - This means massaging the boot code, the Linux kernel, the device
     drivers, and the applications to tweak their start-up time.

   - At best, you may just quell kernel printks and disable auto-boot
     countdown in the PROM, at most, buying you a few seconds, if that. If
     it's a few seconds out of five, great. If it's a few out of twenty,
     you've got a lot of work to do--maybe you'll get there...maybe not.

2. Check point all of your driver and application state, and bring up a
   parallel set of upgraded/downgraded applications in standby mode and
   then fail over to them (w/ check-pointed state).

   - What if you're also upgrading the drivers? You've got a name space
     problem because you can have two versions of the same driver
     loaded--one for the existing and one for the new/old apps.

   - Fixing this means lots of kernel symbol hacking...ick.

   - Create a framework for your drivers that'd allow multiple
     versions. What about the Linux drivers that you'd rather not
     modify? No help there.

   - What if you are upgrading/downgrading the kernel? You're
     stuck...reboot and take the downtime hit.

3. Run a virtual machine in software. Check point all of your driver and
   application state. Bring-up the new kernel, drivers, and applications
   along side the existing ones and fail-over to them with the
   check-pointed state.

   - Poor performance for the common case of not upgrading/downgrading

   - Preventing console and Ethernet access from second virtual image
     until fail-over.

4. Run a pseudo virtual machine in hardware. Establish a second "bank" of
   DRAM, run the minimal, pseudo hardware virtual machine using the 405GPs
   OCM, memory controller base, and interrupt vector base. Then follow the
   same steps for (3).

   - Better performance over (3) possibly.

   - Is the 4KB OCM enough to run the VM? Maybe. Probably not though.

   - Very processor-specific solution. I think the 405GP is the only
     PowerPC with the OCM. Even if the 8xx, 8xxx, 7xxx, or 8xxx had it,
     it'd like be structured differently.

5. Use suspend/resume memory image.

   - With every software release, you also ship a memory image of that
     release in standby mode.

   - To upgrade/downgrade, you stream that image from flash
     (CompactFlash) into a new memory bank and then "jump" to it.

   - Creates huge resource demands for storing the image. Increases time
     and storage requirements as installed memory increases.

   - Won't likely work because "on-disk" layout (inode numbers, etc) are
     almost guaranteed to not match the system in the field.

   - Dramatically increases time to download new firmware/software.

Thoughts, comments, input would be greatly appreciated.

Regards,

Grant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
