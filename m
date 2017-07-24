Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGC6f56w4zDqxb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 17:04:42 +1000 (AEST)
Date: Mon, 24 Jul 2017 10:04:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Leo Li <leoyang.li@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsl/qe: NULL dereference on error in
 ucc_of_parse_tdm()
Message-ID: <20170724070424.3rlrzh2jjqkcjxpf@mwanda>
References: <20170722073335.tb6byaaarqvloh3a@mwanda>
 <AM3PR04MB1185AD2A435269F988D3BF2291BB0@AM3PR04MB1185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM3PR04MB1185AD2A435269F988D3BF2291BB0@AM3PR04MB1185.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 24, 2017 at 02:24:14AM +0000, Qiang Zhao wrote:
> On Sat 7/22/2017 3:34 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Saturday, July 22, 2017 3:34 PM
> > To: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: Leo Li <leoyang.li@nxp.com>; linuxppc-dev@lists.ozlabs.org; kernel-
> > janitors@vger.kernel.org
> > Subject: [PATCH 1/2] fsl/qe: NULL dereference on error in ucc_of_parse_tdm()
> > 
> > If "pdev = of_find_device_by_node(np2);" fails then it would lead to a NULL
> > dereference.  This function is called from probe() and we're using managed
> > resources so we can just return without doing a manual cleanup.
> 
> You mean it will be cleaned up automatically?

Yes.  At module unload.

regards,
dan carpenter
