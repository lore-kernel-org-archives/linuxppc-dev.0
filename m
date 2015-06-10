Return-Path: <eric.dumazet@gmail.com>
Received: from mail-qc0-x22e.google.com (mail-qc0-x22e.google.com
 [IPv6:2607:f8b0:400d:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1CF21A0452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 00:44:18 +1000 (AEST)
Received: by qczw4 with SMTP id w4so18084651qcz.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 07:44:15 -0700 (PDT)
Message-ID: <1433947452.27504.9.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [RFC,v3 02/10] dpaa_eth: add support for DPAA Ethernet
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jianhua
 Xie <Jianhua.Xie@freescale.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 10 Jun 2015 07:44:12 -0700
In-Reply-To: <BL2PR03MB545CA85B1FE886FCD07DE26E6BD0@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1430319405-31280-1-git-send-email-madalin.bucur@freescale.com>
 <DM2PR0301MB086380B3D89425345562F384F3BD0@DM2PR0301MB0863.namprd03.prod.outlook.com>
 <BL2PR03MB545CA85B1FE886FCD07DE26E6BD0@BL2PR03MB545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 07:38 +0000, Madalin-Cristian Bucur wrote:
> Hi Eric,
> 
> Can you please tell us if this change would be for the better?
> 
> I was about to say yes to this request but checked and no other Ethernet driver seems to use the queue trans_start.
> I was able to find your patch "net: tx scalability works : trans_start" [ http://patchwork.ozlabs.org/patch/27104/ ] but did not find more about this topic.
>  

Drivers no longer have to worry about updating trans_start themselves.
Core networking stack handles this.

Check txq_trans_update() done from netdev_start_xmit()
