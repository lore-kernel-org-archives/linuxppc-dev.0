Date: Wed, 2 Jun 1999 10:47:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: MESH problems in 2.2.x
Message-ID: <Pine.LNX.4.10.9906021030230.17255-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

During boot up I now see the message:

    scsi1: device driver called scsi_done() for a syncronous reset

during SCSI probe, followed by nothing (Caps Lock still toggles the LED, so the
machine is alive).

scsi0 is sym53c875, scsi1 is mesh. Kernel is either 2.2.4 or 2.2.7.


What happens to my box: I had following devices on my SCSI chains:

  - scsi0 (sym53c875) wide chain:
      o id 0: QUANTUM VIKING II 4.5WLS (FAST-20 WIDE)
  - scsi0 (sym53c875) narrow chain:
      o id 3: PLEXTOR CD-ROM PX-12TS (FAST-10)
      o id 4: HP HP35480A (FAST-5)
      o id 5: QUANTUM FIREBALL_TM3200S (FAST-20)

  - scsi1 (mesh) narrow chain:
      o id 0: CONNER CP3040A-40mb-3.5

This worked fine with all kernels I tested (up to 2.2.7, 2.2.8 and beyond don't
boot on CHRP LongTrail, which is was investigating when the disaster mentioned
below happens). I used the Conner to boot from using Open Firmware (no OF
driver for the sym53c875).

Then the Conner died :-( To be able to boot (I can no longer boot from floppy
due to media errors, aarghl...), I moved the narrow chain from the sym875 to
the mesh, and I was able to boot an old kernel (2.1.130):

  - scsi0 (sym53c875) wide chain:
      o id 0: QUANTUM VIKING II 4.5WLS (FAST-20 WIDE)

  - scsi1 (mesh) narrow chain:
      o id 3: PLEXTOR CD-ROM PX-12TS (FAST-10)
      o id 4: HP HP35480A (FAST-5)
      o id 5: QUANTUM FIREBALL_TM3200S (FAST-20 capable running at FAST-10)

The weird thing is that 2.2.x kernels no longer boot. They hang during SCSI
probe with the message mentioned above. Then I moved most narrow devices to the
sym875 again (mesh sometimes looses arbitration when having multiple devices),
so I have my boot disk only at the mesh chain:

  - scsi0 (sym53c875) wide chain:
      o id 0: QUANTUM VIKING II 4.5WLS (FAST-20 WIDE)
  - scsi0 (sym53c875) narrow chain:
      o id 3: PLEXTOR CD-ROM PX-12TS (FAST-10)
      o id 4: HP HP35480A (FAST-5)

  - scsi1 (mesh) narrow chain:
      o id 5: QUANTUM FIREBALL_TM3200S (FAST-20 capable running at FAST-10)

Same happens: 2.1.130 works, 2.2.4 and 2.2.7 don't.

Since the message mentions `syncronous reset' and since the old Conner doesn't
seem to do synchronous mode, this makes me think the mesh driver fails with
synchronous devices in 2.2.x. Is this correct? Does anyone else see this
problem?

Well, now I have two problems to debug with 2.2.8 and above (or vger since a
few months) on my CHRP LongTrail:

  - it hangs after `instantiating rtas... done'
  - MESH hangs during probe

Happy hacking! ;-)

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
