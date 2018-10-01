Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21432C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:08:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FE12146D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uwvaarJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FE12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PBdk3V9zzF3BG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 05:08:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="uwvaarJQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="uwvaarJQ"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PBbF5T2HzDrF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 05:06:33 +1000 (AEST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w91IxRRK072891;
 Mon, 1 Oct 2018 19:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=nOrXBcxiH7o8IOY92reaOwOlplWC91LxIh+RSHkxads=;
 b=uwvaarJQ+zr1fgpcqfjZ6L/MjH/jyxolkPv6Mj0JHrf1nGJa+sIcUhyju7f5JLpoxQFl
 Aq41m2USyiBOrhcso+VS1u5u+U5SRk18YwFN3/O1Kjr5E5mhK0YvkrfYarRFaruSXxrW
 H55XX5SFFTpXNwxAIQnR7v7N3sVS1HPhRFt6rKQ/WRXh4MpMlfJvBwbTSjcoIC6wMaEH
 HXPY+Ep0c/QQ4xvzS12sdh+pFwXSRoXCNPcedZTvkVwV4TbNQRCt1aeYQy5ciK9TpDE0
 2IPFYGBwcIDd3ZkxhHj4+R/13kUsoSq5Gu4X4afLDFil8OVuw8U7qDtZtLbK3HMa1uIw 6Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp2120.oracle.com with ESMTP id 2mt21qsbsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Oct 2018 19:06:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w91J6EHY027568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Oct 2018 19:06:15 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w91J6EqZ016086;
 Mon, 1 Oct 2018 19:06:14 GMT
Received: from mwanda (/197.232.248.111)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 01 Oct 2018 12:06:14 -0700
Date: Mon, 1 Oct 2018 22:06:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: signedness bug in update_flash_db()
Message-ID: <20181001190605.tczv6hnl2zsr4br6@mwanda>
References: <20181001164458.GB29197@mwanda>
 <6fa5827e-3346-4057-ca44-c6d9758f5837@c-s.fr>
 <20181001190254.vtuop3jqh5vrvwtq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181001190254.vtuop3jqh5vrvwtq@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9033
 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010181
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
Cc: Geoff Levand <geoff@infradead.org>,
 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 01, 2018 at 10:02:54PM +0300, Dan Carpenter wrote:
> On Mon, Oct 01, 2018 at 08:22:01PM +0200, christophe leroy wrote:
> > 
> > 
> > Le 01/10/2018 à 18:44, Dan Carpenter a écrit :
> > > The "count < sizeof(struct os_area_db)" comparison is type promoted to
> > > size_t so negative values of "count" are treated as very high values and
> > > we accidentally return success instead of a negative error code.
> > > 
> > > This doesn't really change runtime much but it fixes a static checker
> > > warning.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
> > > index cdbfc5cfd6f3..f5387ad82279 100644
> > > --- a/arch/powerpc/platforms/ps3/os-area.c
> > > +++ b/arch/powerpc/platforms/ps3/os-area.c
> > > @@ -664,7 +664,7 @@ static int update_flash_db(void)
> > >   	db_set_64(db, &os_area_db_id_rtc_diff, saved_params.rtc_diff);
> > >   	count = os_area_flash_write(db, sizeof(struct os_area_db), pos);
> > > -	if (count < sizeof(struct os_area_db)) {
> > > +	if (count < 0 || count < sizeof(struct os_area_db)) {
> > 
> > Why not simply add a cast ? :
> > 
> > if (count < (ssize_t)sizeof(struct os_area_db)) {
> > 
> 
> There are so many ways to solve these and no accounting for taste.  Do
> you need me to resend or can you redo it yourself?
> 

Btw, I just went on vacation, and I'm not going to be back until next
week.

regards,
dan carpenter

