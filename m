Date: Tue, 13 Jul 1999 15:45:54 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
cc: "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Re: MESH problems in 2.2.x
In-Reply-To: <Pine.LNX.4.10.9906221455110.5853-100000@michelin.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.10.9907131538530.6336-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Jun 1999, Geert Uytterhoeven wrote:
> Since /me was stupid and told OF `boot scsi/disk@5:' (i.e. I forgot the file
> part of the path), my OF kept on enjoying autoreboot cycles with `rebooting in
> the correct mode for this client program' messages. The only thing that stopped
> this was to remove the power from the scsi/disk@5 device. This was the first
> time the power was removed since my previous mail about this.
> 
> And then I got
> 
>     scsi1: device driver called scsi_done() for a syncronous reset
> 
> again, booting 2.3.6 from vger-june15.
> 
> Fortunately I still had the working 2.1.130 kernel around. After I booted that
> first, I was able to boot my 2.3.6 kernel.
> 
> So to boot recent kernels when you have sync-capable devices on the MESH, two
> conditions have to be met:
> 
>   - boot 2.1.130 first
>   - mesh_sync_targets = 0 (setting CONFIG_SCSI_MESH_SYNC_RATE=0 doesn't work)

And subsequent reboots don't cause problems anymore. Next time the machine is
turned off, I need 2.1.130 again first before I can boot 2.3.6.

> Anyone else seeing this?

Thus not everyone is seeing this...

Just made some diff between 2.1.130 and the `broken' kernels. The following
two things make me suspicious:

Index: drivers/scsi/mesh.c
@@ -1643,6 +1643,7 @@
 static void
 mesh_completed(struct mesh_state *ms, Scsi_Cmnd *cmd)
 {
+#if 0
 	if (ms->completed_q == NULL)
 		ms->completed_q = cmd;
 	else
@@ -1651,6 +1652,9 @@
 	cmd->host_scribble = NULL;
 	queue_task(&ms->tqueue, &tq_immediate);
 	mark_bh(IMMEDIATE_BH);
+#else
+	(*cmd->scsi_done)(cmd);
+#endif
 }
 
 /*

Why did Dave (mesh.c 1.20, according to the vger CVS logs, which don't help me
much) do this?

Index: drivers/scsi/scsi_obsolete.c
@@ -354,6 +357,18 @@
     printk("In scsi_done(host = %d, result = %06x)\n", host->host_no, result);
 #endif
 
+    if(SCpnt->flags & SYNC_RESET)
+    {
+        /*
+        * The behaviou of scsi_reset(SYNC) was changed in 2.1.? .
+        * The scsi mid-layer does a REDO after every sync reset, the driver
+        * must not do that any more. In order to prevent old drivers from
+        * crashing, all scsi_done() calls during sync resets are ignored.
+        */
+        printk("scsi%d: device driver called scsi_done() "
+	       "for a syncronous reset.\n", SCpnt->host->host_no);
+        return;
+    }
     if(SCpnt->flags & WAS_SENSE)
     {
 	SCpnt->use_sg = SCpnt->old_use_sg;

And after the `return', my machine no longer does anything...

I'll try to find out which one of the two guys causes my problems...

Things are a bit difficult now, because I no longer have Internet connectivity
on my boxes. DDS 2 GB packets with high latency form my sole link now :-(

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
