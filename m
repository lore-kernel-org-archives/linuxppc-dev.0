From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Need testers with MESH SCSI
Date: Thu, 21 Dec 2000 10:33:25 +0100
Message-Id: <19341115030509.14383@192.168.1.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I need some feedback about the following change to the MESH driver. Does
it fix previously non-working configurations ? Does it break currently
working configurations ?

in drivers/scsi/mesh.c, replace the mesh_init function with:

static void mesh_init(struct mesh_state *ms)
{
    volatile struct mesh_regs *mr = ms->mesh;
    volatile struct dbdma_regs *md = ms->dma;

    udelay(100);

    /* Reset DBDMA & mask interrupts */
    out_le32(&md->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
    out_8(&mr->intr_mask, 0);

    /* Pre-reset mesh to make sure it's in an approx. sane state */
    out_8(&mr->exception, 0xff);	/* clear all exception bits */
    out_8(&mr->error, 0xff);	/* clear all error bits */
    out_8(&mr->sequence, SEQ_RESETMESH);
    (void)in_8(&mr->sequence);
    udelay(10);

    /* Reset bus */
    out_8(&mr->bus_status1, BS1_RST);
    (void)in_8(&mr->bus_status1);
    udelay(30);
    out_8(&mr->bus_status1, 0);
    (void)in_8(&mr->bus_status1);

    /* Let bus and some devices settle down (Apple) */
    mdelay(250);

    /* Reset MESH again (for real), clear any error occured during
     * bus reset
     */
    out_8(&mr->exception, 0xff);	/* clear all exception bits */
    out_8(&mr->error, 0xff);	/* clear all error bits */
    out_8(&mr->sequence, SEQ_RESETMESH);
    (void)in_8(&mr->sequence);
    udelay(10);
    out_8(&mr->sequence, SEQ_FLUSHFIFO);
    (void)in_8(&mr->sequence);
    udelay(1);

    /* Initialize the chip */
    out_8(&mr->error, 0xff);	/* clear all error bits */
    out_8(&mr->interrupt, 0xff);	/* clear all interrupt bits */
    out_8(&mr->intr_mask, INT_ERROR | INT_EXCEPTION | INT_CMDDONE);
    out_8(&mr->source_id, ms->host->this_id);
    out_8(&mr->sel_timeout, 25);	/* 250ms */
    out_8(&mr->sync_params, ASYNC_PARAMS);	 /* asynchronous initially */
}


Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
