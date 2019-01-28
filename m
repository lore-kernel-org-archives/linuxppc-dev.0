Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE914C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 21:38:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55AD21738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 21:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55AD21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pNKP3509zDqPc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 08:38:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pNHm6dRCzDqMq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 08:36:52 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id v6so14407330oif.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 13:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jD4ZQtba6LhaBxtSeuPLhD26zCwfda56fLc55hMLi9g=;
 b=Poi6X/EbQWFlpOkGhKdeQjDkDWdPASkXWIBLLbdUzDzznPCY06PUHdZWqCg9t0Sgb2
 AIopw2RgYcpAXNFFibt0TBE7X/29XQ+Gqh+x+0ctfogTvEn8H1El4ls7urpUor/yBl2V
 dSES/dmj1TbpK+GHm7Hs7fAlmoo5iWe/S12RnSubmFnsG9JoRsxAKktml+OkNQ9A77LE
 TnPBt0fVyssf1DyXXZvl+VMl0zYlUecol4XRADcMRnST2H50+kNIWgvhpRBSA3utpAmW
 VO7kd6AtQr+RD3QT5Q+xvpBYizXH/+sO6ivYNbfie1IC7yiJcAb0iLQ1IMg+7DqLos+R
 nY9w==
X-Gm-Message-State: AJcUuke/vFulddbaCqwLOJmlgusMCQJe56hc12Sz7w3Tu+Je6UglNe2K
 WuBb57o5pM1ubdrVVXkZD9pgR4gZ
X-Google-Smtp-Source: ALg8bN5PN6OEl/AjUixo60jfR5fXQ39K3Y6tnwIin9dHWenFpnLD7HlLoVWtZoURCdSYiqsBW2GNsw==
X-Received: by 2002:aca:da02:: with SMTP id r2mr7067074oig.66.1548711410343;
 Mon, 28 Jan 2019 13:36:50 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com.
 [209.85.210.41])
 by smtp.gmail.com with ESMTPSA id q26sm4972855otf.73.2019.01.28.13.36.49
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 13:36:49 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 81so16063646otj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 13:36:49 -0800 (PST)
X-Received: by 2002:a9d:8c6:: with SMTP id 64mr18093765otf.168.1548711409162; 
 Mon, 28 Jan 2019 13:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20190128090747.15851-1-mathias.thore@infinera.com>
 <6bc7e64a-b91a-cb6e-ed65-5e412cef3a76@c-s.fr>
 <DM6PR10MB37217EA1DBEFE3D5CEB5A85084960@DM6PR10MB3721.namprd10.prod.outlook.com>
In-Reply-To: <DM6PR10MB37217EA1DBEFE3D5CEB5A85084960@DM6PR10MB3721.namprd10.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 28 Jan 2019 15:36:38 -0600
X-Gmail-Original-Message-ID: <CADRPPNS3M=j4DDMtq_Mb+Xo1M71_yM+_N7n48u-z5pSSzdBoXg@mail.gmail.com>
Message-ID: <CADRPPNS3M=j4DDMtq_Mb+Xo1M71_yM+_N7n48u-z5pSSzdBoXg@mail.gmail.com>
Subject: Re: [PATCH] ucc_geth: Reset BQL queue when stopping device
To: Mathias Thore <Mathias.Thore@infinera.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Gounaris <David.Gounaris@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 28, 2019 at 8:37 AM Mathias Thore
<Mathias.Thore@infinera.com> wrote:
>
> Hi,
>
>
> This is what we observed: there was a storm on the medium so that our con=
troller could not do its TX, resulting in timeout. When timeout occurs, the=
 driver clears all descriptors from the TX queue. The function called in th=
is patch is used to reflect this clearing also in the BQL layer. Without it=
, the controller would get stuck, unable to perform TX, even several minute=
s after the storm had ended. Bringing the device down and then up again wou=
ld solve the problem, but this patch also solves it automatically.

The explanation makes sense.  So this should only be required in the
timeout scenario instead of other clean up scenarios like device
shutdown?  If so, it probably it will be better to be done in
ucc_geth_timeout_work()?

>
>
> Some other drivers do the same, for example e1000e driver calls netdev_re=
set_queue in its e1000_clean_tx_ring function. It is possible that other dr=
ivers should do the same; I have no way of verifying this.
>
>
> Regards,
>
> Mathias
>
> --
>
>
> From: Christophe Leroy <christophe.leroy@c-s.fr>
> Sent: Monday, January 28, 2019 10:48 AM
> To: Mathias Thore; leoyang.li@nxp.com; netdev@vger.kernel.org; linuxppc-d=
ev@lists.ozlabs.org; David Gounaris; Joakim Tjernlund
> Subject: Re: [PATCH] ucc_geth: Reset BQL queue when stopping device
>
>
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>
>
> Hi,
>
> Le 28/01/2019 =C3=A0 10:07, Mathias Thore a =C3=A9crit :
> > After a timeout event caused by for example a broadcast storm, when
> > the MAC and PHY are reset, the BQL TX queue needs to be reset as
> > well. Otherwise, the device will exhibit severe performance issues
> > even after the storm has ended.
>
> What are the symptomns ?
>
> Is this reset needed on any network driver in that case, or is it
> something particular for the ucc_geth ?
> For instance, the freescale fs_enet doesn't have that reset. Should it
> have it too ?
>
> Christophe
>
> >
> > Co-authored-by: David Gounaris <david.gounaris@infinera.com>
> > Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
> > ---
> >   drivers/net/ethernet/freescale/ucc_geth.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/et=
hernet/freescale/ucc_geth.c
> > index c3d539e209ed..eb3e65e8868f 100644
> > --- a/drivers/net/ethernet/freescale/ucc_geth.c
> > +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> > @@ -1879,6 +1879,8 @@ static void ucc_geth_free_tx(struct ucc_geth_priv=
ate *ugeth)
> >       u16 i, j;
> >       u8 __iomem *bd;
> >
> > +     netdev_reset_queue(ugeth->ndev);
> > +
> >       ug_info =3D ugeth->ug_info;
> >       uf_info =3D &ug_info->uf_info;
> >
> >
>
