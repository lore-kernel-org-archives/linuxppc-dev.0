Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D73C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 16:47:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D10213A2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2VseRIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D10213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P7W73HFMzF39s
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 02:47:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="r2VseRIs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="r2VseRIs"; 
 dkim-atps=neutral
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P7Sc1bkqzF38q
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 02:45:35 +1000 (AEST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w91Ghfla137649;
 Mon, 1 Oct 2018 16:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=9fsBPWP+263gvn6FJspeRxkx+UUCIRYhoHYZUL8IUNQ=;
 b=r2VseRIsXMFBh4J3zrXfHyQfoAFgcXtD8ngQmPN8POcgjR31Z7nn9esMQUhW4WeMPKFh
 xXlrItolVE7/kjE9tIDgSHC9oasmFaHYT8D1pvhmiRG2/rGLZA4DDO0svnfnLFOrKVen
 2qZr51dOnRhL04+qHzNjXuZ5PVsQMycaXDd1Z9Com86Pjnq0viu/5NlzlAwh0ICNBJQG
 72BXuPcCLp3fMvRLc3CNtn6wn2p4lE3jlpESptATWnEfiOnZFDSNfonS813xmiVK7w9w
 DaaJH6883X9cGVVB8nQUK8XUA98IEATwA0c9sQm6owOzGoG7oMEXUr69T1TQXDEhL6ll Kw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2120.oracle.com with ESMTP id 2mt21qrgfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Oct 2018 16:45:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w91Gj7sx014725
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Oct 2018 16:45:08 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w91Gj6eH012314;
 Mon, 1 Oct 2018 16:45:06 GMT
Received: from mwanda (/10.175.32.39) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 01 Oct 2018 09:45:05 -0700
Date: Mon, 1 Oct 2018 19:44:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Geoff Levand <geoff@infradead.org>,
 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH] powerpc: signedness bug in update_flash_db()
Message-ID: <20181001164458.GB29197@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9033
 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010160
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
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The "count < sizeof(struct os_area_db)" comparison is type promoted to
size_t so negative values of "count" are treated as very high values and
we accidentally return success instead of a negative error code.

This doesn't really change runtime much but it fixes a static checker
warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index cdbfc5cfd6f3..f5387ad82279 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -664,7 +664,7 @@ static int update_flash_db(void)
 	db_set_64(db, &os_area_db_id_rtc_diff, saved_params.rtc_diff);
 
 	count = os_area_flash_write(db, sizeof(struct os_area_db), pos);
-	if (count < sizeof(struct os_area_db)) {
+	if (count < 0 || count < sizeof(struct os_area_db)) {
 		pr_debug("%s: os_area_flash_write failed %zd\n", __func__,
 			 count);
 		error = count < 0 ? count : -EIO;
