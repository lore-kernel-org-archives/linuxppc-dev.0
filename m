Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D3C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 21:36:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CEA2082B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 21:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CEA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439pnM5l6GzDrVW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 08:36:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439pkv2425zDrDJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 08:33:58 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB6LXrwi041317
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Dec 2018 16:33:56 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p79gdeff8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 16:33:55 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Thu, 6 Dec 2018 21:30:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Dec 2018 21:30:33 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB6LUW1u31391866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 21:30:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BB16A4059;
 Thu,  6 Dec 2018 21:30:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE2AEA4057;
 Thu,  6 Dec 2018 21:30:29 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.110])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Dec 2018 21:30:29 +0000 (GMT)
Date: Thu, 6 Dec 2018 23:30:27 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 5/6] arch: simplify several early memory allocations
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-6-git-send-email-rppt@linux.ibm.com>
 <20181203162908.GB4244@ravnborg.org>
 <20181203164920.GB26700@rapoport-lnx>
 <20181206180826.GB19166@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206180826.GB19166@ravnborg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120621-0028-0000-0000-0000032726E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120621-0029-0000-0000-000023E33A7C
Message-Id: <20181206213026.GA7479@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060180
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 06, 2018 at 07:08:26PM +0100, Sam Ravnborg wrote:
> On Mon, Dec 03, 2018 at 06:49:21PM +0200, Mike Rapoport wrote:
> > On Mon, Dec 03, 2018 at 05:29:08PM +0100, Sam Ravnborg wrote:
> > > Hi Mike.
> > > 
> > > > index c37955d..2a17665 100644
> > > > --- a/arch/sparc/kernel/prom_64.c
> > > > +++ b/arch/sparc/kernel/prom_64.c
> > > > @@ -34,16 +34,13 @@
> > > >  
> > > >  void * __init prom_early_alloc(unsigned long size)
> > > >  {
> > > > -	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
> > > > -	void *ret;
> > > > +	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
> > > >  
> > > > -	if (!paddr) {
> > > > +	if (!ret) {
> > > >  		prom_printf("prom_early_alloc(%lu) failed\n", size);
> > > >  		prom_halt();
> > > >  	}
> > > >  
> > > > -	ret = __va(paddr);
> > > > -	memset(ret, 0, size);
> > > >  	prom_early_allocated += size;
> > > >  
> > > >  	return ret;
> > > 
> > > memblock_alloc() calls memblock_alloc_try_nid().
> > > And if allocation fails then memblock_alloc_try_nid() calls panic().
> > > So will we ever hit the prom_halt() code?
> > 
> > memblock_phys_alloc_try_nid() also calls panic if an allocation fails. So
> > in either case we never reach prom_halt() code.
> 
> So we have code here we never reach - not nice.
> If the idea is to avoid relying on the panic inside memblock_alloc() then
> maybe replace it with a variant that do not call panic?
> To make it clear what happens.

My plan is to completely remove memblock variants that call panic() and
make the callers check the return value.

I've started to work on it, but with the holidays it progresses slower than
I'd like to.

Since the code here was unreachable for several year, a few more weeks
won't make real difference so I'd prefer to keep the variant with panic()
for now. 
 
> 	Sam
> 

-- 
Sincerely yours,
Mike.

