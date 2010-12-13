Return-Path: <rsarmah@apm.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	by ozlabs.org (Postfix) with SMTP id F3408B6F11
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Dec 2010 18:17:48 +1100 (EST)
Received: by wwd20 with SMTP id 20so5617408wwd.5
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Dec 2010 23:17:45 -0800 (PST)
From: Rupjyoti Sarmah <rsarmah@apm.com>
References: <201012090424.oB94O1DV006463@amcc.com>
	<20101210133905.GE1903@zod.rchland.ibm.com>
In-Reply-To: <20101210133905.GE1903@zod.rchland.ibm.com>
MIME-Version: 1.0
Date: Mon, 13 Dec 2010 12:47:43 +0530
Message-ID: <a00291ed1ff0ac93aa2c24636c068760@mail.gmail.com>
Subject: RE: [PATCH v5] ppc44x:PHY fixup for USB on canyonlands board
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>This can fail if you boot a new kernel on a board with an old FDT that
lacks the gpio node.  Calling of_iomap with a NULL np seems like it would
work without crashing anything, so maybe that's not a huge issue.

>>+	vaddr = of_iomap(np, 0);
>>+	if (!vaddr) {
>>+		printk(KERN_CRIT "Could not get gpio node address\n");
>>+		ret = -ENODEV;
>>+		goto err_bcsr;
>>+	}

>A reference count is leaked for the node in this error case because
of_node_put isn't called for the gpio node.  Also, iounmap is never called
on vaddr.

>>+	/* Disable USB, through the BCSR7 bits */


Thanks for your inputs. I will fix and resubmit.

Regards,
Rup
