Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E8C636CA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Jul 2021 15:30:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E066D61158
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Jul 2021 15:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E066D61158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRsVc1q5Yz3bj4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Jul 2021 01:30:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRsV66b86z2yMJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jul 2021 01:29:31 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GRsTx3TnMzB6G4;
 Sat, 17 Jul 2021 17:29:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CsnSEz9Ns0sb; Sat, 17 Jul 2021 17:29:25 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GRsTx2MlBzB6FJ;
 Sat, 17 Jul 2021 17:29:25 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id C1C925EF; Sat, 17 Jul 2021 17:34:35 +0200 (CEST)
Received: from 37-171-38-5.coucou-networks.fr
 (37-171-38-5.coucou-networks.fr [37.171.38.5]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Sat, 17 Jul 2021 17:34:35 +0200
Date: Sat, 17 Jul 2021 17:34:35 +0200
Message-ID: <20210717173435.Horde.Yjk9m3mjnYfLI-Xv6-IIdg8@messagerie.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH] ibmvfc: fix command state accounting and stale response
 detection
In-Reply-To: <20210716205220.1101150-1-tyreld@linux.ibm.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 james.bottomley@hansenpartnership.com, brking@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.ibm.com> a =C3=A9crit=C2=A0:

> Prior to commit 1f4a4a19508d ("scsi: ibmvfc: Complete commands outside
> the host/queue lock") responses to commands were completed sequentially
> with the host lock held such that a command had a basic binary state of
> active or free. It was therefore a simple affair of ensuring the
> assocaiated ibmvfc_event to a VIOS response was valid by testing that it
> was not already free. The lock relexation work to complete commands
> outside the lock inadverdently made it a trinary command state such that
> a command is either in flight, received and being completed, or
> completed and now free. This breaks the stale command detection logic as
> a command may be still marked active and been placed on the delayed
> completion list when a second stale response for the same command
> arrives. This can lead to double completions and list corruption. This
> issue was exposed by a recent VIOS regression were a missing memory
> barrier could occasionally result in the ibmvfc client receiveing a
> duplicate response for the same command.
>
> Fix the issue by introducing the atomic ibmvfc_event.active to track the
> trinary state of a command. The state is explicitly set to 1 when a
> command is successfully sent. The CRQ response handlers use
> atomic_dec_if_positive() to test for stale responses and correctly
> transition to the completion state when a active command is received.
> Finally, atomic_dec_and_test() is used to sanity check transistions
> when commands are freed as a result of a completion, or moved to the
> purge list as a result of error handling or adapter reset.
>
> Cc: stable@vger.kernel.org
> Fixes: 1f4a4a19508d ("scsi: ibmvfc: Complete commands outside the=20=20
>=20host/queue lock")
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c | 19 +++++++++++++++++--
>  drivers/scsi/ibmvscsi/ibmvfc.h |  1 +
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvf=
c.c
> index bee1bec49c09..935b01ee44b7 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -807,6 +807,13 @@ static int ibmvfc_init_event_pool(struct=20=20
>=20ibmvfc_host *vhost,
>  	for (i =3D 0; i < size; ++i) {
>  		struct ibmvfc_event *evt =3D &pool->events[i];
>
> +		/*
> +		 * evt->active states
> +		 *  1 =3D in flight
> +		 *  0 =3D being completed
> +		 * -1 =3D free/freed
> +		 */
> +		atomic_set(&evt->active, -1);
>  		atomic_set(&evt->free, 1);
>  		evt->crq.valid =3D 0x80;
>  		evt->crq.ioba =3D cpu_to_be64(pool->iu_token + (sizeof(*evt->xfer_iu) =
* i));
> @@ -1017,6 +1024,7 @@ static void ibmvfc_free_event(struct ibmvfc_event *=
evt)
>
>  	BUG_ON(!ibmvfc_valid_event(pool, evt));
>  	BUG_ON(atomic_inc_return(&evt->free) !=3D 1);
> +	BUG_ON(atomic_dec_and_test(&evt->active));

Avoid new BUG_ONs. See=20=20
https://www.kernel.org/doc/html/latest/process/deprecated.html

>
>=20 	spin_lock_irqsave(&evt->queue->l_lock, flags);
>  	list_add_tail(&evt->queue_list, &evt->queue->free);
> @@ -1072,6 +1080,12 @@ static void ibmvfc_complete_purge(struct=20=20
>=20list_head *purge_list)
>   **/
>  static void ibmvfc_fail_request(struct ibmvfc_event *evt, int error_code=
)
>  {
> +	/*
> +	 * Anything we are failing should still be active. Otherwise, it
> +	 * implies we already got a response for the command and are doing
> +	 * something bad like double completing it.
> +	 */
> +	BUG_ON(!atomic_dec_and_test(&evt->active));

Same


