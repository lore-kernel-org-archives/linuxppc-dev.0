Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id B09FADE048
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:58:54 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so3222189nfd
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:58:52 -0700 (PDT)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 17:58:46 +0200
In-Reply-To: <fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	(Grant Likely's message of "Tue\, 2 Oct 2007 08\:26\:42 -0600")
Message-ID: <871wcd33ux.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> static int __devinit
 Grant> ulite_of_probe(struct of_device *op, const struct of_device_id *match)

This looks like uartlite code to me ;)

 Grant> {
 Grant>         struct resource res;
 Grant>         const unsigned int *id;
 Grant>         int irq, rc;
 Grant>         dev_dbg(&op->dev, "%s(%p, %p)\n", __FUNCTION__, op, match);
 Grant>         rc = of_address_to_resource(op->node, 0, &res);
 Grant>         if (rc) {
 Grant>                 dev_err(&op->dev, "invalide address\n");
 Grant>                 return rc;
 Grant>         }
 Grant>         irq = irq_of_parse_and_map(op->node, 0);
 Grant>         id = of_get_property(op->node, "port-number", NULL);
 Grant>         return ulite_assign(&op->dev, id ? *id : -1, res.start, irq);
 Grant> }

 Grant> What advantages do you see with the constructor approach?

One advantage is that it keeps the of stuff out of the drivers. There
already is one bus for platform stuff in the kernel, so from a device
driver writer POV the of stuff is just extra fluff. Imagine the ARM or
MIPS people coming up with 2 other incompatible ways of doing this and
you'll see the drivers bloat.

E.G. I use the smsc911x.c network driver on powerpc which is written
by an ARM guy. Why should he need to care about of stuff in his driver?

-- 
Bye, Peter Korsgaard
