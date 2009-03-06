Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.250])
	by ozlabs.org (Postfix) with ESMTP id 19E34DDEEC
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 03:05:35 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so987158agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 08:05:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090228204622.29719.55082.stgit@localhost.localdomain>
References: <20090228204622.29719.55082.stgit@localhost.localdomain>
Date: Fri, 6 Mar 2009 09:05:33 -0700
Message-ID: <fa686aa40903060805i489d8676waad08e8263c02fe@mail.gmail.com>
Subject: Re: [PATCH] Fix Xilinx SystemACE driver to handle empty CF slot
From: Grant Likely <grant.likely@secretlab.ca>
To: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, sorry Jens.  I forgot to CC: you on this patch.

g.

On Sat, Feb 28, 2009 at 1:46 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> The SystemACE driver does not handle an empty CF slot gracefully. =A0An
> empty CF slot ends up hanging the system. =A0This patch adds a check for
> the CF state and stops trying to process requests if the slot is empty.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0drivers/block/xsysace.c | =A0 22 ++++++++++++++++++++++
> =A01 files changed, 22 insertions(+), 0 deletions(-)
>
>
> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
> index 381d686..ec5b8ca 100644
> --- a/drivers/block/xsysace.c
> +++ b/drivers/block/xsysace.c
> @@ -489,6 +489,28 @@ static void ace_fsm_dostate(struct ace_device *ace)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ace->fsm_state, ace->id_req_count);
> =A0#endif
>
> + =A0 =A0 =A0 /* Verify that there is actually a CF in the slot. =A0If no=
t, then
> + =A0 =A0 =A0 =A0* bail out back to the idle state and wake up all the wa=
iters */
> + =A0 =A0 =A0 status =3D ace_in32(ace, ACE_STATUS);
> + =A0 =A0 =A0 if ((status & ACE_STATUS_CFDETECT) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ace->fsm_state =3D ACE_FSM_STATE_IDLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ace->media_change =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_capacity(ace->gd, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(ace->dev, "No CF in slot\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Drop all pending requests */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while ((req =3D elv_next_request(ace->queue=
)) !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 end_request(req, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Drop back to IDLE state and notify waite=
rs */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ace->fsm_state =3D ACE_FSM_STATE_IDLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ace->id_result =3D -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ace->id_req_count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&ace->id_completio=
n);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ace->id_req_count--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0switch (ace->fsm_state) {
> =A0 =A0 =A0 =A0case ACE_FSM_STATE_IDLE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* See if there is anything to do */
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
