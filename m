Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF6FCDDDF5
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 22:21:15 +1000 (EST)
Subject: Re: [RFC/PATCH] Block device for the ISS simulator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081003120305.GA2229@yoda.jdub.homelinux.org>
References: <20081003000904.0A812DDEEE@ozlabs.org>
	<20081003120305.GA2229@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 22:21:04 +1000
Message-Id: <1223036464.12264.183.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-03 at 08:03 -0400, Josh Boyer wrote:
> On Fri, Oct 03, 2008 at 10:08:42AM +1000, Benjamin Herrenschmidt wrote:
> >+static void iss_blk_setup(struct iss_blk *ib)
> >+{
> >+	unsigned long flags;
> >+	u32 stat;
> >+
> >+	pr_debug("iss_blk_setup %d\n", ib->devno);
> >+
> >+	spin_lock_irqsave(&iss_blk_reglock, flags);
> >+	out_8(iss_blk_regs->data, 0);
> >+	out_be32(&iss_blk_regs->devno, ib->devno);
> >+	out_8(&iss_blk_regs->cmd, ISS_BD_CMD_OPEN);
> >+	stat = in_be32(&iss_blk_regs->stat);
> 
> Should probably use the ioread/iowrite functions instead of raw out/in.
> Same comment throughout.

Yeah well, old habits :-)

> >+		pr_debug(" -> ending request, rc = %d\n", rc);
> >+		if (rc)
> >+			end_request(req, 0);	/* failure */
> >+		else
> >+			end_request(req, 1);	/* success */
> 
> Could possibly just do:
> 
> end_request(req, (!rc));

I knew copy/pasting from a crap driver was going to come back and bite
me :)

> of_find_node_by_path increments the refcount for that node.  Need to
> do an of_node_put when you are done.

Yup, suppose so.

> Shouldn't you unmap iss_blk_regs at this point?

Might be a good idea yeah.

Ben.
