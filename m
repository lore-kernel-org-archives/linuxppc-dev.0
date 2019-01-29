Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB797C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 19:52:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094AA2080F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 19:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094AA2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pxwM5r79zDqSn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:52:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pxtm52MhzDqMt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 06:50:40 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id x202so17171824oif.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 11:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ljOaN9//n48N7xSlzPAsPAYVwvSDCbFm8bfzLinZ3lM=;
 b=e0S83x+16JGxx1igD+4IuCH8cD21dQSjMX0JZIETRa3ccFfU3o7XwwFa8hqEevpklA
 pIob6cr2mKpqjDL0Lj8Eg4qAHifHE7lgwURSH2IxeYumXQoE6B3pYoCn0egqnkBdUBGS
 tjT+40rmWk/pEC7vYANihr5TBnHpBmre3rBqQppGIhUwdTehfKEY3XR3NauAKfvaaRbW
 ClxI7/B4RCmhZFhlumNMk7eo4ZxuKJ5BuLxD41nKt0+uC9uzHa6COgtR+rs5mb8c3rE+
 jMPyjqDNAVH98sWYr/O7A9s0M9wn3bgEMuRrCeSnnGNH23sn5SOn7rahMB9quypHbJT6
 F5SA==
X-Gm-Message-State: AJcUukf97Dkxqvr+LI0ISg4fFEtm0qx6R9vKEH3fIpbg6DDLsN9GTdDE
 av2WcjqGefShCSxPJfW0lZ4WBUvL
X-Google-Smtp-Source: ALg8bN5NXc2stqrOVEXGXPPm3b+CTitladSzf6UUgtZTM+GSFLTvimMoVpEwYzGu7giTMSBG3/U1hw==
X-Received: by 2002:aca:5807:: with SMTP id m7mr10557387oib.71.1548791438123; 
 Tue, 29 Jan 2019 11:50:38 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com.
 [209.85.210.54])
 by smtp.gmail.com with ESMTPSA id q13sm6287002ota.14.2019.01.29.11.50.37
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 11:50:37 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id s5so18992648oth.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 11:50:37 -0800 (PST)
X-Received: by 2002:a9d:8c6:: with SMTP id 64mr21227148otf.168.1548791437314; 
 Tue, 29 Jan 2019 11:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20190128090747.15851-1-mathias.thore@infinera.com>
 <6bc7e64a-b91a-cb6e-ed65-5e412cef3a76@c-s.fr>
 <DM6PR10MB37217EA1DBEFE3D5CEB5A85084960@DM6PR10MB3721.namprd10.prod.outlook.com>
 <CADRPPNS3M=j4DDMtq_Mb+Xo1M71_yM+_N7n48u-z5pSSzdBoXg@mail.gmail.com>
 <DM6PR10MB3721D7BA109A3823D9DACF1984970@DM6PR10MB3721.namprd10.prod.outlook.com>
In-Reply-To: <DM6PR10MB3721D7BA109A3823D9DACF1984970@DM6PR10MB3721.namprd10.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 29 Jan 2019 13:50:26 -0600
X-Gmail-Original-Message-ID: <CADRPPNR4wKYwi4Zwsj8ZeftnWW-EXb3gAWnUD=VqWBtqTKXfBQ@mail.gmail.com>
Message-ID: <CADRPPNR4wKYwi4Zwsj8ZeftnWW-EXb3gAWnUD=VqWBtqTKXfBQ@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 2:09 AM Mathias Thore
<Mathias.Thore@infinera.com> wrote:
>
> Is there a scenario where we are clearing the TX ring but don't want to r=
eset the BQL TX queue?

Right now the function is also used on interface open/close, driver
removal and driver resumption besides the timeout situation. I think
the reseting BQL queue is either not neccessary or already called
explicitly for the other scenarios.

>
> I think it makes sense to keep it in ucc_geth_free_tx since the reason it=
 is needed isn't the timeout per se, but rather the clearing of the TX ring=
