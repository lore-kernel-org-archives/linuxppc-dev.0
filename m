Return-Path: <SRS0=nxP5=37=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D87C35242
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 04:10:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592F620661
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 04:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="jklE4gdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592F620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Gq7L5bHKzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 15:10:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Gq5R2YjczDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2020 15:08:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.a=rsa-sha256
 header.s=201811 header.b=jklE4gdx; dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 48Gq5Q6cPDz9s3x;
 Tue, 11 Feb 2020 15:08:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1581394123;
 bh=I1D8xdUK3isDDjs1NxNpkqQK/jyPQEZ1w0H0xbIo8Og=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=jklE4gdxW+HBrkcNwPrg672nuHl4S/5r982EVPRNogX+zCfLBjNCsXjU8rCdrH+tF
 vtOKP/4asM4wPz3rKN6quWPOvC1DI1O4+EzQKPTyCy6y//ryMsNQqymxmeggu4ml8A
 hS1q4f+NI0pvR66jQmyHkqWN1FYx9KSjZ7Px54YqTZRtjmTaDhhFK6R+QjpI2/JFlA
 pDgGXPM61fNFKtg5QYE5IsSuZBuRAsN1QoU0OM5Th0JbbIINK9BJXM42Zr33LWvPT5
 FqQx4D7LEt6rYXPijMJjcC0FuT09IkuDsadxRIPXorGp9k/xLltu4wvpsVjPdqA7Jj
 E/f2O2YVdvXnw==
Received: by neuling.org (Postfix, from userid 1000)
 id D933D2C01E7; Tue, 11 Feb 2020 15:08:42 +1100 (AEDT)
Message-ID: <467a63b4549006a62843fbb53eaa7270d34c8078.camel@neuling.org>
Subject: Re: [PATCH V5 06/14] powerpc/vas: Setup thread IRQ handler per VAS
 instance
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@linux.ibm.com>
Date: Tue, 11 Feb 2020 15:08:42 +1100
In-Reply-To: <1581311856.18705.23.camel@hbabu-laptop>
References: <1579679802.26081.6.camel@hbabu-laptop>
 <1579680639.26081.31.camel@hbabu-laptop>
 <71427c6b8d8e00461fa27e603db2012e8215f467.camel@neuling.org>
 <1581311856.18705.23.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
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
Cc: herbert@gondor.apana.org.au, npiggin@gmail.com, hch@infradead.org,
 oohall@gmail.com, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2020-02-09 at 21:17 -0800, Haren Myneni wrote:
> On Fri, 2020-02-07 at 16:57 +1100, Michael Neuling wrote:
> > >  /*
> > > + * Process CRBs that we receive on the fault window.
> > > + */
> > > +irqreturn_t vas_fault_handler(int irq, void *data)
> > > +{
> > > +	struct vas_instance *vinst =3D data;
> > > +	struct coprocessor_request_block buf, *crb;
> > > +	struct vas_window *window;
> > > +	void *fifo;
> > > +
> > > +	/*
> > > +	 * VAS can interrupt with multiple page faults. So process all
> > > +	 * valid CRBs within fault FIFO until reaches invalid CRB.
> > > +	 * NX updates nx_fault_stamp in CRB and pastes in fault FIFO.
> > > +	 * kernel retrives send window from parition send window ID
> > > +	 * (pswid) in nx_fault_stamp. So pswid should be non-zero and
> > > +	 * use this to check whether CRB is valid.
> > > +	 * After reading CRB entry, it is reset with 0's in fault FIFO.
> > > +	 *
> > > +	 * In case kernel receives another interrupt with different page
> > > +	 * fault and CRBs are processed by the previous handling, will be
> > > +	 * returned from this function when it sees invalid CRB (means 0's)=
.
> > > +	 */
> > > +	do {
> > > +		mutex_lock(&vinst->mutex);
> >=20
> > This isn't going to work.
> >=20
> > From Documentation/locking/mutex-design.rst
> >=20
> >     - Mutexes may not be used in hardware or software interrupt
> >       contexts such as tasklets and timers.
>=20
> Initially used kernel thread per VAS instance and later using IRQ
> thread.=20
>=20
> vas_fault_handler() is IRQ thread function, not IRQ handler. I thought
> we can use mutex_lock() in thread function.

Sorry, I missed it was a threaded IRQ handler, so I think is ok to use a
mutex_lock() in there.

You should run with CONFIG DEBUG_MUTEXES and CONFIG_LOCKDEP enabled to give=
 you
some more confidence.

It would be good to document how this mutex is used and document the start =
of
the function so it doesn't get changed later to a non-threaded handler.=20

Mikey
