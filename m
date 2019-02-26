Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90711C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:01:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138652173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138652173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447vTb01f2zDqP9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 21:01:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447vRg3cBdzDqNl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 20:59:27 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1Q9wcbu049962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 04:59:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qw1jme4uw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 04:59:23 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Tue, 26 Feb 2019 09:59:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Feb 2019 09:59:11 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1Q9xAUu23986250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Feb 2019 09:59:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD54552051;
 Tue, 26 Feb 2019 09:59:10 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 478D652065;
 Tue, 26 Feb 2019 09:59:10 +0000 (GMT)
Date: Tue, 26 Feb 2019 11:59:08 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: build failure of current mmotm with skiroot_defconfig
References: <20190226081224.GA11981@rapoport-lnx>
 <3844e8ab-ed20-c202-2e65-6179631b7d91@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3844e8ab-ed20-c202-2e65-6179631b7d91@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022609-4275-0000-0000-0000031413BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022609-4276-0000-0000-00003822528A
Message-Id: <20190226095908.GD11981@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-26_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=883 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260075
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 26, 2019 at 10:39:54AM +0100, Christophe Leroy wrote:
> 
> 
> Le 26/02/2019 à 09:12, Mike Rapoport a écrit :
> >Hi,
> >
> >I've encountered the following error when building skyroot_defconfig with
> >current mmotm tree:
> >
> >make CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux- ARCH=powerpc vmlinux
> >   ...
> >   CC      arch/powerpc/kernel/dbell.o
> >In file included from arch/powerpc/kernel/dbell.c:20:
> >arch/powerpc/include/asm/kvm_ppc.h: In function 'xics_on_xive':
> >arch/powerpc/include/asm/kvm_ppc.h:625:9: error: implicit declaration of function 'xive_enabled'; did you mean 'eeh_enabled'? [-Werror=implicit-function-declaration]
> >   return xive_enabled() && cpu_has_feature(CPU_FTR_HVMODE);
> >          ^~~~~~~~~~~~
> >          eeh_enabled
> 
> I can neither find the above in arch/powerpc/include/asm/kvm_ppc.h in the
> powerpc tree, nor a patch removing it.
> 
> Where does that comes from ?

It's from current mmotm, probably some merge conflict...
 
> Christophe
> 
> >cc1: all warnings being treated as errors
> >scripts/Makefile.build:278: recipe for target 'arch/powerpc/kernel/dbell.o' failed
> >make[3]: *** [arch/powerpc/kernel/dbell.o] Error 1
> >scripts/Makefile.build:493: recipe for target 'arch/powerpc/kernel' failed
> >make[2]: *** [arch/powerpc/kernel] Error 2
> >Makefile:1049: recipe for target 'arch/powerpc' failed
> >make[1]: *** [arch/powerpc] Error 2
> >
> >
> 

-- 
Sincerely yours,
Mike.