. This way, it will be performed no matter why the driver ends up calling t=
his function.

I don't see a consensus on when netdev_reset_queue() should be called
among existing drivers.  Doing it on buffer ring cleanup probably can
be future-proofing.  But if we want to use this approach, we can
remove the redundent netdev_reset_queue() calls in open/close
functions.

Regards,
Leo

>
> -----Original Message-----
> From: Li Yang [mailto:leoyang.li@nxp.com]
> Sent: Monday, 28 January 2019 22:37
> To: Mathias Thore <Mathias.Thore@infinera.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>; netdev@vger.kernel.org; l=
inuxppc-dev@lists.ozlabs.org; David Gounaris <David.Gounaris@infinera.com>;=
 Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> Subject: Re: [PATCH] ucc_geth: Reset BQL queue when stopping device
>
> On Mon, Jan 28, 2019 at 8:37 AM Mathias Thore <Mathias.Thore@infinera.com=
> wrote:
> >
> > Hi,
> >
> >
> > This is what we observed: there was a storm on the medium so that our c=
ontroller could not do its TX, resulting in timeout. When timeout occurs, t=
he driver clears all descriptors from the TX queue. The function called in =
this patch is used to reflect this clearing also in the BQL layer. Without =
it, the controller would get stuck, unable to perform TX, even several minu=
tes after the storm had ended. Bringing the device down and then up again w=
ould solve the problem, but this patch also solves it automatically.
>
> The explanation makes sense.  So this should only be required in the time=
out scenario instead of other clean up scenarios like device shutdown?  If =
so, it probably it will be better to be done in ucc_geth_timeout_work()?
>
> >
> >
> > Some other drivers do the same, for example e1000e driver calls netdev_=
reset_queue in its e1000_clean_tx_ring function. It is possible that other =
drivers should do the same; I have no way of verifying this.
> >
> >
> > Regards,
> >
> > Mathias
> >
> > --
> >
> >
> > From: Christophe Leroy <christophe.leroy@c-s.fr>
> > Sent: Monday, January 28, 2019 10:48 AM
> > To: Mathias Thore; leoyang.li@nxp.com; netdev@vger.kernel.org;
> > linuxppc-dev@lists.ozlabs.org; David Gounaris; Joakim Tjernlund
> > Subject: Re: [PATCH] ucc_geth: Reset BQL queue when stopping device
> >
> >
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >
> >
> > Hi,
> >
> > Le 28/01/2019 =C3=A0 10:07, Mathias Thore a =C3=A9crit :
> > > After a timeout event caused by for example a broadcast storm, when
> > > the MAC and PHY are reset, the BQL TX queue needs to be reset as
> > > well. Otherwise, the device will exhibit severe performance issues
> > > even after the storm has ended.
> >
> > What are the symptomns ?
> >
> > Is this reset needed on any network driver in that case, or is it
> > something particular for the ucc_geth ?
> > For instance, the freescale fs_enet doesn't have that reset. Should it
> > have it too ?
> >
> > Christophe
> >
> > >
> > > Co-authored-by: David Gounaris <david.gounaris@infinera.com>
> > > Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
> > > ---
> > >   drivers/net/ethernet/freescale/ucc_geth.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/ucc_geth.c
> > > b/drivers/net/ethernet/freescale/ucc_geth.c
> > > index c3d539e209ed..eb3e65e8868f 100644
> > > --- a/drivers/net/ethernet/freescale/ucc_geth.c
> > > +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> > > @@ -1879,6 +1879,8 @@ static void ucc_geth_free_tx(struct ucc_geth_pr=
ivate *ugeth)
> > >       u16 i, j;
> > >       u8 __iomem *bd;
> > >
> > > +     netdev_reset_queue(ugeth->ndev);
> > > +
> > >       ug_info =3D ugeth->ug_info;
> > >       uf_info =3D &ug_info->uf_info;
> > >
> > >
> >
