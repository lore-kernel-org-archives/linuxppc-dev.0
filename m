From: Wolfgang Haeuptli <whaeuptli@bluewin.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: scsi-experts needed: target aborted
Date: Sun, 25 Jun 2000 23:35:40 +0200
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00062523582400.00479@lobo.localnet>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello dev-list

I was never able to access my scanner (UMAX astra 1200S, scsi).

mesh reports: target 6 aborted, interrupt in idle phase ?

Some time ago, somebody posted a patch (see end of message) to enable
scsi-debugging, which miraculously makes the scanner get recognized by the
kernel and work (partly) with SANE...
I had to disabled the patch again, because my log file (and the console) got
filled up with tons of debug infos.

Now my question to scsi-cracks:
Why does the device only gets registered with debugging enabled (no other
changes to mesh), and , even more important for me: What changes to mesh.c
would let me use the device without overloading my system with debugging infos?

Any hints greatly appreciated

Wolfgang

(System: kernel 2.2.15pre19 on a Performa 6400)

this is the patch that enables debugging and lets the kernel register the
device (which should NOT be related anyhow ???):
- --- linux/drivers/scsi/mesh.c.bak      Mon Apr  3 01:15:48 2000
+++ linux/drivers/scsi/mesh.c    Mon Apr  3 01:15:56 2000
@@ -61,7 +61,7 @@

 int mesh_sync_targets = 0xff;   /* targets to set synchronous (bitmap) */
 int mesh_resel_targets = 0xff;  /* targets that we let disconnect (bitmap) */
- -int mesh_debug_targets = 0;   /* print debug for these targets */
+int mesh_debug_targets = 64;    /* print debug for these targets */
 unsigned char use_active_neg = 0;  /* bit mask for SEQ_ACTIVE_NEG if used */

 #define ALLOW_SYNC(tgt)                 ((mesh_sync_targets >> (tgt)) & 1)
@@ -1584,7 +1584,7 @@
         volatile struct mesh_regs *mr = ms->mesh;
         int intr;

- -#if 0
+#if 1
         if (ALLOW_DEBUG(ms->conn_tgt))
                 printk(KERN_DEBUG "mesh_intr, bs0=%x int=%x exc=%x err=%x "
                            "phase=%d msgphase=%d\n", mr->bus_status0,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
