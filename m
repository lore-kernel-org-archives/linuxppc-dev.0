Return-Path: <SRS0=V+RV=ZN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6621CC432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 10:05:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FFB2089F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 10:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FFB2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JZtZ4hwvzDr6K
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 21:05:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47JZqw6zP0zDq69
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 21:02:52 +1100 (AEDT)
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mf0FY-1hvwmC1drm-00gZGN for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov
 2019 11:02:46 +0100
Received: by mail-qt1-f171.google.com with SMTP id t8so3033693qtc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 02:02:45 -0800 (PST)
X-Gm-Message-State: APjAAAWm8NHn3mz5b5jqtU6Dj6hnGgsBDe6zCZDIGEhTLdoe4bwhSyLx
 XWvnxVewbTU8scVdpTYtqKba48jcmwAy1Xm8QsM=
X-Google-Smtp-Source: APXvYqzE9t0AKsL1ncZ+umQ6xzlJILzipFxI4dN5a7JRB94aN2AlXoeFAbsRXYBGWls5F1FUF+i6obdblOQRDjk7tOw=
X-Received: by 2002:ac8:75c4:: with SMTP id z4mr7253771qtq.142.1574330564561; 
 Thu, 21 Nov 2019 02:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20191108203435.112759-1-arnd@arndb.de>
 <20191108203435.112759-4-arnd@arndb.de>
 <fdcb510863c801f1f64448e558ee0f8ed20db418.camel@codethink.co.uk>
 <CAK8P3a3BPhX_NRFj66WyRLQUOCV-FGRjmPCgB7gqxMoK8hfywg@mail.gmail.com>
 <d82ef7b94b9c3adc4fbb4e62c17b81a868fb32d8.camel@codethink.co.uk>
In-Reply-To: <d82ef7b94b9c3adc4fbb4e62c17b81a868fb32d8.camel@codethink.co.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 21 Nov 2019 11:02:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1eZwCVMdibuPDzbSF6430yBLuoF+o-VZKX_HBWGePCqA@mail.gmail.com>
Message-ID: <CAK8P3a1eZwCVMdibuPDzbSF6430yBLuoF+o-VZKX_HBWGePCqA@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 3/8] powerpc: fix vdso32 for ppc64le
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7pxyUtkXo/l5c3yb5BNiJAXfzI1pehvnUFr06Di0dxWHRHRND9E
 roXpiHBtbdg0wqy1ZwEu9CQye+KWzCgCdAemM9sgsD2RTP18UQYp7kZDW8ZDdFaIABZ1Od8
 eRAYDsggqnNeXU+e6/3zLeQr7lWARZb5zsDncSAnz9aCkPSNZUkOBEA6YijAuNcGj3TEQAl
 NSSA9WMHPBLkECS+mP79Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:025KF60nROg=:4LwZ9ClUHTQ1orYjDainJP
 vG35EGIzcy/JutwqCCOkDV/HUaR0u02AWpuQNO/XY5Zv8C8G50QdiN2yAzGOMvs7atiPIGfdC
 D8hIx8quLPWUfF9QMsw/mXJciKXvff4+75AmrlWCOonXDhmsK9hCZRLidnpsXaSXJMsTvBoP5
 WU72A3voCzicQGoMCJ1B3b7xu4AxkqV4gpENfEQ+gG2Gf/vIoU5zwfDj9pcQlGK1GIw/lDD+r
 50lFDqRCC/LeiM1eBaxTs3duxShCIMhIfUovKOojGFSlYU+81DP732gfJROQfqJsE2/DXnvIt
 8H37dFR+EOITVYxLvzpVYr9rpT4HwmIIYfU6p9USLSMOBOlUEQ79G/dY6or/7rATDflAI5/mM
 R+Q73Jg4q2TeZbCanTxKTuNj10NUMRmxc4Wdj2z28yNlROM8W80eri0Bi50op41B1aOAM31eA
 +jer+VBiU1sXVBWgUMG+xO0pGnt4UrZss/MKys+1viNE6xOJe6ZuaaThPH3jykhLJN3gb9URf
 T4pELhEn4ZYTCAsoDnf6vOYCQWhE573wCIZnH0UPB6ivOrovRZaiOhUI24gxahFiRMDmno+Aw
 7YlzXqCfykkHCohnxTBlzHYlGAZhXpCnbdghd1dD5PI4rOIV6augUjpEXjEii/W0bXj6KQsjh
 xk7fiocd81jGGk3SifN/tLWUl9wcGTYUiMV5uLBFjpaJhJ41xYz6ze88SPQmNxjwDY+bgxLzm
 0egF8AKbQJACXz5ViFuXy9akYDSngVcTyXgt72tWek3tQi2+mVVIkaKo5nKOqMY4SY9cg0t4M
 TQ1O5Leq0AGZaAxzZBc4O5FXSlqySzRtQPI/en6Z9D5F7x40Mp6dstJG/7/KTFRNB2lzAA7zU
 j9Ynm/2AUmiRQhRCrkgg==
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
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 20, 2019 at 10:49 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Wed, 2019-11-20 at 20:35 +0100, Arnd Bergmann wrote:
> > On Wed, Nov 20, 2019 at 8:13 PM Ben Hutchings
> > <ben.hutchings@codethink.co.uk> wrote:
> > > On Fri, 2019-11-08 at 21:34 +0100, Arnd Bergmann wrote:
> > > > On little-endian 32-bit application running on 64-bit kernels,
> > > > the current vdso would read the wrong half of the xtime seconds
> > > > field. Change it to return the lower half like it does on
> > > > big-endian.
> > >
> > > ppc64le doesn't have 32-bit compat so this is only theoretical.
> >
> > That is probably true. I only looked at the kernel, which today still
> > supports compat mode for ppc64le, but I saw the patches to disable
> > it, and I don't think anyone has even attempted building user space
> > for it.
>
> COMPAT is still enabled for some reason, but VDSO32 isn't (since 4.2).

Ok, I had missed that detail. Should I just drop my patch then?

      Arnd
