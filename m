Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC244C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:23:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6FA2084C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6FA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PJHm1w6JzF3DT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:23:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PJDV5Fj3zF3F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 09:20:42 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w91NIVnm023643
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 19:20:39 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mus4tg9j3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 19:20:39 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 1 Oct 2018 17:20:38 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Oct 2018 17:20:35 -0600
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w91NKYgK33226928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Oct 2018 16:20:34 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD19778066;
 Mon,  1 Oct 2018 17:20:34 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9126D78068;
 Mon,  1 Oct 2018 17:20:31 -0600 (MDT)
Received: from oc6857751186.ibm.com (unknown [9.85.143.166])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  1 Oct 2018 17:20:31 -0600 (MDT)
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
To: Michal Hocko <mhocko@kernel.org>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 1 Oct 2018 16:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001202724.GL18290@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100123-0012-0000-0000-000016BF5EDC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009805; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096516; UDB=6.00566995; IPR=6.00876559; 
 MB=3.00023581; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 23:20:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100123-0013-0000-0000-00005499D067
Message-Id: <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-01_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010222
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/01/2018 01:27 PM, Michal Hocko wrote:
> On Mon 01-10-18 13:56:25, Michael Bringmann wrote:
>> In some LPAR migration scenarios, device-tree modifications are
>> made to the affinity of the memory in the system.  For instance,
>> it may occur that memory is installed to nodes 0,3 on a source
>> system, and to nodes 0,2 on a target system.  Node 2 may not
>> have been initialized/allocated on the target system.
>>
>> After migration, if a RTAS PRRN memory remove is made to a
>> memory block that was in node 3 on the source system, then
>> try_offline_node tries to remove it from node 2 on the target.
>> The NODE_DATA(2) block would not be initialized on the target,
>> and there is no validation check in the current code to prevent
>> the use of a NULL pointer.
> 
> I am not familiar with ppc and the above doesn't really help me
> much. Sorry about that. But from the above it is not clear to me whether
> it is the caller which does something unexpected or the hotplug code
> being not robust enough. From your changelog I would suggest the later
> but why don't we see the same problem for other archs? Is this a problem
> of unrolling a partial failure?
> 
> dlpar_remove_lmb does the following
> 
> 	nid = memory_add_physaddr_to_nid(lmb->base_addr);
> 
> 	remove_memory(nid, lmb->base_addr, block_sz);
> 
> 	/* Update memory regions for memory remove */
> 	memblock_remove(lmb->base_addr, block_sz);
> 
> 	dlpar_remove_device_tree_lmb(lmb);
> 
> Is the whole operation correct when remove_memory simply backs off
> silently. Why don't we have to care about memblock resp
> dlpar_remove_device_tree_lmb parts? In other words how come the physical
> memory range is valid while the node association is not?
> 

I think the issue here is a race between the LPM code updating affinity and PRRN events being processed. Does your other patch[1] not fix the issue? Or is it that the LPM affinity updates don't do any of the initialization/allocation you mentioned?

-Tyrel

[1] https://lore.kernel.org/linuxppc-dev/20181001185603.11373.61650.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com/T/#u

