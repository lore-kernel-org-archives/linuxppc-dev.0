Return-Path: <SRS0=m3RD=33=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D4C2D0B1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 05:58:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD16D2082E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 05:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="KK2oJUJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD16D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48DPjv5JVgzDqjg
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 16:58:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48DPhH1kDwzDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2020 16:57:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.a=rsa-sha256
 header.s=201811 header.b=KK2oJUJh; dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 48DPhG1j93z9sPJ;
 Fri,  7 Feb 2020 16:57:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1581055022;
 bh=iFVZIWwToD+UxnnTwmLQqVug7RUgTp+GximpZwvnZiw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=KK2oJUJhG3TqkiS8SRzXBFdukeOv0IHrXh+4v0aSZa7zDDlc8J1Emvm8yn7WNZjj5
 n9W50r/LRXFl5xxnH+caWGNlUIOTpIkQHgjMkyxNygXzOFerZCMZumBLjP+buIAp7H
 jRy/3+K14prRKTeT7sMX6/dSPCHAGDTi3Vdtct24mHWEsWIqqCPxNyiu5LhGh+5855
 PxKk9WyqVFXR14shNzgYcb2aLfk0W0ctrugHX04i2rGCFPpfEsavTQrodP/gNYUIQw
 w+zGeW4hBetNWBAwy7cExOQXYJHSmjDH4uA6h2/hEBiKCzH1/RsE9DFlJhqLLLgngI
 YyW/i98kI+ePA==
Received: by neuling.org (Postfix, from userid 1000)
 id 1A6D92C019C; Fri,  7 Feb 2020 16:57:02 +1100 (AEDT)
Message-ID: <71427c6b8d8e00461fa27e603db2012e8215f467.camel@neuling.org>
Subject: Re: [PATCH V5 06/14] powerpc/vas: Setup thread IRQ handler per VAS
 instance
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@linux.ibm.com>, mpe@ellerman.id.au
Date: Fri, 07 Feb 2020 16:57:01 +1100
In-Reply-To: <1579680639.26081.31.camel@hbabu-laptop>
References: <1579679802.26081.6.camel@hbabu-laptop>
 <1579680639.26081.31.camel@hbabu-laptop>
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


>  /*
> + * Process CRBs that we receive on the fault window.
> + */
> +irqreturn_t vas_fault_handler(int irq, void *data)
> +{
> +	struct vas_instance *vinst =3D data;
> +	struct coprocessor_request_block buf, *crb;
> +	struct vas_window *window;
> +	void *fifo;
> +
> +	/*
> +	 * VAS can interrupt with multiple page faults. So process all
> +	 * valid CRBs within fault FIFO until reaches invalid CRB.
> +	 * NX updates nx_fault_stamp in CRB and pastes in fault FIFO.
> +	 * kernel retrives send window from parition send window ID
> +	 * (pswid) in nx_fault_stamp. So pswid should be non-zero and
> +	 * use this to check whether CRB is valid.
> +	 * After reading CRB entry, it is reset with 0's in fault FIFO.
> +	 *
> +	 * In case kernel receives another interrupt with different page
> +	 * fault and CRBs are processed by the previous handling, will be
> +	 * returned from this function when it sees invalid CRB (means 0's).
> +	 */
> +	do {
> +		mutex_lock(&vinst->mutex);

This isn't going to work.

From Documentation/locking/mutex-design.rst

    - Mutexes may not be used in hardware or software interrupt
      contexts such as tasklets and timers.

Mikey

