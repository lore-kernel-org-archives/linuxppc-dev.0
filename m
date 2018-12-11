Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ACEC5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 14:30:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B875F2081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 14:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tnEg2PK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B875F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dj5R4W1CzDqpM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 01:30:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="tnEg2PK2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=oracle.com
 (client-ip=141.146.126.79; helo=aserp2130.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.b="tnEg2PK2"; 
 dkim-atps=neutral
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dj2600KtzDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 01:27:09 +1100 (AEDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBBENiOt191671;
 Tue, 11 Dec 2018 14:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=VMv7KqAqCJVbdgH3f1p4AXihfNWhiuLxU/siQj/kW20=;
 b=tnEg2PK2T7OwCnOwMLh/hddqMFksQTXoJId2I6jCAIuk8QFfUxKwAxIlhi6kmY37McPC
 cQzvwiESkP/KpvJl0v2yzeC7DNwzTz73mq0zrmRkUEl76SYjSFDJatQ+dJCEnvBlKQdl
 BH1jBlpiyRixd1FjV3lJrSIY3lzYt9QBrP8tE5CJj0iaLbAzHuRHdgkjfPjYkGr+SwdN
 1gbtRH/J6kF6t1suRVPIjv3c1gJc1ZNUagd6k0VzzEEnti2reCqQVoEoecGbJ4JDqhRR
 4EaSxgqElSK1Py8YZkJOBwGqZy5rYfSnndXoAOIBIrT2aKXEZlmm8jNIeBmXYv1Uf2YY Gg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2p83fe49cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Dec 2018 14:26:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBBEQrJs008018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Dec 2018 14:26:53 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBBEQpDO026084;
 Tue, 11 Dec 2018 14:26:51 GMT
Received: from kadam (/10.175.45.132) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 11 Dec 2018 06:26:50 -0800
Date: Tue, 11 Dec 2018 17:26:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] powerpc/ipic: Fix a bounds check in ipic_set_priority()
Message-ID: <20181211141429.GF3116@kadam>
References: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
 <87sgzchcw8.fsf@concordia.ellerman.id.au>
 <f570563c-1cc7-fecf-2ed2-58164047ec9d@c-s.fr>
 <alpine.DEB.2.20.1812060908000.5574@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1812060908000.5574@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110131
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
Cc: Kim Phillips <kim.phillips@freescale.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 06, 2018 at 09:12:12AM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 6 Dec 2018, Christophe LEROY wrote:
> 
> >
> >
> > Le 05/12/2018 à 04:26, Michael Ellerman a écrit :
> > > Hi Dan,
> > >
> > > Thanks for the patch.
> > >
> > > Dan Carpenter <dan.carpenter@oracle.com> writes:
> > > > The ipic_info[] array only has 95 elements so I have made the bounds
> > > > check smaller to prevent a read overflow.  It was Smatch that found
> > > > this issue:
> > > >
> > > >      arch/powerpc/sysdev/ipic.c:784 ipic_set_priority()
> > > >      error: buffer overflow 'ipic_info' 95 <= 127
> > > >
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > > I wasn't able to find any callers of this code.  Maybe we removed the
> > > > last one in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
> > > > host_ops interface, add set_irq_type to set IRQ sense").  So perhaps we
> > > > should just remove it.  I'm not really comfortable doing that myself,
> > > > because I don't know the code well enough and can't build test
> > > > it properly.
> > >
> > > Hah wow, last usage removed in 2006!
> > >
> > > I don't see any mention of it since then, so I'll remove it. If it
> > > breaks something we can put it back.
> > >
> > > Can smatch help us find things like this that are defined non-static but
> > > never used?
> > >
> >
> > I think we have to do that carrefully. Some of those functions might be used
> > by out-of-tree boards.
> >
> > I'm thinking especially at ipic_get_mcp_status() and ipic_set_mcp_status().
> > They are used in my 832x boards's machine check handler to know when a machine
> > check is a timeout from the 832x watchdog.
> 
> The message I have gotten in the past is that the Linux kernel doesn't
> support code that is not used in the Linux kernel.  However, if I were to
> do this, I would send the code to the individual maintainers, who
> presumably would know what is actually needed and what is not.
> 
> Perhaps a good sanity check would be if the code has been used in the
> past.  If there was a use in the past that has been removed, then perhaps
> it is more likely that the function was intended for internal kernel use
> rather than the case that you are describing.

Yeah.  That's a good idea.  I've been encouraging people who remove
"written to but not used" variables to say in the commit message
"variable foo has not been used since commit 123412341243 ("blah blah")."
It helps me review the patch as well.

regards,
dan carpenter

