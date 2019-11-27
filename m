Return-Path: <SRS0=SG0q=ZT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15081C432C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 12:23:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876252070B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 12:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876252070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47NKgD6fBhzDqvr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 23:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.75.26; helo=8.mo179.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 62 seconds by postgrey-1.36 at bilbo;
 Wed, 27 Nov 2019 23:01:00 AEDT
Received: from 8.mo179.mail-out.ovh.net (8.mo179.mail-out.ovh.net
 [46.105.75.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47NK9S6BQwzDqsQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2019 23:00:55 +1100 (AEDT)
Received: from player792.ha.ovh.net (unknown [10.108.42.102])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id DCC1414D1C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2019 13:00:50 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 20358C95DC2E;
 Wed, 27 Nov 2019 12:00:44 +0000 (UTC)
Date: Wed, 27 Nov 2019 13:00:42 +0100
From: Greg Kurz <groug@kaod.org>
To: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [Very RFC 40/46] powernv/npu: Don't drop refcount when looking
 up GPU pci_devs
Message-ID: <20191127130042.0857c253@bahia.w3ibm.bluemix.net>
In-Reply-To: <CAOSf1CGjyqOezi0aeyUc3C7mKNtu6WdW1g99nRwDHfDKqt_aHQ@mail.gmail.com>
References: <20191120012859.23300-1-oohall@gmail.com>
 <20191120012859.23300-41-oohall@gmail.com>
 <6bb90911-54fa-9f26-ec4d-7538f3303475@ozlabs.ru>
 <20191127092408.5a996f41@bahia.w3ibm.bluemix.net>
 <851d7f28-8698-ec0b-7732-423c0926ce94@linux.ibm.com>
 <20191127103354.0758b079@bahia.w3ibm.bluemix.net>
 <CAOSf1CGjyqOezi0aeyUc3C7mKNtu6WdW1g99nRwDHfDKqt_aHQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7309905145566370102
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeihedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 27 Nov 2019 20:40:00 +1100
"Oliver O'Halloran" <oohall@gmail.com> wrote:

> On Wed, Nov 27, 2019 at 8:34 PM Greg Kurz <groug@kaod.org> wrote:
> >
> >
> > If everyone is ok with leaking a reference in the NPU case, I guess
> > this isn't a problem. But if we move forward with Oliver's patch, a
> > pci_dev_put() would be needed for OpenCAPI, correct ?
> 
> Yes, but I think that's fair enough. By convention it's the callers
> responsibility to drop the ref when it calls a function that returns a
> refcounted object. Doing anything else creates a race condition since
> the object's count could drop to zero before the caller starts using
> it.
> 

Sure, you're right, especially with Frederic's patch that drops
the pci_dev_get(dev) in pnv_ioda_setup_dev_PE().

> Oliver

